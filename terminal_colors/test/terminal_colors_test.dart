import 'package:test/test.dart';
import 'package:terminal_colors/terminal_colors.dart';

void main() {
  group('Terminal Color Utility Tests', () {
    test('String extensions properly wrap ANSI escape sequences', () {
      const text = 'Hello World';
      expect(text.styleSuccess, contains('\x1B[32m'));
      expect(text.styleError, contains('\x1B[31m'));
    });
  });
}
