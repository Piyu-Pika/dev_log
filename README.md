# 🚀 Dev Log: The Ultimate Debug Companion for Flutter

[![Pub Version](https://img.shields.io/pub/v/dev_log?style=for-the-badge)](https://pub.dev/packages/dev_log)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/Piyu-Pika/dev_log?style=for-the-badge)](https://github.com/Piyu-Pika/dev_log)

**A powerful, customizable debug logging package for Flutter with optional colors and emojis, automatic debug/release mode detection. Clean by default, beautiful when you want it.**

---

## 🤔 Why Use Dev Log?

Traditional Flutter logging solutions have limitations:

- **`print()`**: No log levels, appears in production, truncates long messages
- **`developer.log()`**: Verbose syntax, manual debug checks required  
- **Other packages**: Complex setup, heavy dependencies, or forced styling

### ✨ The Dev Log Advantage

`dev_log` provides a superior debugging experience with:

- **🎛️ Optional Visual Enhancement**: Clean by default, beautiful when enabled
- **🔒 Automatic Production Safety**: Silent in release builds, no manual checks needed
- **⚡ Simple & Powerful API**: From basic `Log.d()` to advanced customization
- **🪶 Zero Dependencies**: Lightweight with no external dependencies

---

## 🌟 Enhanced Features

- ✅ **6 Log Levels**: Verbose, Debug, Info, Warning, Error, and WTF (critical failures)
- ✅ **🎛️ Optional Emojis**: Disabled by default, enable when you want visual flair
- ✅ **🎨 Optional Colors**: Independent color control for enhanced readability
- ✅ **🔒 Auto Debug Detection**: Completely silent in release builds
- ✅ **⚙️ Full Customization**: Toggle colors, emojis, timestamps, and log levels independently
- ✅ **📱 Long Message Support**: Auto-splits for Android logcat compatibility
- ✅ **📄 Enhanced JSON Pretty Print**: Beautiful JSON formatting
- ✅ **🏷️ Custom Tags**: Organize logs for easy filtering and searching
- ✅ **🔗 Extension Methods**: Log any object with fluent `.logD()`, `.logI()` syntax
- ✅ **📍 Stack Trace Support**: Clean, readable error traces
- ✅ **🌐 Cross-Platform**: Works on all Flutter platforms
- ✅ **🪶 Zero Dependencies**: No external packages required

---

## 📦 Installation

Add to your `pubspec.yaml`:

```

dependencies:
dev_log: ^1.0.0  \# Use latest version

```

Install:

```

flutter pub get

```

---

## 🚀 Quick Start

```

import 'package:dev_log/dev_log.dart';

// Clean, professional logging (default - no emojis)
Log.v('Verbose: Detailed debugging info');
Log.d('Debug: General debugging');
Log.i('Info: Application information');
Log.w('Warning: Needs attention');
Log.e('Error: Something went wrong');
Log.wtf('Critical: System failure!');

// Short aliases for all levels
L.v('Verbose'); L.d('Debug'); L.i('Info');
L.w('Warning'); L.e('Error'); L.wtf('Critical!');

// Want emojis? Enable them!
Log.setEmojis(true);
Log.d('Debug with emoji');  // 🐛 [DEBUG] [19:45:15.123] Debug with emoji

// Extension methods work with all levels
'System ready'.logI();            // Info
'Memory low'.logW();              // Warning
'Network failed'.logE();          // Error
'System crash!'.logWtf();         // Critical

```

---

## 🎛️ Customization - Your Choice!

**Emojis are optional** - choose what works best for your team:

### Default Behavior (Clean & Professional)
```

// Clean output by default
Log.d('Debug message');
// Output: [DEBUG] [19:45:15.123] Debug message

```

### Enable Visual Enhancements
```

// Enable emojis for visual appeal
Log.setEmojis(true);
Log.d('Debug message');
// Output: 🐛 [DEBUG] [19:45:15.123] Debug message

// Independent controls
Log.setEmojis(false);   // Disable emojis
Log.setColors(false);   // Disable colors
Log.setTimestamp(false); // Hide timestamps
Log.setLogLevel(false);  // Hide log levels

// Configure all at once
Log.configure(
emojis: true,      // Optional visual flair
colors: true,      // Optional colors
timestamp: true,   // Show timestamps
logLevel: true,    // Show log levels
);

```

### Configuration Examples

```

// Professional (default)
Log.d('Clean message');
// Output: [DEBUG] [19:45:15.123] Clean message

// With emojis
Log.setEmojis(true);
Log.d('Enhanced message');
// Output: 🐛 [DEBUG] [19:45:15.123] Enhanced message

// Minimal
Log.configure(emojis: false, colors: false, timestamp: false, logLevel: false);
Log.d('Minimal message');
// Output: Minimal message

```

---

## 📚 Comprehensive Usage Examples

### All Log Levels

```

// Professional output (emojis disabled by default)
Log.v('Verbose: Starting application initialization');
Log.d('Debug: Loading user preferences');
Log.i('Info: User authentication successful');
Log.w('Warning: API response time is slow');
Log.e('Error: Failed to save user data');
Log.wtf('Critical: Database connection lost!');

// Enable emojis for visual enhancement
Log.setEmojis(true);
Log.v('Verbose with emoji');  // 💜 [VERBOSE] ...
Log.d('Debug with emoji');    // 🐛 [DEBUG] ...
Log.i('Info with emoji');     // ℹ️ [INFO] ...
Log.w('Warning with emoji');  // ⚠️ [WARN] ...
Log.e('Error with emoji');    // ❌ [ERROR] ...
Log.wtf('Critical with emoji'); // 🔥 [WTF] ...

```

### Advanced Features

```

// Enhanced JSON logging
Map<String, dynamic> userData = {
'name': 'John Doe',
'age': 30,
'preferences': {'theme': 'dark', 'notifications': true},
'permissions': ['read', 'write', 'admin']
};
Log.json(userData, 'USER_DATA');

// Long message auto-splitting
Log.long('This very long message will be automatically split...');

// Custom tags for organization
Log.d('Connection established', 'DATABASE');
Log.i('User session started', 'AUTH');
Log.w('Rate limit: 90% of quota used', 'API');
Log.e('Payment processing failed', 'PAYMENT');
Log.wtf('Security breach detected!', 'SECURITY');

// Method tracing
Log.trace('Method execution started');
Log.trace('Performance checkpoint', 'TIMING');

```

### Extension Methods Magic

```

// String interpolation with extensions
String userName = 'Alice';

// Clean professional logging (default)
'Debug: Processing login for \$userName'.logD();
'Info: User \$userName authenticated successfully'.logI('AUTH');
'Warning: User \$userName has 2 attempts left'.logW('SECURITY');
'Error: Authentication failed for \$userName'.logE('AUTH');
'Critical: Account \$userName compromised!'.logWtf('SECURITY');

// Object extensions
Map<String, dynamic> config = {
'apiUrl': 'https://api.example.com',
'timeout': 5000
};
config.logJson('CONFIG');        // Pretty JSON logging

List<String> tags = ['flutter', 'mobile'];
tags.logD('TAGS');               // List logging

String apiResponse = 'Very long API response...';
apiResponse.logLong('API_RESPONSE'); // Auto-split logging

```

---

## 🎯 Log Level Guide

| Level | Method | Default | With Emojis | Usage |
|-------|--------|---------|-------------|-------|
| **Verbose** | `Log.v()` / `L.v()` | `[VERBOSE]` | `💜 [VERBOSE]` | Detailed debugging info |
| **Debug** | `Log.d()` / `L.d()` | `[DEBUG]` | `🐛 [DEBUG]` | General debugging |
| **Info** | `Log.i()` / `L.i()` | `[INFO]` | `ℹ️ [INFO]` | Application flow |
| **Warning** | `Log.w()` / `L.w()` | `[WARN]` | `⚠️ [WARN]` | Potential issues |
| **Error** | `Log.e()` / `L.e()` | `[ERROR]` | `❌ [ERROR]` | Errors, exceptions |
| **WTF** | `Log.wtf()` / `L.wtf()` | `[WTF]` | `🔥 [WTF]` | Critical failures |

---

## 🎛️ Customization Options

| Configuration | Emojis | Colors | Output Example |
|--------------|--------|--------|----------------|
| **Default** | ❌ | ✅ | `[DEBUG] [19:45:15.123] Message` |
| **Emojis Only** | ✅ | ❌ | `🐛 [DEBUG] [19:45:15.123] Message` |
| **Colors Only** | ❌ | ✅ | `[DEBUG] [19:45:15.123] Message` (colored) |
| **Full Visual** | ✅ | ✅ | `🐛 [DEBUG] [19:45:15.123] Message` (colored) |
| **Minimal** | ❌ | ❌ | `Message` |

```

// Individual controls
Log.setEmojis(true);     // Toggle emojis
Log.setColors(false);    // Toggle colors
Log.setTimestamp(false); // Toggle timestamps
Log.setLogLevel(false);  // Toggle log levels

// Batch configuration
Log.configure(
emojis: false,    // Professional look
colors: true,     // Enhanced readability
timestamp: true,  // Timing information
logLevel: true,   // Level identification
);

```

---

## 🔒 Production Safety

The package automatically detects Flutter's debug mode using `kDebugMode`:

**In Debug Builds:**
- ✅ Full logging with optional visual enhancements
- ✅ All features active and customizable
- ✅ Beautiful console output when desired

**In Release Builds:**
- ✅ **Zero output** - completely silent
- ✅ **Zero overhead** - minimal performance impact
- ✅ **No sensitive data leaks** - automatic protection

---

## 🌐 Platform Support

Works perfectly across all Flutter platforms:

- 📱 **Android** - Full color and optional emoji support
- 📱 **iOS** - Complete feature compatibility  
- 🌐 **Web** - Browser console integration
- 💻 **Windows** - Terminal color support
- 💻 **macOS** - Native console integration
- 🐧 **Linux** - Full terminal compatibility

---

## 🚀 Performance

- **Debug Mode**: Rich features with minimal impact
- **Release Mode**: Zero overhead, completely compiled out
- **Memory**: Lightweight with no persistent storage
- **CPU**: Optimized string formatting and output

---

## 🎨 Design Philosophy

**Clean by default, beautiful when you want it:**

- **Default Experience**: Professional, clean logs without visual clutter
- **Optional Enhancement**: Enable emojis and colors when your team wants them
- **Independent Controls**: Mix and match visual elements as needed
- **Zero Configuration**: Works great out of the box
- **Full Customization**: Adapt to any team preference or environment

---

## 🤝 Contributing

We welcome contributions! Please check our [GitHub repository](https://github.com/Piyu-Pika/dev_log) for:

- 🐛 Bug reports
- 💡 Feature requests  
- 🔧 Pull requests
- 📚 Documentation improvements

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Made with ❤️ for the Flutter community - Clean by default, beautiful when you want it!**
