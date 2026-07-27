# Changelog

## 0.1.0

- Initial release.
- `LinearFeedback` wrapper: mount once near the app root to enable in-app bug
  reporting. Overlays a built-in feedback button, which can be hidden with
  `showButton: false`.
- Built-in form capturing a screenshot, title and description.
- `LinearDirectTransport` for filing issues straight against the Linear
  GraphQL API, and `LinearProxyTransport` for filing them through a backend
  proxy so the token stays off the device.
- Submission state exposed through `onStatusChanged` as a `FeedbackStatus`
  sealed class (`FeedbackIdle`, `FeedbackSubmitting`, `FeedbackSuccess`,
  `FeedbackFailure`) that consumers can `switch` over.
- Display strings and surface color configurable through `WiseFeedbackTheme`.
