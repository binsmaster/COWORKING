import 'package:flutter/material.dart';
import 'package:get/get.dart'; // pacote GetX
import 'Views/HomeScreen.dart';
import 'Views/Login/alterarSenha.dart';
import 'Views/Login/homeLoginScreen.dart';
import 'Views/Login/loginScreen.dart';
import 'Views/cadastro_cliente.dart';
import 'Views/cadastro_sala.dart';
import 'Views/historico_uso.dart';
import 'Views/ListagemSalasScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Views/reserva_sala.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp em vez de MaterialApp para usar o GetX
      title: 'CoWorking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Rota inicial
      getPages: [
        GetPage(name: '/', page: () => HomeLoginScreen()), // Tela inicial
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/recoveryPass', page: () => alteraSenhaScreen()),


        GetPage(name: '/cadastro_sala', page: () => CadastroSalaScreen()), // Tela de cadastro de salas
        GetPage(name: '/cadastro_cliente', page: () => CadastroClienteScreen()), // Tela de cadastro de Clientes
        GetPage(name: '/reservar_sala', page: () => ReservaSalaScreen()), // Reserva de cadastro de salas


        GetPage(name: '/lista_salas_disponiveis', page: () => ListagemSalasScreen()), // Tela de lista de salas disponíveis
        GetPage(name: '/historico_uso', page: () => HistoricoUsoScreen()), // Tela de histórico de uso

        // Adicione mais rotas conforme necessário
      ],
    );
  }
}
