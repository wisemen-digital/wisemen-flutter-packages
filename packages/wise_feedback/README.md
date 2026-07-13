# wise_feedback

In-app bug reporting for Flutter. Capture a screenshot + title + description and file it as a Linear issue — via a pluggable transport.

## Install

```yaml
dependencies:
  wise_feedback: ^0.1.0
```

## Quick start (no backend)

```dart
LinearFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),
  child: MyApp(),
);
```

### Tracking submission progress

The feedback overlay (and its built-in form) is dismissed as soon as a report
is submitted, so its own spinner never has time to show anything meaningful.
Surface submission progress, success, and errors yourself by listening to
`onStatusChanged`, which receives a `FeedbackStatus` for each state change:

```dart
LinearFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),
  onStatusChanged: (status) {
    // Show a snackbar/toast based on status.state, status.result, status.error.
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
LinearFeedback(
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

`LinearFeedback` overlays a built-in button on top of `child` and shows it by
default. Tapping it opens the feedback flow; the button hides itself again
while the sheet is open. Set `showButton: false` to hide it (for example if
you want to trigger feedback from your own UI instead):

```dart
LinearFeedback(
  transport: LinearDirectTransport(token: myBotToken, teamId: myTeamId),
  showButton: false,
  child: MyApp(),
);
```

Use `buttonAlignment` and `buttonBackgroundColor` to reposition or restyle the
built-in button.

## License

MIT
