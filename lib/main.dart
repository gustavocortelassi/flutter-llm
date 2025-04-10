import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/gemini_service.dart'; // ajuste conforme sua estrutura

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

  Future<void> gerarConselho() async {
    setState(() => carregando = true);

    const prompt = '''
Você é um mentor estudioso e paciente. Dê conselhos práticos para melhorar o foco e a organização nos estudos. 
Use uma linguagem leve, com exemplos simples, e adicione emojis para ilustrar. 🎓📚
''';

    final result = await gemini.gerarResposta(prompt);

    setState(() {
      resposta = result;
      carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    gerarConselho();
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
                  child: Text(resposta, style: const TextStyle(fontSize: 18)),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gerarConselho,
        child: const Icon(Icons.refresh),
        tooltip: 'Gerar novo conselho',
      ),
    );
  }
}
