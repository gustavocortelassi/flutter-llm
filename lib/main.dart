import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env'); // Carrega o .env

  final apiKey = dotenv.env['GEMINI_API_KEY'];

  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey!,
  );

  final prompt =
      'Escreva uma história criativa e curta sobre uma mochila mágica. A história deve ser em português, com linguagem simples e envolvente para crianças. 🧒🎒✨';
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);

  print(response.text); // Exibe no console

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gemini Test')),
        body: const Center(child: Text('Veja o resultado no console.')),
      ),
    );
  }
}
