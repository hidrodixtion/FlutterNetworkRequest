import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Api {
  Future<List> getTeams(String leagueName) async {
    final response = await http.get(
        "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=$leagueName");

    print(response.body);

    if (response.statusCode == HttpStatus.OK) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse == null || jsonResponse["teams"] == null)
        return null;

      return jsonResponse["teams"];
    } else {
      return null;
    }
  }
}