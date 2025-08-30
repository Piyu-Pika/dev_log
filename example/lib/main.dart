import 'package:flutter/material.dart';
import 'package:dev_log/dev_log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dev Log Enhanced Demo',
      home: LoggerDemo(),
    );
  }
}

class LoggerDemo extends StatelessWidget {
  const LoggerDemo({super.key});

  void _demonstrateBasicLogs() {
    // Basic logging with all levels (emojis disabled by default)
    Log.v('Verbose: Detailed debugging information');
    Log.d('Debug: General debugging message');
    Log.i('Info: Application information');
    Log.w('Warning: Something needs attention');
    Log.e('Error: Something went wrong');
    Log.wtf('WTF: Critical system failure!');
    Log.print('Simple print message');

    // Short aliases work with all levels
    L.v('Verbose with alias');
    L.d('Debug with alias');
    L.i('Info with alias');
    L.w('Warning with alias');
    L.e('Error with alias');
    L.wtf('Critical with alias');
    L.p('Print with alias');
  }

  void _demonstrateEmojiControls() {
    // Show default behavior (no emojis)
    Log.i('Default: No emojis, clean output');

    // Enable emojis
    Log.setEmojis(true);
    Log.v('With emoji: Verbose logging');
    Log.d('With emoji: Debug message');
    Log.i('With emoji: Info message');
    Log.w('With emoji: Warning message');
    Log.e('With emoji: Error message');
    Log.wtf('With emoji: Critical failure!');

    // Disable emojis again
    Log.setEmojis(false);
    Log.i('Back to clean: No emojis again');

    // Test different combinations
    Log.configure(emojis: true, colors: false);
    Log.d('Emojis ON, Colors OFF');

    Log.configure(emojis: false, colors: true);
    Log.d('Emojis OFF, Colors ON');

    Log.configure(emojis: true, colors: true);
    Log.d('Both emojis and colors ON');

    // Reset to default
    Log.configure(emojis: false, colors: true);
  }

  void _demonstrateAdvancedFeatures() {
    // Enhanced JSON logging
    final Map<String, dynamic> userData = {
      'user': 'John Doe',
      'age': 30,
      'preferences': {'theme': 'dark', 'notifications': true, 'language': 'en'},
      'tags': ['flutter', 'mobile', 'developer'],
      'metadata': {'lastLogin': '2025-08-30T19:45:00Z', 'sessionCount': 42}
    };
    Log.json(userData, 'USER_DATA');

    // Long message handling
    Log.long(
      'This is a very long message that demonstrates automatic splitting. '
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod '
      'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim '
      'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea '
      'commodo consequat. This message will be automatically split into chunks.',
    );

    // Custom tags with different log levels
    Log.v('Database connection established', 'DB');
    Log.d('Query executed successfully', 'DB');
    Log.i('User session started', 'AUTH');
    Log.w('API rate limit approaching', 'API');
    Log.e('Network connection timeout', 'NETWORK');
    Log.wtf('Database corruption detected!', 'CRITICAL');

    // Enhanced trace functionality
    Log.trace('Method execution trace');
    Log.trace('Custom trace with context', 'PERFORMANCE');
  }

  void _demonstrateExtensionMethods() {
    // String interpolation with extension methods
    String userName = 'Alice';
    int userAge = 28;

    // Test with emojis disabled (default)
    'Verbose: Starting user authentication for $userName'.logV('AUTH');
    'Debug: User $userName is ${userAge > 18 ? 'adult' : 'minor'}'.logD();
    'Info: Processing ${userName.length} character username'.logI('VALIDATION');
    'Warning: User $userName exceeded login attempts'.logW('SECURITY');
    'Error: Failed to authenticate user $userName'.logE('AUTH');
    'Critical: System compromise detected for user $userName!'
        .logWtf('SECURITY');

    // Enable emojis and test extensions
    Log.setEmojis(true);
    'With emojis: User authenticated successfully'.logI('AUTH');
    'With emojis: Critical error detected'.logWtf('SYSTEM');

    // Object extensions
    Map<String, dynamic> config = {
      'apiUrl': 'https://api.example.com',
      'timeout': 5000,
      'retries': 3
    };

    config.logJson('CONFIG');

    List<String> permissions = ['read', 'write', 'admin'];
    permissions.logD('PERMISSIONS');

    // Long message extension
    String apiResponse = 'Very long API response that needs to be split: ' * 30;
    apiResponse.logLong('API_RESPONSE');

    // Reset emojis to default (off)
    Log.setEmojis(false);
  }

