// historico_uso.dart

import 'package:flutter/material.dart';

class HistoricoUsoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Uso'),
      ),
      body: ListView.builder(
        itemCount: 5, // Substitua pelo número real de reservas do usuário
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Sala Usada ${index + 1}'),
            subtitle: Text('Data: 01/01/2023'),
            trailing: Text('Custo: \$50.00'),
          );
        },
      ),
    );
  }
}
