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
