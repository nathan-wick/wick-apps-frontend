## Getting Started

### Installation

### Update Entry Widget

Update your application's entry widget to be a `WickWidgetApplication`:

```dart
import 'package:flutter/material.dart';
import 'package:wick_apps/wick_apps.generated.dart';

void main() {
  runApp(
    WickWidgetApplication(
      name: 'Example Application',
      navigationOptions: [],
      homeRoute: 'account',
    ),
  );
}
```

## Development Documentation

### Generate Files

There are many generated files in this package.

Files should be re-generated after making any changes.

To re-generate files, run:

```bash
dart run :generate
```

### Test Changes Locally

In your Flutter application’s `pubspec.yaml`, reference the package using a local path:

```yaml
dependencies:
  wick_apps:
    path: ../../shared/wick-apps-frontend
```

Then, run:

```bash
flutter pub get
```
