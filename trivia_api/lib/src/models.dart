import 'exceptions.dart';

class TriviaQuestion {
  final String id;
  final String name;
  final double
  primaryValue; // Maps to difficulty weight (e.g., easy=1.0, medium=2.0, hard=3.0)

  TriviaQuestion({
    required this.id,
    required this.name,
    required this.primaryValue,
  });

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String parsedId,
        'name': String parsedName,
        'value': num numericValue,
      } =>
        TriviaQuestion(
          id: parsedId,
          name: parsedName,
          primaryValue: numericValue.toDouble(),
        ),
      _ => throw TriviaException('Payload failed pattern validation check!'),
    };
  }
}
