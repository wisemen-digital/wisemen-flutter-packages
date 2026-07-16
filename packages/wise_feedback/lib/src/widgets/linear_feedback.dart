import 'dart:async';

import 'package:feedback/feedback.dart' hide FeedbackController;
import 'package:flutter/material.dart';

import '../controller/feedback_controller.dart';
import '../metadata/metadata_collector.dart';
import '../metadata/wise_feedback_navigator_observer.dart';
import '../models/feedback_exception.dart';
import '../models/feedback_priority.dart';
import '../models/feedback_report.dart';
import '../models/feedback_reporter.dart';
import '../models/feedback_status.dart';
import '../screens/feedback_form.dart';
import '../template/feedback_template.dart';
import '../theme/wise_feedback_theme.dart';
import '../transport/feedback_transport.dart';
import 'feedback_button.dart';
import 'feedback_toast.dart';

/// Mount once near the app root to enable in-app bug reporting.
///
/// Wraps [child] with the screenshot capture layer, overlays a built-in
/// button (unless [showButton] is false), and files reports through
/// [transport].
class LinearFeedback extends StatefulWidget {
  /// Creates the wrapper.
  const LinearFeedback({
    required this.transport,
    required this.child,
    this.theme = const WiseFeedbackTheme(),
    this.onStatusChanged,
    this.showButton = true,
    this.buttonAlignment = Alignment.bottomRight,
    this.buttonBackgroundColor = Colors.black,
    this.collectDeviceInfo = true,
    this.metadataCollector,
    this.navigatorObserver,
    this.reporter,
    this.metadataBuilder,
    this.showPriority = true,
    this.categories,
    this.template = const DefaultFeedbackTemplate(),
    super.key,
  });

  /// Where reports are delivered.
  final FeedbackTransport transport;

  /// The app (or subtree) to wrap.
  final Widget child;

  /// Text/surface configuration for the built-in form.
  final WiseFeedbackTheme theme;

  /// Optional callback fired whenever submission status changes.
  final ValueChanged<FeedbackStatus>? onStatusChanged;

  /// Whether to overlay the built-in feedback button.
  final bool showButton;

  /// Where the built-in button sits over the app.
  final AlignmentGeometry buttonAlignment;

  /// Background color of the built-in button.
  final Color buttonBackgroundColor;

  /// Whether to attach automatic device/app/OS metadata to each report.
  final bool collectDeviceInfo;

  /// Overrides the metadata collector. Defaults to [DeviceMetadataCollector]
  /// when [collectDeviceInfo] is true.
  final MetadataCollector? metadataCollector;

  /// The navigation observer whose breadcrumb trail is attached to reports.
  ///
  /// Add the same instance to your app's `navigatorObservers`.
  final WiseFeedbackNavigatorObserver? navigatorObserver;

  /// Resolves the current reporter (e.g. the signed-in user) at submit time.
  final FutureOr<FeedbackReporter?> Function()? reporter;

  /// Supplies extra custom metadata (feature flags, tenant, ...) at submit time.
  final FutureOr<Map<String, String>> Function()? metadataBuilder;

  /// Whether the form shows a priority selector. Defaults to true.
  final bool showPriority;

  /// Category options to offer in the form, or null to hide the selector.
  final List<String>? categories;

  /// Defines the form's fields and how the issue body is rendered.
  ///
  /// Defaults to [DefaultFeedbackTemplate]. Use `BugReportTemplate` or a custom
  /// [FeedbackTemplate] for a structured layout.
  final FeedbackTemplate template;

  @override
  State<LinearFeedback> createState() => _LinearFeedbackState();
}

class _LinearFeedbackState extends State<LinearFeedback> {
  late final FeedbackController _controller =
      FeedbackController(widget.transport);
  final FeedbackToastPresenter _toasts = FeedbackToastPresenter();
  late final DeviceMetadataCollector _defaultCollector =
      DeviceMetadataCollector();

