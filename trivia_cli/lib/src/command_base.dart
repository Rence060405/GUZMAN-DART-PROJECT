import 'package:trivia_api/trivia_api.dart';

abstract class CliCommand {
  final String name;
  final String description;

  CliCommand(this.name, this.description);

  Future<void> execute(TriviaApiClient client, List<String> arguments);
}
