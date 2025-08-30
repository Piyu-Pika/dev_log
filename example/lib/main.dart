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
      title: 'flutter debug log Demo',
      home: LoggerDemo(),
    );
  }
}

class LoggerDemo extends StatelessWidget {
  const LoggerDemo({super.key});

  void _demonstrateLogs() {
    // Simple usage
    Log.print('Simple print message');
    Log.d('Debug message');
    Log.i('Info message');
    Log.w('Warning message');
    Log.e('Error message');

    // Short aliases
    L.d('Debug with short alias');
    L.i('Info with short alias');
    L.p('Simple print with alias');

    // Long message handling
    Log.long(
        'This is a very long message that would normally be truncated in Android logcat but will be automatically split into multiple log entries to ensure complete visibility in debug console output');

    // JSON logging
    final Map<String, dynamic> data = {
      'user': 'John Doe',
      'age': 30,
      'settings': {'theme': 'dark', 'notifications': true},
      'tags': ['flutter', 'mobile', 'developer']
    };
    Log.json(data);

    // Custom tags
    Log.d('Database connected', 'DB');
    Log.w('Low memory warning', 'MEMORY');
    Log.e('Network timeout', 'NETWORK');

    // advanced string formatting

    // All these work perfectly:
    String userName = 'John';
    int userAge = 25;
    bool isLoggedIn = true;

    // Basic interpolation
    Log.d('User: $userName, Age: $userAge');
    Log.i('Login status: $isLoggedIn');

    // Complex expressions
    Log.w(
        'User ${userName.toUpperCase()} is ${userAge > 18 ? 'adult' : 'minor'}');

    // With custom tags
    Log.e('Failed to save user $userName', 'DATABASE');

    // Short aliases work too
    L.d('Processing user: $userName');
    L.i('Found ${userName.length} users');

// String interpolation with extension methods
    Map<String, dynamic> userData = {'name': 'John', 'age': 25};
    List<String> items = ['item1', 'item2', 'item3'];

// ✅ These will now work:
    'User $userName logged in'.logD();
    'Found ${items.length} results'.logI('SEARCH');
    'Warning: User $userName exceeded limit'.logW();
    'Error processing user $userName'.logE('USER');

// ✅ Simple usage:
    'Hello World'.logD();
    'API call successful'.logI();
    'Low memory warning'.logW();
    'Network failed'.logE();

// ✅ JSON extension:
    userData.logJson('USER_DATA');

// ✅ Simple print extension:
    'Quick debug info'.logP();

    userData.logJson('USER_DATA');
    Map<String, dynamic> statusData = {
      'status': 'success',
      'count': items.length
    };
    statusData.logJson();

// ✅ Long message extension:
    String veryLongApiResponse =
        'This is a very long API response that should be logged completely without truncation. '
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    veryLongApiResponse.logLong('API');

    // Trace method calls
    Log.trace('Method called');
    Log.trace('Custom trace message', 'TRACE');

    // Error with stack trace
    try {
      throw Exception('Test exception');
    } catch (e, stackTrace) {
      Log.e('Caught exception', 'ERROR', e, stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter debug log Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'flutter debug log Package Demo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Check your debug console for log output',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _demonstrateLogs,
              child: const Text('Generate Debug Logs'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Logs only appear in debug mode!\nNo logs in release builds.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
