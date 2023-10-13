import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class alteraSenhaScreen extends StatefulWidget {
  const alteraSenhaScreen({Key? key}) : super(key: key);

  @override
  State<alteraSenhaScreen> createState() => _alteraSenhaScreenState();
}

class _alteraSenhaScreenState extends State<alteraSenhaScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<void> resetPasswordFirebase() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('E-mail de redefinição enviado'),
          content: Text('Um e-mail com as instruções para redefinir sua senha foi enviado para ${emailController.text}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Troca de Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                resetPasswordFirebase();
              },
              child: Text('Receber e-mail de Alteração')
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
