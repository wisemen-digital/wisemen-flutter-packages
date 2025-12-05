import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ultra_playground/network/DTO/config_dto.dart';
import 'package:flutter_ultra_playground/network/clients/unprotected_client.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AppService {
  final Ref ref;

  AppService({required this.ref});

  Future<ConfigDTO> getAppConfig(String identifier) async {
    try {
      final result = await ref.read(unprotectedClientProvider).wGet('/api/v1/auth/login-config/$identifier');

      final config = ConfigDTO.fromJson(result);

      if (config.avatar != null) {
        final file = await _downloadAvatarAsPng(config.avatar ?? '');
        config.localAvatar = file.path;
      }

      return config;
    } catch (e) {
      rethrow;
    }
  }

  Future<File> _downloadAvatarAsPng(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to download avatar');
      }

      // Get app's documents directory
      final dir = await getApplicationDocumentsDirectory();

      // Create file path (png)
      final file = File('${dir.path}/avatar.png');

      // Write bytes to file
      await file.writeAsBytes(response.bodyBytes);

      return file;
    } catch (e) {
      throw Exception('Error downloading avatar: $e');
    }
  }
}

final appServiceProvider = Provider<AppService>((ref) => AppService(ref: ref));
