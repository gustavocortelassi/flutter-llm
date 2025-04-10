import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService()
    : _model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.env['GEMINI_API_KEY']!,
        generationConfig: GenerationConfig(
          temperature:
              0.7, // Define a temperatura para controle da aleatoriedade
          topK:
              40, // Define o número de palavras mais prováveis a serem consideradas
          topP:
              0.9, // Define a probabilidade cumulativa para seleção de palavras
          maxOutputTokens: 500, // Define o número máximo de tokens na resposta
          stopSequences: [
            '###',
          ], // Define sequências de parada para interromper a geração
        ),
      );

  Future<String> gerarResposta(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    return response.text ?? 'Sem resposta gerada.';
  }
}
