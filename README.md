# Dev Log Package

A simple, robust debug logging package for Flutter that automatically handles debug vs release mode detection. Perfect for development logging that disappears in production builds.

## Features

- ✅ **Auto Debug Detection**: Only logs in debug mode, completely silent in release
- ✅ **Simple API**: Short, memorable method names (`Log.d`, `Log.i`, `L.d`, etc.)
- ✅ **Long Message Support**: Automatically splits long messages for Android logcat
- ✅ **JSON Pretty Print**: Beautiful JSON formatting in logs
- ✅ **Custom Tags**: Organize logs with custom tags
- ✅ **Extension Methods**: Log any object with `.logD()`, `.logI()`, etc.
- ✅ **Stack Trace Support**: Easy error logging with stack traces
- ✅ **Cross Platform**: Works on all Flutter platforms
- ✅ **Zero Dependencies**: No external dependencies beyond Flutter

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  dev_log: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Quick Start

```dart
import 'package:dev_log/dev_log.dart';

// Simple logging
Log.d('Debug message');
Log.i('Info message');
Log.w('Warning message');
Log.e('Error message');

// Even shorter
L.d('Debug');
L.i('Info');

// Extension methods
'Hello World'.logD();
{'user': 'John'}.logJson();
```

## Usage Examples

### Basic Logging
```dart
Log.print('Simple print');
Log.d('Debug message');
Log.i('Info message');
Log.w('Warning message');
Log.e('Error message');
```

### Short Aliases
```dart
L.d('Debug');
L.i('Info');
L.w('Warning');
L.e('Error');
L.p('Print');
```

### Advanced Features
```dart
// Long messages (auto-split)
Log.long('Very long message that will be automatically split...');

// JSON pretty printing
Map<String, dynamic> data = {'name': 'John', 'age': 30};
Log.json(data);

// Custom tags
Log.d('Database connected', 'DB');
Log.w('Low memory', 'MEMORY');

// Method tracing
Log.trace('Method called');

// Error with stack trace
try {
  // risky operation
} catch (e, stackTrace) {
  Log.e('Operation failed', 'ERROR', e, stackTrace);
}
```

### Extension Methods
```dart
'Hello World'.logD();
userData.logJson('USER');
response.logI('API');
```

## Production Safety

The package automatically detects Flutter's debug mode using `kDebugMode`. In release builds:
- **Zero output**: No logs are printed
- **Zero overhead**: Minimal performance impact

## Platform Support

Works on all Flutter platforms: Android, iOS, Web, Windows, macOS, Linux.

## License

MIT License
