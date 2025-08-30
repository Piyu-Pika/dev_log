## 1.0.1

### 🚀 Major Enhancements

* **New Log Levels**: Added `Log.v()` (Verbose) and `Log.wtf()` (What a Terrible Failure) for more granular logging
* **Optional Visual Enhancements**: Added support for emojis and colors with independent toggle controls
* **Full Customization**: Complete control over log appearance with `Log.configure()` method
* **Enhanced Styling**: Beautiful, colored output with emoji support for better log recognition

### ✨ New Features

* **Emoji Support**: Optional emojis for each log level (💜 Verbose, 🐛 Debug, ℹ️ Info, ⚠️ Warning, ❌ Error, 🔥 WTF)
* **Color Support**: ANSI color codes for enhanced readability in supported terminals
* **Granular Controls**:
  - `Log.setEmojis(bool)` - Toggle emoji display
  - `Log.setColors(bool)` - Toggle color output
  - `Log.setTimestamp(bool)` - Toggle timestamp display
  - `Log.setLogLevel(bool)` - Toggle log level labels
* **Batch Configuration**: `Log.configure()` method for setting multiple options at once
* **Enhanced Extension Methods**: Added `.logV()` and `.logWtf()` extension methods
* **Improved Short Aliases**: Added `L.v()` and `L.wtf()` for new log levels

### 🎛️ Customization Options

* **Professional by Default**: Emojis disabled by default for clean, professional output
* **Visual Enhancement on Demand**: Easy enable/disable for emojis and colors
* **Flexible Styling**: Mix and match visual elements (emojis, colors, timestamps, levels)
* **Environment Adaptable**: Perfect for both professional and casual development environments

### 🔧 Technical Improvements

* **Enhanced `_logWithStyle()` Method**: Unified styling system for all log levels
* **Better Performance**: Optimized string formatting and conditional rendering
* **Improved Code Organization**: Cleaner separation of concerns in styling logic
* **Extended Platform Support**: Better color support across different terminal environments

### 📱 Enhanced Demo App

* **Comprehensive Testing**: New demo functions for all features
* **Visual Examples**: Dedicated sections for emoji controls and customization
* **Better UI**: Enhanced interface with categorized feature demonstrations
* **Real-world Examples**: More practical usage scenarios and configurations

### 🎯 Design Philosophy

* **Clean by Default**: Professional appearance without configuration
* **Beautiful When Desired**: Rich visual enhancements when enabled
* **Developer Choice**: Complete control over logging appearance
* **Zero Breaking Changes**: Fully backward compatible with v1.0.0

### 📚 Documentation Updates

* **Enhanced README**: Comprehensive examples of all customization options
* **Updated Examples**: Real-world usage patterns and best practices
* **Configuration Guide**: Detailed explanation of all visual options
* **Migration Guide**: Seamless upgrade path from v1.0.0

---

## 1.0.0

### 🎉 Initial Release

* **Debug-only Logging**: Automatic release mode detection using `kDebugMode`
* **Multiple Log Levels**: Support for debug, info, warning, and error levels
* **Long Message Auto-splitting**: Android logcat compatibility for lengthy logs
* **JSON Pretty Printing**: Beautiful formatting for complex objects
* **Custom Tag Support**: Organize logs with custom identifiers
* **Extension Methods**: Fluent API with `.logD()`, `.logI()`, etc.
* **Method Call Tracing**: Easy debugging with `Log.trace()`
* **Error Logging**: Enhanced error reporting with stack trace support
* **Short Aliases**: Concise `L` class syntax for rapid development
* **Cross-platform Compatibility**: Works on all Flutter-supported platforms
* **Zero External Dependencies**: Lightweight with only Flutter framework dependency
* **Production Safety**: Complete silence in release builds with zero overhead
