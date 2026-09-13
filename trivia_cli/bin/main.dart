import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:terminal_colors/terminal_colors.dart';
import 'package:trivia_api/trivia_api.dart';
import 'package:trivia_cli/src/commands.dart';
import 'package:trivia_cli/src/logging_config.dart';

void main() async {
  configureSystemTelemetry();

  final httpClient = http.Client();
  final apiClient = TriviaApiClient(httpClient);

  final queryCmd = QueryCommand();

  print('Welcome to the Open Trivia Arena CLI Tool!'.styleHeader);

  try {
    while (true) {
      stdout.write('\n[trivia_app] > ');
      final input = stdin.readLineSync();

      if (input == null || input.trim().toLowerCase() == 'exit') {
        print('Exiting platform...'.styleWarning);
        break;
      }

      final trimmed = input.trim();
      if (trimmed.isEmpty) continue;

      final parts = trimmed.split(' ');
      final commandName = parts.first;
      final args = parts.sublist(1);

      if (commandName == 'query') {
        await queryCmd.execute(apiClient, args);
      } else {
        print('Unknown command. Type "exit" to leave.'.styleError);
      }
    }
  } finally {
    httpClient.close();
    print('System network socket disconnected successfully.'.styleSuccess);
  }
}
