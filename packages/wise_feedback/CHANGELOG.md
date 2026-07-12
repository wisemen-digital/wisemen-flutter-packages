# Changelog

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
