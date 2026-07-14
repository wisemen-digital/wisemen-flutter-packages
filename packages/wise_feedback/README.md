# wise_feedback

In-app bug reporting for Flutter. Capture a screenshot + title + description and file it as a Linear issue — via a pluggable transport.

## Install

```yaml
dependencies:
  wise_feedback: ^0.5.0
```

## Quick start (no backend)

```dart
WiseFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),
  child: MyApp(),
);
```

## What gets attached

By default every report includes **device, OS and app-version metadata**. Add a
navigator observer for a **breadcrumb of recent screens**, identify the
**reporter**, and let users pick a **priority** (mapped to Linear's priority) and
**category**. All of it is rendered into a `## Context` section on the Linear
issue.

```dart
final feedbackObserver = WiseFeedbackNavigatorObserver();

WiseFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),

  // Recent screens — also add feedbackObserver to MaterialApp.navigatorObservers.
  navigatorObserver: feedbackObserver,

  // Who reported it (resolved at submit time; async-friendly).
  reporter: () => FeedbackReporter(id: user.id, email: user.email),

  // Extra custom fields.
  metadataBuilder: () => {'tier': user.tier, 'flag.newNav': 'on'},

  // Form selectors.
  showPriority: true, // default
  categories: const ['Bug', 'Idea', 'Question'],

  // collectDeviceInfo: false, // opt out of automatic device metadata

  child: MyApp(),
);
```

## Localization

The built-in form and its success/error toasts are localized in **English,
Dutch and French**. The feedback UI follows the **device** locale automatically —
no setup required. To force a locale, pass `locale`:

```dart
WiseFeedback(
  transport: ...,
  locale: const Locale('nl'), // force Dutch; omit to follow the device
  child: MyApp(),
);
```

Notes:
- The **issue body** sent to your tracker stays in English regardless of locale,
  so your team sees consistent headings.
- Labels for your own custom `FeedbackField`s and `categories` are passed through
  as-is — translate those in your app.
- The feedback layer sits above `MaterialApp`, so "device locale" really means
  the **device's** locale — not your app's in-app language switcher. If users
  can switch language without changing the device locale, forward that choice
  via `WiseFeedback(locale: appLocale)`.

## Issue templates

The form's fields and the rendered issue body are driven by a
`FeedbackTemplate`. The default (`DefaultFeedbackTemplate`) is a single
description plus a context section. Use `BugReportTemplate` for a structured
bug report, or subclass `FeedbackTemplate` for your own:

```dart
WiseFeedback(
  transport: ...,
  template: const BugReportTemplate(), // Current/Desired + auto Steps/Context
  navigatorObserver: feedbackObserver, // fills "Steps to Reproduce"
  reporter: () => FeedbackReporter(email: user.email), // fills "Account or user"
  metadataBuilder: () => {'environment': env}, // fills "Environment or url"
  child: MyApp(),
);
```

`BugReportTemplate` renders:

```markdown
## Current Situation
…
## Desired Situation
…
## Steps to Reproduce
1. …
## Context
Environment or url: …
Account or user: …
Date & Time: …
```

### Tracking submission progress

The feedback overlay (and its built-in form) is dismissed as soon as a report
is submitted, so its own spinner never has time to show anything meaningful.
Surface submission progress, success, and errors yourself by listening to
`onStatusChanged`, which receives a `FeedbackStatus` for each state change:

```dart
WiseFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),
  onStatusChanged: (status) {
    switch (status) {
      case FeedbackIdle():
      case FeedbackSubmitting():
        break;
      case FeedbackSuccess(:final result):
        // Show a confirmation, e.g. with result.issueUrl.
      case FeedbackFailure(:final error):
        // Show an error based on `error`.
    }
  },
  child: MyApp(),
);
```

### Security of the no-backend path

`LinearDirectTransport` ships the token inside your app binary, which is
decompilable — a determined user can extract it. Minimize the blast radius:

- Use a **dedicated Linear bot/service account** with a **least-privilege token
  scoped to a single team**. Never use a personal API key.
- Provide the token via `--dart-define` (not committed) or fetch it at runtime.
- Rotate the token regularly.

For public App Store apps where even scoped-token exposure is unacceptable, use
the backend proxy below.

## Backend proxy (token stays off the device)

```dart
WiseFeedback(
  transport: LinearProxyTransport(
    endpoint: Uri.parse('https://api.myapp.com/feedback'),
    authHeadersProvider: () async => {'Authorization': 'Bearer ${await mySession.token()}'},
  ),
  child: MyApp(),
);
```

Your backend holds the Linear token and creates the issue. Implement an endpoint
matching this contract:

**Request** — `POST <endpoint>`, `multipart/form-data`:

| Part | Type | Notes |
|------|------|-------|
| `title` | text | Issue title |
| `description` | text | Issue description |
| `metadata` | text | JSON string (may be `{}`) |
| `screenshot` | file | `image/png`, filename `feedback.png` |

Plus any headers from `authHeadersProvider` (your app's own auth).

**Response** — `2xx` JSON:

```json
{ "issueId": "abc123", "issueUrl": "https://linear.app/your-org/issue/ABC-1" }
```

Non-2xx responses are surfaced as a `FeedbackException`.

## Opening the flow

`WiseFeedback` overlays a built-in button on top of `child` and shows it by
default. Tapping it opens the feedback flow; the button hides itself again
while the sheet is open. Set `showButton: false` to hide it (for example if
you want to trigger feedback from your own UI instead):

```dart
WiseFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),
  showButton: false,
  child: MyApp(),
);
```

Use `buttonAlignment` and `buttonBackgroundColor` to reposition or restyle the
built-in button.

## License

MIT
