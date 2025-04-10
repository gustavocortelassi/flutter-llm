# 🎓 App Flutter + Gemini: Conselhos de Estudo com IA

Este é um aplicativo Flutter que utiliza o modelo Gemini (Google Generative AI) para gerar **conselhos de estudo personalizados**. O app foi desenvolvido com foco em acessibilidade, linguagem natural e um layout adaptado ao público-alvo.

---

## 🧠 Tema Escolhido

**Conselhos de Estudo**  
O app fornece orientações úteis e motivacionais para estudantes que desejam melhorar sua concentração, disciplina e desempenho acadêmico. As respostas são geradas por IA e adaptadas com emojis, tom amigável e estilo acessível. 📚✨

---

## 👥 Público-Alvo

Estudantes de todas as idades que buscam melhorar sua rotina de estudos com apoio de tecnologia e inteligência artificial.

---

## 📝 Prompt Utilizado

```
Você é um mentor estudioso e paciente. Dê conselhos práticos para melhorar o foco e a organização nos estudos. 
Use uma linguagem leve, com exemplos simples, e adicione emojis para ilustrar. 🎓📚
```

---

## 🚀 Tecnologias Utilizadas

- **Flutter** (Dart)
- **Google Gemini API** via [`google_generative_ai`](https://pub.dev/packages/google_generative_ai)
- **dotenv** para segurança da chave da API (`flutter_dotenv`)
- **Material Design** para UI responsiva e acessível

---

## 📂 Estrutura do Projeto

```
lib/
  main.dart
  gemini_service.dart

assets/
  .env               # arquivo com a chave da API (NÃO é versionado)

README.md
```

---

## 🛠️ Como Executar o Projeto

1. Clone este repositório:

```bash
git clone https://github.com/gustavo-seu-usuario/seu-repo.git
cd seu-repo
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Crie o arquivo `.env` em `assets/.env` com sua chave da Gemini API:

```env
GEMINI_API_KEY=SUA_CHAVE_AQUI
```

4. Execute o app:

```bash
flutter run
```

> ⚠️ Para Flutter Web, o `.env` precisa ser listado como asset no `pubspec.yaml`.

---

## ✅ Recursos Atendidos

- Tema com identidade visual personalizada
- Geração de conteúdo via LLM (Gemini)
- Linguagem acessível e amigável
- Arquivo `.env` externo com proteção da chave
- Pronto para exportação como `.apk`

---

## 📦 APK

Para gerar o APK:

```bash
flutter build apk
```

O arquivo gerado estará em `build/app/outputs/flutter-apk/app-release.apk`.

---

## 👨‍💻 Autor

Desenvolvido por **Gustavo**, estudante de Engenharia de Software no Biopark Educação.  
📍 Oeste do Paraná  
🔗 [linkedin.com/in/gustavosoftdev](https://linkedin.com/in/gustavosoftdev)

---

## 📜 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

## 🙌 Contribuições

Contribuições são bem-vindas! Sinta-se livre para abrir uma issue ou enviar um pull request.
