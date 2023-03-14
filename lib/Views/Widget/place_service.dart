import 'dart:convert';
import 'dart:io';

import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:http/http.dart';


class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  // static final String androidKey = 'AIzaSyC2xQms_OMv8BwJutPw2RAEyFDJbAXCUmY';
  // static final String iosKey = 'AIzaSyC2xQms_OMv8BwJutPw2RAEyFDJbAXCUmY';
  static final String androidKey = 'AIzaSyDvowRMFlyzrToTooANzNga4ItfFQbXXhA';
  static final String iosKey = 'AIzaSyDvowRMFlyzrToTooANzNga4ItfFQbXXhA';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=us-Us&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

}