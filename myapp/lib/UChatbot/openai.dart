import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenAI {
  static final String apiKey = 'cf0bd49030ed4aa6a6509be1cd9d604b';
  static final String apiType = 'azure';
  static final String apiBase = 'https://invuniandesai.openai.azure.com/';
  static final String apiVersion = '2023-03-15-preview';

  static Future<String> getCompletion(String message, {String model = 'gpt-35-turbo-16k-rfmanrique', String userRole = 'user'}) async {
    // Definir el prompt
    final String prompt = "You are a chatbot designed to assist students of Universidad de los Andes who are seeking international exchange opportunities. Your role is to provide information on available countries and universities, as well as answer specific questions regarding each university's application requirements. These requirements may include possessing a valid passport, providing proof of English proficiency, maintaining a GPA above 4, obtaining health insurance, and submitting academic transcripts. Your task is to guide students through the application process and address any inquiries they may have regarding the exchange program.";

    // Crear el mensaje inicial con el prompt y el rol del usuario
    final List<Map<String, dynamic>> messages = [
      {'role': userRole, 'content': prompt},
    ];

    final response = await http.post(
      Uri.parse('$apiBase/$apiVersion/engines/$model/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'OpenAI-Organization': '$apiType',
      },
      body: json.encode({
        'messages': messages,
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final botMessage = jsonResponse['choices'][0]['text'];
      return botMessage;
    } else {
      throw Exception('Failed to load response');
    }
  }

  static Future<String> getCompletionFromMessages(List<Map<String, String>> messages, {String model = 'gpt-35-turbo-16k-rfmanrique', double temperature = 0}) async {
    final lastUserMessage = messages.last['content'];

    final response = await http.post(
      Uri.parse('$apiBase/$apiVersion/engines/$model/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'OpenAI-Organization': '$apiType',
      },
      body: json.encode({
        'messages': messages,
        'temperature': temperature,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final botMessage = jsonResponse['choices'][0]['text'];
      return botMessage;
    } else {
      throw Exception('Failed to load response');
    }
  }
}
