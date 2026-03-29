import 'package:adrian_messages_app/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.username', () {
    test('rejects empty', () {
      expect(Validators.username(''), isNotNull);
      expect(Validators.username(null), isNotNull);
    });

    test('rejects too short', () {
      expect(Validators.username('ab'), isNotNull);
    });

    test('rejects invalid chars', () {
      expect(Validators.username('abc!'), isNotNull);
      expect(Validators.username('ab c'), isNotNull);
    });

    test('accepts valid username', () {
      expect(Validators.username('adrian_123'), isNull);
    });
  });

  group('Validators.password', () {
    test('rejects empty', () {
      expect(Validators.password(''), isNotNull);
      expect(Validators.password(null), isNotNull);
    });

    test('rejects too short', () {
      expect(Validators.password('1234567'), isNotNull);
    });

    test('accepts valid password', () {
      expect(Validators.password('12345678'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('rejects mismatch', () {
      expect(Validators.confirmPassword('b', 'a'), isNotNull);
    });

    test('accepts match', () {
      expect(Validators.confirmPassword('same', 'same'), isNull);
    });
  });
}