  BuildContext? _overlayContext;
  Listenable? _feedbackNotifier;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_notifyStatus);
  }

  void _notifyStatus() => widget.onStatusChanged?.call(_controller.value);

  @override
  void dispose() {
    _feedbackNotifier?.removeListener(_syncVisibility);
    _toasts.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _bindVisibility(BuildContext context) {
    final notifier = BetterFeedback.of(context);
    if (identical(_feedbackNotifier, notifier)) {
      return;
    }
    _feedbackNotifier?.removeListener(_syncVisibility);
    _feedbackNotifier = notifier;
    notifier.addListener(_syncVisibility);
  }

  void _syncVisibility() {
    final context = _overlayContext;
    if (!mounted || context == null) {
      return;
    }
    _controller.isVisible.value = BetterFeedback.of(context).isVisible;
  }

  Future<void> _handleUserFeedback(UserFeedback feedback) async {
    final extra = feedback.extra ?? const <String, dynamic>{};
    final metadata = await _collectMetadata();
    final reporter = await _resolveReporter();
    final fields = (extra['fields'] as Map?)?.map(
          (key, value) => MapEntry(key.toString(), value.toString()),
        ) ??
        const <String, String>{};
    final report = FeedbackReport(
      title: (extra['title'] as String?) ?? '',
      description: '',
      screenshotPng: feedback.screenshot,
      metadata: metadata,
      fields: fields,
      reporter: reporter,
      priority: _priorityFromName(extra['priority'] as String?),
      category: extra['category'] as String?,
      createdAt: DateTime.now(),
    );
    await _controller.submit(
      report.copyWith(description: widget.template.buildBody(report)),
    );
    final status = _controller.value;
    if (status is FeedbackFailure) {
      final error = status.error;
      if (error is FeedbackException) {
        throw error;
      }
      throw FeedbackException('Failed to send the report.', cause: error);
    }
  }

  /// Runs [body], swallowing any error (metadata collection must never block a
  /// submission).
  Future<T?> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, Object?>> _collectMetadata() async {
    final metadata = <String, Object?>{};

    final collector = widget.metadataCollector ??
        (widget.collectDeviceInfo ? _defaultCollector : null);
    if (collector != null) {
      final collected = await _guard(collector.collect);
      if (collected != null) {
        metadata.addAll(collected);
      }
    }

    final builder = widget.metadataBuilder;
    if (builder != null) {
      final custom = await _guard(() async => builder());
      if (custom != null) {
        metadata.addAll(custom);
      }
    }

    final observer = widget.navigatorObserver;
    if (observer != null && observer.breadcrumbs.isNotEmpty) {
      metadata['navigation'] = observer.breadcrumbs.join(' → ');
    }

    return metadata;
  }

  Future<FeedbackReporter?> _resolveReporter() async {
    final builder = widget.reporter;
    if (builder == null) {
      return null;
    }
    return _guard<FeedbackReporter?>(() async => builder());
  }

  FeedbackPriority _priorityFromName(String? name) {
    if (name == null) {
      return FeedbackPriority.none;
    }
    return FeedbackPriority.values.firstWhere(
      (priority) => priority.name == name,
      orElse: () => FeedbackPriority.none,
    );
  }

  Future<void> _submit(
    OnSubmit packageOnSubmit,
    String description,
    Map<String, dynamic>? extras,
  ) async {
    try {
      await packageOnSubmit(description, extras: extras);
      _toasts.show(
        _overlayContext,
        widget.theme.successMessage,
        isError: false,
      );
    } catch (error) {
      _toasts.show(
        _overlayContext,
        widget.theme.messageForError(error),
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      feedbackBuilder: (context, onSubmit, scrollController) => FeedbackForm(
        theme: widget.theme,
        status: _controller,
        scrollController: scrollController,
        fields: widget.template.fields,
        showPriority: widget.showPriority,
        categories: widget.categories,
        onSubmit: (description, {extras}) =>
            _submit(onSubmit, description, extras),
      ),
      child: Builder(
        builder: (betterFeedbackContext) {
          _overlayContext = betterFeedbackContext;
          _bindVisibility(betterFeedbackContext);
          _controller.bindShow(
            () => BetterFeedback.of(betterFeedbackContext)
                .show(_handleUserFeedback),
          );
          if (!widget.showButton) {
            return widget.child;
          }
          return Stack(
            children: [
              widget.child,
              ValueListenableBuilder<bool>(
                valueListenable: _controller.isVisible,
                builder: (context, isVisible, _) => isVisible
                    ? const SizedBox.shrink()
                    : FeedbackButton(
                        alignment: widget.buttonAlignment,
                        backgroundColor: widget.buttonBackgroundColor,
                        onPressed: _controller.show,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
