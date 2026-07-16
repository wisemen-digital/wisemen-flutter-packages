# Changelog

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
