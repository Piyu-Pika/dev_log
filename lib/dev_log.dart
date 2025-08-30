import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// A simple flutter debug log that only prints in debug mode
/// Now with optional emojis and colors!

class Log {
  static const String _tag = 'dev log';
  static const int _maxLogLength = 1020; // Android logcat limit

  // Customization options - emojis are OPTIONAL
  static bool _showEmojis = false; // 🔄 Changed to FALSE by default
  static bool _showColors = true; // Colors enabled by default
  static bool _showTimestamp = true;
  static bool _showLogLevel = true;

  // Log level configurations
  static const Map<String, Map<String, String>> _logStyles = {
    'VERBOSE': {'emoji': '💜', 'color': '\x1B[35m'}, // Magenta
    'DEBUG': {'emoji': '🐛', 'color': '\x1B[34m'}, // Blue
    'INFO': {'emoji': 'ℹ️', 'color': '\x1B[32m'}, // Green
    'WARN': {'emoji': '⚠️', 'color': '\x1B[33m'}, // Yellow
    'ERROR': {'emoji': '❌', 'color': '\x1B[31m'}, // Red
    'WTF': {'emoji': '🔥', 'color': '\x1B[31;1m'}, // Bright Red
    'PRINT': {'emoji': '📝', 'color': '\x1B[37m'}, // White
    'JSON': {'emoji': '📄', 'color': '\x1B[36m'}, // Cyan
    'TRACE': {'emoji': '🔍', 'color': '\x1B[90m'}, // Gray
  };

  static const String _colorReset = '\x1B[0m';

  // ========== CUSTOMIZATION METHODS ==========

  /// Enable/disable emojis in logs (independent of colors)
  static void setEmojis(bool enabled) => _showEmojis = enabled;

  /// Enable/disable colors in logs (independent of emojis)
  static void setColors(bool enabled) => _showColors = enabled;

  /// Enable/disable timestamps in logs
  static void setTimestamp(bool enabled) => _showTimestamp = enabled;

  /// Enable/disable log level labels
  static void setLogLevel(bool enabled) => _showLogLevel = enabled;

  /// Configure all visual options at once
  static void configure({
    bool? emojis,
    bool? colors,
    bool? timestamp,
    bool? logLevel,
  }) {
    if (emojis != null) _showEmojis = emojis;
    if (colors != null) _showColors = colors;
    if (timestamp != null) _showTimestamp = timestamp;
    if (logLevel != null) _showLogLevel = logLevel;
  }

  // ========== LOG LEVEL METHODS ==========

  /// Verbose level logging - most detailed
  static void v(dynamic message, [String? tag]) {
    _logWithStyle(message, 'VERBOSE', tag);
  }

  /// Debug level logging
  static void d(dynamic message, [String? tag]) {
    _logWithStyle(message, 'DEBUG', tag);
  }

  /// Info level logging
  static void i(dynamic message, [String? tag]) {
    _logWithStyle(message, 'INFO', tag);
  }

  /// Warning level logging
  static void w(dynamic message, [String? tag]) {
    _logWithStyle(message, 'WARN', tag);
  }

  /// Error level logging
  static void e(dynamic message,
      [String? tag, Object? error, StackTrace? stackTrace]) {
    _logWithStyle(message, 'ERROR', tag);

    if (error != null && kDebugMode) {
      final String timestamp =
          _showTimestamp ? DateTime.now().toString().substring(11, 23) : '';
      final String timePrefix = _showTimestamp ? '[$timestamp] ' : '';
      developer.log('${timePrefix}Error Details: $error', name: tag ?? _tag);
    }

    if (stackTrace != null && kDebugMode) {
      final String timestamp =
          _showTimestamp ? DateTime.now().toString().substring(11, 23) : '';
      final String timePrefix = _showTimestamp ? '[$timestamp] ' : '';
      final String cleanStackTrace = _cleanStackTrace(stackTrace.toString());
      developer.log('${timePrefix}StackTrace:\n$cleanStackTrace',
          name: tag ?? _tag);
    }
  }

