import 'package:terminal_colors/terminal_colors.dart';
import 'package:trivia_api/trivia_api.dart';

import 'command_base.dart';

class QueryCommand extends CliCommand {
  QueryCommand()
    : super('query', 'Fetches records for a specific domain target.');

  @override
  Future<void> execute(TriviaApiClient client, List<String> arguments) async {
    if (arguments.isEmpty) {
      print('Execution Error: Argument query criteria is missing.'.styleError);
      return;
    }

    final target = arguments.first;
    try {
      final result = await client.fetchMetadata(target);

      final buffer = StringBuffer()
        ..writeln('--- AUDIT REPORT ---'.styleHeader)
        ..writeln('Category ID: ${result.id}'.styleSuccess)
        ..writeln('Question:    ${result.name}')
        ..writeln('Weight Val:  ${result.primaryValue}')
        ..writeln('--------------------'.styleHeader);

      print(buffer.toString());
    } on TriviaException catch (e) {
      print('Operation Failed: ${e.message}'.styleError);
    }
  }
}
