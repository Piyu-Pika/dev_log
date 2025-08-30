import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// A simple flutter debug log that only prints in debug mode
/// Usage:
/// - Log.d('Debug message')
/// - Log.i('Info message')
/// - Log.w('Warning message')
/// - Log.e('Error message')
/// - Log.print('Simple print')
/// - Log.long('Very long message that needs to be split')
class Log {
  static const String _tag = 'dev log';
  static const int _maxLogLength = 1020; // Android logcat limit

  /// Simple debug print - only works in debug mode
  static void print(dynamic message) {
    if (kDebugMode) {
      final String timestamp = DateTime.now().toString().substring(11, 23);
      developer.log('[PRINT] [$timestamp] ${message.toString()}', name: _tag);
    }
  }

  /// Debug level logging
  static void d(dynamic message, [String? tag]) {
    _log(message, 'DEBUG', tag);
  }

  /// Info level logging
  static void i(dynamic message, [String? tag]) {
    _log(message, 'INFO', tag);
  }

  /// Warning level logging
  static void w(dynamic message, [String? tag]) {
    _log(message, 'WARN', tag);
  }

  /// Error level logging
  static void e(dynamic message,
      [String? tag, Object? error, StackTrace? stackTrace]) {
    _log(message, 'ERROR', tag);
    if (error != null && kDebugMode) {
      final String timestamp = DateTime.now().toString().substring(11, 23);
      developer.log('[$timestamp] Error Details: $error', name: tag ?? _tag);
    }
    if (stackTrace != null && kDebugMode) {
      final String timestamp = DateTime.now().toString().substring(11, 23);
      final String cleanStackTrace = _cleanStackTrace(stackTrace.toString());
      developer.log('[$timestamp] StackTrace:\n$cleanStackTrace',
          name: tag ?? _tag);
    }
  }

  /// Long message logging - splits long messages into chunks
  static void long(dynamic message, [String? tag]) {
    if (!kDebugMode) return;

    final String msg = message.toString();
    final String logTag = tag ?? _tag;

    if (msg.length <= _maxLogLength) {
      developer.log(msg, name: logTag);
      return;
    }

    // Split long messages
    for (int i = 0; i < msg.length; i += _maxLogLength) {
      final int end =
          (i + _maxLogLength < msg.length) ? i + _maxLogLength : msg.length;
      final String chunk = msg.substring(i, end);
      final String chunkInfo =
          '[${(i ~/ _maxLogLength) + 1}/${(msg.length / _maxLogLength).ceil()}]';
      developer.log('$chunkInfo $chunk', name: logTag);
    }
  }

  /// JSON pretty print
  static void json(dynamic jsonObject, [String? tag]) {
    if (!kDebugMode) return;

    try {
      // Simple JSON formatting for basic objects
      String jsonString;
      if (jsonObject is Map || jsonObject is List) {
        jsonString = _prettyPrintJson(jsonObject);
      } else {
        jsonString = jsonObject.toString();
      }
      long(jsonString, tag ?? 'JSON');
    } catch (e) {
      _log('Failed to format JSON: $e', 'ERROR', tag);
    }
  }

  /// Trace current method call
  static void trace([String? message, String? tag]) {
    if (!kDebugMode) return;

    try {
      final StackTrace stackTrace = StackTrace.current;
      final List<String> lines = stackTrace.toString().split('\n');

      // Find the first line that's not from this package or framework
      String traceInfo = 'Unknown caller';
      for (int i = 1; i < lines.length; i++) {
        final String line = lines[i].trim();
        if (!line.contains('dev_log.dart') &&
            !line.contains('dart-sdk') &&
            !line.contains('package:flutter/') &&
            line.contains('.dart')) {
          // Extract clean method info
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
      _log(msg, 'TRACE', tag);
    } catch (e) {
      _log(message ?? 'trace()', 'TRACE', tag);
    }
  }

  /// Private logging method
  static void _log(dynamic message, String level, String? tag) {
    if (!kDebugMode) return;

    final String logTag = tag ?? _tag;
    final String timestamp =
        DateTime.now().toString().substring(11, 23); // HH:mm:ss.mmm
    final String formattedMessage =
        '[$level] [$timestamp] ${message.toString()}';

    developer.log(formattedMessage, name: logTag);
  }

  /// Simple JSON pretty printer
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

  /// Clean up stack trace for better readability
  static String _cleanStackTrace(String stackTrace) {
    final List<String> lines = stackTrace.split('\n');
    final List<String> cleanLines = [];

    for (String line in lines) {
      // Skip internal framework lines for cleaner output
      if (line.contains('dart-sdk/lib/_internal') ||
          line.contains('package:flutter/src/') ||
          line.contains('lib/_engine/') ||
          line.contains('dart:async') ||
          line.trim().isEmpty) {
        continue;
      }

      // Keep only user code lines
      if (line.contains('.dart') &&
          (line.contains('package:') || line.contains('main.dart'))) {
        String cleanLine =
            line.replaceAll(RegExp(r'package:[^/]+/'), '').trim();
        cleanLines.add('  $cleanLine');
      }

      // Limit to most relevant lines
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

// Shorter aliases for even simpler usage
class L {
  static void d(dynamic msg, [String? tag]) => Log.d(msg, tag);
  static void i(dynamic msg, [String? tag]) => Log.i(msg, tag);
  static void w(dynamic msg, [String? tag]) => Log.w(msg, tag);
  static void e(dynamic msg,
          [String? tag, Object? error, StackTrace? stackTrace]) =>
      Log.e(msg, tag, error, stackTrace);
  static void p(dynamic msg) => Log.print(msg);
  static void long(dynamic msg, [String? tag]) => Log.long(msg, tag);
  static void json(dynamic json, [String? tag]) => Log.json(json, tag);
  static void trace([String? msg, String? tag]) => Log.trace(msg, tag);
}

/// Extension methods for even easier logging
extension LogExtension on Object? {
  /// Log this object as debug
  void logD([String? tag]) => Log.d(this, tag);

  /// Log this object as info
  void logI([String? tag]) => Log.i(this, tag);

  /// Log this object as warning
  void logW([String? tag]) => Log.w(this, tag);

  /// Log this object as error
  void logE([String? tag]) => Log.e(this, tag);

  /// Simple print log
  void logP() => Log.print(this);

  /// Log as JSON
  void logJson([String? tag]) => Log.json(this, tag);

  /// Log as long message
  void logLong([String? tag]) => Log.long(this, tag);
}
