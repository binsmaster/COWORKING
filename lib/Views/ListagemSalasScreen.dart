import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetalhesSalaScreen.dart';

class ListagemSalasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salas Cadastradas'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('salas').snapshots(),
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

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var salaData = document.data() as Map<String, dynamic>;
                var nomeSala = salaData['nome'];
                var capacidade = salaData['capacidadeMaxima'];
                var ativa = salaData['ativa'] ?? false; // Assumindo que existe uma chave 'ativa' no Firestore.

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(nomeSala),
                    subtitle: Text('Capacidade: $capacidade'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Chame um método para ativar ou desativar a sala.
                            toggleAtivacao(document.id, !ativa);
                          },
                          child: Text(ativa ? 'Desativar' : 'Ativar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navegue para a tela de detalhes da sala.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesSalaScreen(document.id),
                              ),
                            );
                          },
                          child: Text('Detalhes'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Nenhuma sala cadastrada.'),
            );
          }
        },
      ),
    );
  }

  void toggleAtivacao(String salaId, bool ativa) {
    // Atualize o estado de ativação da sala no Firestore.
    FirebaseFirestore.instance.collection('salas').doc(salaId).update({
      'ativa': ativa,
    });
  }
}


