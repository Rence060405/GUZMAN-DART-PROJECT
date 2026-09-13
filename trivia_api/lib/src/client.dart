// trivia_api/lib/src/client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'exceptions.dart';
import 'models.dart';

class TriviaApiClient {
  final http.Client _client;
  final Logger _logger = Logger('TriviaApiClient');
  static const String _authority = 'opentdb.com';

  TriviaApiClient(this._client);

  Future<TriviaQuestion> fetchMetadata(String query) async {
    _logger.info('Initiating connection for resource query: $query');

    // Request a single question from OpenTDB
    final uri = Uri.https(_authority, '/api.php', {'amount': '1'});

    try {
      final response = await _client
          .get(
            uri,
            headers: {
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
              'Accept': 'application/json, text/plain, */*',
              'Accept-Language': 'en-US,en;q=0.9',
              'Connection': 'keep-alive',
            },
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) {
        _logger.warning(
          'API responded with error status: ${response.statusCode}',
        );
        throw TriviaException(
          'Remote server rejected transaction (HTTP ${response.statusCode}).',
        );
      }

      final decoded = json.decode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw TriviaException('Unexpected JSON response payload structure.');
      }

      final results = decoded['results'] as List?;
      if (results == null || results.isEmpty) {
        throw TriviaException('No trivia records returned for query.');
      }

      final rawItem = results.first as Map<String, dynamic>;

      final formattedPayload = {
        'id': (rawItem['category'] as String?) ?? 'General Knowledge',
        'name': (rawItem['question'] as String?) ?? 'No question content',
        'value': rawItem['difficulty'] == 'hard'
            ? 3.0
            : (rawItem['difficulty'] == 'medium' ? 2.0 : 1.0),
      };

      return TriviaQuestion.fromJson(formattedPayload);
    } on http.ClientException catch (e) {
      _logger.severe('Network socket transaction failed.', e);
      throw TriviaException('Network communication failure occurred.', e);
    } catch (e) {
      _logger.severe('An unexpected processing failure was intercepted.', e);
      rethrow;
    }
  }
}
