# Changelog

## 0.5.0

- Renamed the entry widget `LinearFeedback` → `WiseFeedback` (the transport was
  already pluggable; the widget name no longer implies Linear).
- Localized the built-in form and toasts in **English, Dutch and French**. The
  feedback UI follows the device locale by default; override with the new
  `WiseFeedback(locale: ...)`. Issue bodies sent to the tracker stay English.
- `WiseFeedbackTheme` is now visual-only: the text fields (`sheetTitle`,
  `titleHint`, `descriptionHint`, `submitLabel`, `priorityLabel`, `categoryLabel`,
  `successMessage`, `genericErrorMessage`) were removed; wording now comes from
  localization.
- `FeedbackField.label` is now optional; built-in template fields resolve a
  localized label, and consumers provide labels (and translations) for their own
  custom fields.

## 0.4.0

- Modernized form UI (Crispy design): a header with circular close/submit
  actions, labelled inputs in soft-bordered 16px-radius boxes, and an indigo
  brand accent. All colors, radius and labels are themeable via
  `WiseFeedbackTheme`.
- Added a drag handle (grabber) and made the whole form surface (grabber,
  header, fields) drag the sheet.

## 0.3.0

- Configurable issue templates via `FeedbackTemplate`: the template defines the
  form's fields and renders the issue body.
- `DefaultFeedbackTemplate` preserves the previous behavior (single description
  + context section).
- `BugReportTemplate`: structured **Current Situation** / **Desired Situation**
  inputs, **Steps to Reproduce** filled from the navigation breadcrumb, and
  **Context** (environment, reporter, date & time) filled automatically. The
  timestamp is rendered with `intl`'s `DateFormat`; override the pattern with
  `BugReportTemplate(datePattern: ...)`.
- `FeedbackReport` now carries `fields` and `createdAt`.
- **Breaking:** `FeedbackFormSubmit` takes a single `Map<String, dynamic>` of
  form values. The old positional description argument was always empty — the
  body is assembled by the template from `fields`.

## 0.2.0

- Automatic device/app/OS metadata attached to every report
  (`DeviceMetadataCollector`, opt out with `collectDeviceInfo: false`).
- `WiseFeedbackNavigatorObserver` attaches a breadcrumb of recent routes. It
  extends auto_route's `AutoRouterObserver`, so tab switches (bottom bar taps)
  are recorded too.
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
