import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/cliente.dart.dart';


class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({super.key});

  @override
  _CadastroClienteScreenState createState() => _CadastroClienteScreenState();
}

class _CadastroClienteScreenState extends State<CadastroClienteScreen> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> salvarClienteNoFirestore(Cliente cliente) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('clientes').add(cliente.toMap());

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cliente Cadastrado!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Limpar os campos do formulário após o cadastro
      _nomeController.clear();
      _cpfController.clear();
      _emailController.clear();
    } catch (e) {
      print('Erro ao salvar cliente no Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Cliente'),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF do Cliente'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email do Cliente'),
            ),
            ElevatedButton(
              onPressed: () async {
                Cliente novoCliente = Cliente(
                  nome: _nomeController.text,
                  cpf: _cpfController.text,
                  email: _emailController.text,
                );

                // Adicionar o novo cliente ao Firestore
                await salvarClienteNoFirestore(novoCliente);
              },
              child: Text('Adicionar Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
