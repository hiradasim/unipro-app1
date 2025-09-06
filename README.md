# unipro_new_fixed

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Simple Web Task Manager

A lightweight web version of a task manager lives in the `simple_web`
directory and works together with a tiny Node server so multiple devices
share the same task list.

### 1. Start the task server

```
node simple_server/server.js
```

The server listens on `http://localhost:3000` and stores data in
`simple_server/tasks.json`.

### 2. Open the web client

Serve the `simple_web` directory however you like (for example,
`python3 -m http.server 8080`) and visit the served URL. The client will
communicate with the server to add, complete, and remove tasks. The task
list refreshes automatically every few seconds so all connected browsers
stay in sync.
