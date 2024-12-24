import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/version.dart';

class VersionService {
  // Fetch versions from the remote server
  Future<List<Version>> fetchVersions() async {
    final response = await http.get(Uri.parse('https://dl.dashnyam.com/inxtalog.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Version.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load versions');
    }
  }
}