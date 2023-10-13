import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/models.dart';

class CadastroSalaScreen extends StatefulWidget {
  @override
  _CadastroSalaScreenState createState() => _CadastroSalaScreenState();
}

class _CadastroSalaScreenState extends State<CadastroSalaScreen> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _capacidadeController = TextEditingController();
  TextEditingController _custoController = TextEditingController();
  bool _projetor = false;
  bool _videoconferencia = false;

  Future<void> salvarSalaNoFirestore(Sala sala) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('salas').add({
        'nome': sala.nome,
        'capacidadeMaxima': sala.capacidadeMaxima,
        'recursosDisponiveis': sala.recursosDisponiveis,
        'custoPorHora': sala.custoPorHora,
      });

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sala Cadastrada!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Limpar os campos do formulário após o cadastro
      _nomeController.clear();
      _capacidadeController.clear();
      _custoController.clear();
      _projetor = false;
      _videoconferencia = false;
    } catch (e) {
      print('Erro ao salvar sala no Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Sala'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Sala'),
            ),
            TextField(
              controller: _capacidadeController,
              decoration: InputDecoration(labelText: 'Capacidade Máxima'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Text('Recursos Disponíveis:'),
                Checkbox(
                  value: _projetor,
                  onChanged: (value) {
                    setState(() {
                      _projetor = value!;
                    });
                  },
                ),
                Text('Projetor'),
                Checkbox(
                  value: _videoconferencia,
                  onChanged: (value) {
                    setState(() {
                      _videoconferencia = value!;
                    });
                  },
                ),
                Text('Videoconferência'),
              ],
            ),
            TextField(
              controller: _custoController,
              decoration: InputDecoration(labelText: 'Custo por Hora'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                Sala novaSala = Sala(
                  nome: _nomeController.text,
                  capacidadeMaxima: int.parse(_capacidadeController.text),
                  recursosDisponiveis: [],
                  custoPorHora: double.parse(_custoController.text),
                );

                if (_projetor) {
                  novaSala.recursosDisponiveis.add('Projetor');
                }

                if (_videoconferencia) {
                  novaSala.recursosDisponiveis.add('Videoconferência');
                }

                // Adicionar a nova sala à lista de salas
                await salvarSalaNoFirestore(novaSala);
              },
              child: Text('Adicionar Sala'),
            ),
          ],
        ),
      ),
    );
  }
}
