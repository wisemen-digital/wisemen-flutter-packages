# Changelog

## 0.3.0

- Configurable issue templates via `FeedbackTemplate`: the template defines the
  form's fields and renders the issue body.
- `DefaultFeedbackTemplate` preserves the previous behavior (single description
  + context section).
- `BugReportTemplate`: structured **Current Situation** / **Desired Situation**
  inputs, **Steps to Reproduce** filled from the navigation breadcrumb, and
  **Context** (environment, reporter, date & time) filled automatically.
- `FeedbackReport` now carries `fields` and `createdAt`.

## 0.2.0

- Automatic device/app/OS metadata attached to every report
  (`DeviceMetadataCollector`, opt out with `collectDeviceInfo: false`).
- `WiseFeedbackNavigatorObserver` attaches a breadcrumb of recent routes.
- Reporter identity via the `reporter` builder; custom fields via
  `metadataBuilder`.
- Optional priority (mapped to Linear's `priority`) and category selectors in
  the form.
- The Linear transports render a `## Context` section (reporter, category,
  priority, environment, recent screens); the proxy transport forwards the new
  fields.

## 0.1.0

- Initial release.
- `LinearFeedback` wrapper with shake and floating-button triggers.
- Built-in screenshot + title + description form.
- `LinearDirectTransport` (no-backend, direct Linear GraphQL).
- `LinearProxyTransport` (backend proxy with documented JSON contract).
- Removed `ShakeTrigger`, `FloatingButtonTrigger`, `FeedbackTrigger`, and the
  `triggers:` param — `LinearFeedback` now overlays a built-in button itself.
- Removed `LinearFeedback.of(context)`; the built-in button is shown by
  default and can be hidden via `showButton: false`.
- `WiseFeedbackTheme.primaryColor` removed; theming is now limited to
  `backgroundColor` plus the display strings.
- Extracted the submission toast into its own `FeedbackToast` /
  `FeedbackToastPresenter` classes.
- Reorganized `src/ui` into `src/screens`, `src/widgets`, and `src/theme`.
- `FeedbackStatus` is now a sealed class (`FeedbackIdle`, `FeedbackSubmitting`,
  `FeedbackSuccess`, `FeedbackFailure`) instead of an enum + class; removed
  `FeedbackSubmissionState`. `onStatusChanged` consumers can `switch` over it.
- The built-in form now surfaces submission errors through its status
  listenable rather than a local `setState`; `FeedbackFormSubmit` returns
  `Future<void>`.
- `FeedbackButton.padding`/`alignment` accept `EdgeInsetsGeometry`/
  `AlignmentGeometry` (directional support), as does
  `LinearFeedback.buttonAlignment`.
- Added `FeedbackResult.fromJson`.