  /// WTF (What a Terrible Failure) level logging - for critical failures
  static void wtf(dynamic message, [String? tag]) {
    _logWithStyle(message, 'WTF', tag);
  }

  /// Simple debug print - only works in debug mode
  static void print(dynamic message) {
    if (kDebugMode) {
      _logWithStyle(message, 'PRINT', null);
    }
  }

  // ========== EXISTING METHODS (UNCHANGED) ==========

  /// Long message logging - splits long messages into chunks
  static void long(dynamic message, [String? tag]) {
    if (!kDebugMode) return;
    final String msg = message.toString();

    if (msg.length <= _maxLogLength) {
      _logWithStyle(msg, 'DEBUG', tag);
      return;
    }

    for (int i = 0; i < msg.length; i += _maxLogLength) {
      final int end =
          (i + _maxLogLength < msg.length) ? i + _maxLogLength : msg.length;
      final String chunk = msg.substring(i, end);
      final String chunkInfo =
          '[${(i ~/ _maxLogLength) + 1}/${(msg.length / _maxLogLength).ceil()}]';
      _logWithStyle('$chunkInfo $chunk', 'DEBUG', tag);
    }
  }

  /// JSON pretty print with enhanced styling
  static void json(dynamic jsonObject, [String? tag]) {
    if (!kDebugMode) return;
    try {
      String jsonString;
      if (jsonObject is Map || jsonObject is List) {
        jsonString = _prettyPrintJson(jsonObject);
      } else {
        jsonString = jsonObject.toString();
      }
      _logWithStyle(jsonString, 'JSON', tag ?? 'JSON');
    } catch (e) {
      _logWithStyle('Failed to format JSON: $e', 'ERROR', tag);
    }
  }

  /// Enhanced trace with better formatting
  static void trace([String? message, String? tag]) {
    if (!kDebugMode) return;
    try {
      final StackTrace stackTrace = StackTrace.current;
      final List<String> lines = stackTrace.toString().split('\n');

      String traceInfo = 'Unknown caller';
      for (int i = 1; i < lines.length; i++) {
        final String line = lines[i].trim();
        if (!line.contains('dev_log.dart') &&
            !line.contains('dart-sdk') &&
            !line.contains('package:flutter/') &&
            line.contains('.dart')) {
          final RegExp regex = RegExp(r'([^/\\]+\.dart):(\d+):(\d+)\s+(.+)');
          final Match? match = regex.firstMatch(line);
          if (match != null) {
            final String file = match.group(1) ?? '';
            final String lineNum = match.group(2) ?? '';
            final String method =
                match.group(4)?.replaceAll(RegExp(r'[\[\]]'), '') ?? '';
            traceInfo = '$file:$lineNum in $method';
          }
          break;
        }
      }

      final String msg = message != null ? '$message - $traceInfo' : traceInfo;
      _logWithStyle(msg, 'TRACE', tag);
    } catch (e) {
      _logWithStyle(message ?? 'trace()', 'TRACE', tag);
    }
  }

  // ========== CORE STYLING METHOD ==========

  /// Enhanced private logging method with optional styling
  static void _logWithStyle(dynamic message, String level, String? tag) {
    if (!kDebugMode) return;

    final String logTag = tag ?? _tag;
    final Map<String, String> style = _logStyles[level] ?? _logStyles['DEBUG']!;

    // Build message components with OPTIONAL emoji
    final String emoji =
        _showEmojis ? '${style['emoji']} ' : ''; // ✨ Optional emoji
    final String color = _showColors ? style['color']! : '';
    final String colorReset = _showColors ? _colorReset : '';
    final String timestamp = _showTimestamp
        ? '[${DateTime.now().toString().substring(11, 23)}] '
        : '';
    final String levelLabel = _showLogLevel ? '[$level] ' : '';

    final String formattedMessage =
        '$color$emoji$levelLabel$timestamp$colorReset${message.toString()}';
    developer.log(formattedMessage, name: logTag);
  }

  // ========== HELPER METHODS (UNCHANGED) ==========

