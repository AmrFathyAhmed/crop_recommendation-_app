
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AiContentGenerator {
  final String apiKey = 'AIzaSyDty23rBs4OTjrRUO-xXpX_Drl7Nl-9Ank';

  Future<String?> generateContent( { required String message}) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$apiKey',
    );

    final Map<String, dynamic> requestPayload = {
      "contents": [
        {
          "parts": [
            {"text": "You are an experienced agricultural expert specializing in farming, crops, soil health, irrigation, and modern agricultural practices. Your role is to provide accurate, practical, and personalized advice to app users about crop selection, soil improvement, pest management, climate adaptation, and sustainable farming methods. Your recommendations must be based on factors such as soil type, local climate, season, and market demand.Important Note: If the question or request is outside the field of agriculture or crop recommendations, do not answer it. Simply reply: This question is outside my agricultural expertise make all answer very very short .$message "}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Extracting text content from the response
        final candidates = responseData['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          final parts = candidates[0]['content']['parts'];
          if (parts != null && parts.isNotEmpty) {
            final text = parts[0]['text'];
            print("$text");
            return text;
          }
        }  
        return null; // Return null if no content is found
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Request Error: $error');
      return null;
    }
  }
}