  void _demonstrateCustomization() {
    Log.i('=== Testing Customization Options ===');

    // Test 1: Default (no emojis, with colors)
    Log.i('Test 1: Default styling');

    // Test 2: Emojis only
    Log.configure(emojis: true, colors: false, timestamp: true, logLevel: true);
    Log.i('Test 2: Emojis ON, Colors OFF');

    // Test 3: Colors only
    Log.configure(emojis: false, colors: true, timestamp: true, logLevel: true);
    Log.i('Test 3: Emojis OFF, Colors ON');

    // Test 4: Both emojis and colors
    Log.configure(emojis: true, colors: true, timestamp: true, logLevel: true);
    Log.i('Test 4: Both emojis and colors ON');

    // Test 5: Minimal output
    Log.configure(
        emojis: false, colors: false, timestamp: false, logLevel: false);
    Log.i('Test 5: Minimal output');

    // Test 6: Only timestamps
    Log.configure(
        emojis: false, colors: false, timestamp: true, logLevel: false);
    Log.i('Test 6: Only timestamps');

    // Reset to default
    Log.configure(emojis: false, colors: true, timestamp: true, logLevel: true);
    Log.i('Reset to default configuration');
  }

  void _demonstrateErrorHandling() {
    // Enhanced error logging
    try {
      throw const FormatException('Invalid JSON format in API response');
    } catch (e, stackTrace) {
      Log.e('Format error caught', 'PARSING', e, stackTrace);
    }

    try {
      throw StateError('Invalid application state detected');
    } catch (e) {
      Log.wtf('Critical state error!', 'SYSTEM');
    }

    // Custom error scenarios
    Log.e('Network timeout after 30 seconds', 'NETWORK');
    Log.wtf('Out of memory - application unstable!', 'MEMORY');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Log Enhanced Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '🚀 Dev Log Enhanced Demo',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📱 Check Your Debug Console',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap buttons to see enhanced logs. Features:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• 💜 Verbose & 🔥 WTF logging levels\n'
                        '• 🎛️ Optional emojis (disabled by default)\n'
                        '• 🎨 Customizable colors and formatting\n'
                        '• ⚙️ Independent emoji/color controls\n'
                        '• 📊 Enhanced JSON and error handling'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _demonstrateBasicLogs,
              icon: const Icon(Icons.bug_report),
              label: const Text('Basic Log Levels'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _demonstrateEmojiControls,
              icon: const Icon(Icons.sentiment_satisfied),
              label: const Text('Emoji Controls (Optional)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _demonstrateAdvancedFeatures,
              icon: const Icon(Icons.settings),
              label: const Text('Advanced Features'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _demonstrateExtensionMethods,
              icon: const Icon(Icons.extension),
              label: const Text('Extension Methods'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _demonstrateCustomization,
              icon: const Icon(Icons.palette),
              label: const Text('Customization Options'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _demonstrateErrorHandling,
              icon: const Icon(Icons.error),
              label: const Text('Error Handling'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 24),
            const Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.security,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Production Safe! 🔒',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'All logs automatically disappear in release builds.\nZero overhead in production!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Emojis are Optional! 🎛️',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Emojis are disabled by default.\nEnable them with Log.setEmojis(true) if you want them!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
