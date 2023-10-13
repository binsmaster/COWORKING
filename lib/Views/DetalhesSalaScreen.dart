import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalhesSalaScreen extends StatelessWidget {
  final String salaId;

  DetalhesSalaScreen(this.salaId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Sala'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('salas').doc(salaId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Sala não encontrada.'),
            );
          }

          var salaData = snapshot.data!.data() as Map<String, dynamic>;
          var nomeSala = salaData['nome'];
          var capacidade = salaData['capacidadeMaxima'];
          var ativa = salaData['ativa'] ?? false;
          var custoPorHora = salaData['custoPorHora'];
          var recursosDisponiveis = salaData['recursosDisponiveis'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome da Sala: $nomeSala'),
                Text('Capacidade Máxima: $capacidade'),
                Text('Ativa: ${ativa ? 'Sim' : 'Não'}'),
                Text('Custo por Hora: $custoPorHora'),
                Text('Recursos Disponíveis:'),
                if (recursosDisponiveis is List)
                  for (var recurso in recursosDisponiveis)
                    Text('- $recurso'),
              ],
            ),
          );
        },
      ),
    );
  }
}