  /// Simple JSON pretty printer (keeping your existing implementation)
  static String _prettyPrintJson(dynamic json, [int indent = 0]) {
    final String spaces = '  ' * indent;

    if (json is Map) {
      if (json.isEmpty) return '{}';
      final StringBuffer buffer = StringBuffer('{\n');
      final List<String> keys = json.keys.map((k) => k.toString()).toList();

      for (int i = 0; i < keys.length; i++) {
        final String key = keys[i];
        final dynamic value = json[key];
        buffer.write('$spaces  "$key": ${_prettyPrintJson(value, indent + 1)}');
        if (i < keys.length - 1) buffer.write(',');
        buffer.write('\n');
      }

      buffer.write('$spaces}');
      return buffer.toString();
    } else if (json is List) {
      if (json.isEmpty) return '[]';
      final StringBuffer buffer = StringBuffer('[\n');

      for (int i = 0; i < json.length; i++) {
        buffer.write('$spaces  ${_prettyPrintJson(json[i], indent + 1)}');
        if (i < json.length - 1) buffer.write(',');
        buffer.write('\n');
      }

      buffer.write('$spaces]');
      return buffer.toString();
    } else if (json is String) {
      return '"$json"';
    } else {
      return json.toString();
    }
  }

  /// Clean up stack trace for better readability (keeping your existing implementation)
  static String _cleanStackTrace(String stackTrace) {
    final List<String> lines = stackTrace.split('\n');
    final List<String> cleanLines = [];

    for (String line in lines) {
      if (line.contains('dart-sdk/lib/_internal') ||
          line.contains('package:flutter/src/') ||
          line.contains('lib/_engine/') ||
          line.contains('dart:async') ||
          line.trim().isEmpty) {
        continue;
      }

      if (line.contains('.dart') &&
          (line.contains('package:') || line.contains('main.dart'))) {
        String cleanLine =
            line.replaceAll(RegExp(r'package:[^/]+/'), '').trim();
        cleanLines.add('  $cleanLine');
      }

      if (cleanLines.length >= 5) break;
    }

    return cleanLines.isNotEmpty
        ? cleanLines.join('\n')
        : '  No relevant trace available';
  }

  /// Enable/disable logging programmatically (overrides debug mode check)
  static bool _forceEnabled = false;
  static bool get isEnabled => kDebugMode || _forceEnabled;
  static void enable() => _forceEnabled = true;
  static void disable() => _forceEnabled = false;
}

// ========== SHORTER ALIASES ==========

class L {
  static void v(dynamic msg, [String? tag]) => Log.v(msg, tag);
  static void d(dynamic msg, [String? tag]) => Log.d(msg, tag);
  static void i(dynamic msg, [String? tag]) => Log.i(msg, tag);
  static void w(dynamic msg, [String? tag]) => Log.w(msg, tag);
  static void e(dynamic msg,
          [String? tag, Object? error, StackTrace? stackTrace]) =>
      Log.e(msg, tag, error, stackTrace);
  static void wtf(dynamic msg, [String? tag]) => Log.wtf(msg, tag);
  static void p(dynamic msg) => Log.print(msg);
  static void long(dynamic msg, [String? tag]) => Log.long(msg, tag);
  static void json(dynamic json, [String? tag]) => Log.json(json, tag);
  static void trace([String? msg, String? tag]) => Log.trace(msg, tag);
}

// ========== EXTENSION METHODS ==========

extension LogExtension on Object? {
  /// Log this object as verbose
  void logV([String? tag]) => Log.v(this, tag);

  /// Log this object as debug
  void logD([String? tag]) => Log.d(this, tag);

  /// Log this object as info
  void logI([String? tag]) => Log.i(this, tag);

  /// Log this object as warning
  void logW([String? tag]) => Log.w(this, tag);

  /// Log this object as error
  void logE([String? tag]) => Log.e(this, tag);

  /// Log this object as WTF (critical failure)
  void logWtf([String? tag]) => Log.wtf(this, tag);

  /// Simple print log
  void logP() => Log.print(this);

  /// Log as JSON
  void logJson([String? tag]) => Log.json(this, tag);

  /// Log as long message
  void logLong([String? tag]) => Log.long(this, tag);
}
