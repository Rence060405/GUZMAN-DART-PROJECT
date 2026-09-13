import 'package:test/test.dart';
import 'package:trivia_api/trivia_api.dart';

void main() {
  group('Model Deserialisation Suite', () {
    test('Successful parsing of structural attributes', () {
      final mockJson = {
        'id': 'ID-1001',
        'name': 'Test Question',
        'value': 99.5,
      };

      final item = TriviaQuestion.fromJson(mockJson);
      expect(item.id, equals('ID-1001'));
      expect(item.name, equals('Test Question'));
      expect(item.primaryValue, equals(99.5));
    });

    test('Trigger custom exception on broken mapping keys', () {
      final malformedJson = {'id': 'ID-1002'};

      expect(
        () => TriviaQuestion.fromJson(malformedJson),
        throwsA(isA<TriviaException>()),
      );
    });
  });
}
