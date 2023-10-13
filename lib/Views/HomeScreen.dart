import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoWorking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de salas
                Navigator.pushNamed(context, '/cadastro_sala');
              },
              child: Text('Cadastro de Salas'),
            ),

            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de salas
                Navigator.pushNamed(context, '/cadastro_cliente');
              },
              child: Text('Cadastro de Clientes'),
            ),

            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de cadastro de salas
                Navigator.pushNamed(context, '/reservar_sala');
              },
              child: Text('Reserva de Salas'),
            ),

            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de lista de salas disponíveis
                Navigator.pushNamed(context, '/lista_salas_disponiveis');
              },
              child: Text('Salas Disponíveis'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de histórico de uso
                Navigator.pushNamed(context, '/historico_uso');
              },
              child: Text('Histórico de Uso'),
            ),
            // Adicione mais botões para outras telas conforme necessário
          ],
        ),
      ),
    );
  }
}
