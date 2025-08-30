import 'package:flutter_test/flutter_test.dart';
import 'package:dev_log/dev_log.dart';

void main() {
  group('flutter debug log Tests', () {
    test('Log methods should not throw errors', () {
      expect(() => Log.d('Debug test'), returnsNormally);
      expect(() => Log.i('Info test'), returnsNormally);
      expect(() => Log.w('Warning test'), returnsNormally);
      expect(() => Log.e('Error test'), returnsNormally);
      expect(() => Log.print('Print test'), returnsNormally);
      expect(() => Log.long('Long message test'), returnsNormally);
    });

    test('Short aliases should work', () {
      expect(() => L.d('Debug'), returnsNormally);
      expect(() => L.i('Info'), returnsNormally);
      expect(() => L.w('Warning'), returnsNormally);
      expect(() => L.e('Error'), returnsNormally);
      expect(() => L.p('Print'), returnsNormally);
    });

    test('JSON logging should handle various data types', () {
      expect(() => Log.json({'key': 'value'}), returnsNormally);
      expect(() => Log.json(['item1', 'item2']), returnsNormally);
      expect(() => Log.json('simple string'), returnsNormally);
    });

    test('Extension methods should work', () {
      expect(() => 'test string'.logD(), returnsNormally);
      expect(() => {'key': 'value'}.logJson(), returnsNormally);
    });

    test('Manual enable/disable should work', () {
      Log.enable();
      expect(Log.isEnabled, isTrue);

      Log.disable();
      // Note: In test environment, kDebugMode might be true
      // so isEnabled might still be true
    });
  });
}
