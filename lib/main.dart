import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'services/gemini_service.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IA de Estudo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const EstudoPage(),
    );
  }
}

class EstudoPage extends StatefulWidget {
  const EstudoPage({super.key});
  @override
  State<EstudoPage> createState() => _EstudoPageState();
}

class _EstudoPageState extends State<EstudoPage> {
  final gemini = GeminiService();
  String resposta = '';
  bool carregando = false;

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    _lastWords = '';
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() => _isListening = true);
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isListening = false);
    if (_lastWords.trim().isNotEmpty) {
      gerarConselho(_lastWords);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> gerarConselho(String prompt) async {
    setState(() => carregando = true);
    final result = await gemini.gerarResposta(prompt);
    setState(() {
      resposta = result;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conselhos de Estudo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            carregando
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_lastWords.isNotEmpty) ...[
                        const Text(
                          "Você disse:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _lastWords,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text(resposta, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'listen',
            onPressed:
                _speechEnabled
                    ? (_isListening ? _stopListening : _startListening)
                    : null,
            tooltip: _isListening ? 'Parar escuta' : 'Falar com a IA',
            child: Icon(_isListening ? Icons.mic_off : Icons.mic),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'refresh',
            onPressed: () {
              gerarConselho(
                'Dê um conselho motivador para estudos com emojis 🎓📚',
              );
            },
            child: const Icon(Icons.refresh),
            tooltip: 'Gerar dica padrão',
          ),
        ],
      ),
    );
  }
}
