// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiServices {
  static var client = http.Client();

  static Future<String> chatCompeletionResponse(String prompt) async {
    var url = Uri.https("api.openai.com", "/v1/chat/completions");
    log("prompt : $prompt");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
        "messages": [
          {"role": "user", "content": prompt}
        ]
      }),
    );

    print("hello chat");
    print(
        "Chat respons   =======${jsonDecode(utf8.decode(response.bodyBytes))}");
    log("STATUS : ${response.statusCode}");
    // Do something with the response
    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    return response.statusCode == 200
        ? newresponse['choices'][0]['message']['content']
        : "";
  }
}
