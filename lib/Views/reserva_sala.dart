import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:async';

class ReservaSalaController extends GetxController {
  var selectedCliente = ''.obs;
  var selectedSala = ''.obs;
  var horasReservadas = 0.obs;
  var clientes = <String>[].obs; // Use o .obs para tornar a lista reativa.
  var salas = <String>[].obs; // Use o .obs para tornar a lista reativa.
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    // Inicialize o Firebase.
    Firebase.initializeApp();

    // Busque os nomes dos clientes no Firestore e atualize a lista.
    FirebaseFirestore.instance.collection('clientes').get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        clientes.add(doc['nome']); // Substitua 'nome' pelo campo real do nome do cliente no Firestore.
      });
    });

    // Busque os nomes das salas no Firestore e atualize a lista.
    FirebaseFirestore.instance.collection('salas').get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        salas.add(doc['nome']); // Substitua 'nome' pelo campo real do nome da sala no Firestore.
      });
    });
  }

  void selecionarCliente(String cliente) {
    selectedCliente.value = cliente;
  }

  void selecionarSala(String sala) {
    selectedSala.value = sala;
  }

  void iniciarReserva() {
    int horas = horasReservadas.value;
    if (horas > 0) {
      _timer = Timer.periodic(Duration(minutes: 1), (timer) {
        horasReservadas.value = horasReservadas.value - 1;
        if (horasReservadas.value == 0) {
          timer.cancel();
          salvarReserva();
        }
      });
    }
  }

  void salvarReserva() {
    final cliente = selectedCliente.value;
    final sala = selectedSala.value;
    final horas = horasReservadas.value;

    if (cliente.isNotEmpty && sala.isNotEmpty && horas > 0) {
      // Salvar a reserva no Firestore e calcular o preço com base nas horas.
      FirebaseFirestore.instance.collection('reservas').add({
        'cliente': cliente,
        'sala': sala,
        'horasReservadas': horas,
        'precoTotal': horas * 25.0, // Preço por hora
      });

      // Reiniciar os campos e a contagem de horas
      selectedCliente.value = '';
      selectedSala.value = '';
      horasReservadas.value = 0;
    } else {
      Get.snackbar('Erro', 'Por favor, preencha todos os campos corretamente.');
    }
  }
}

class ReservaSalaScreen extends StatelessWidget {
  final ReservaSalaController reservaController = Get.put(ReservaSalaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserva de Sala'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: reservaController.selectedCliente.value,
              onChanged: (newValue) {
                reservaController.selecionarCliente(newValue!);
              },
              items: reservaController.clientes.map((cliente) {
                return DropdownMenuItem<String>(
                  value: cliente,
                  child: Text(cliente),
                );
              }).toList(),
              hint: Text('Selecione o Cliente'),
            ),
            DropdownButton<String>(
              value: reservaController.selectedSala.value,
              onChanged: (newValue) {
                reservaController.selecionarSala(newValue!);
              },
              items: reservaController.salas.map((sala) {
                return DropdownMenuItem<String>(
                  value: sala,
                  child: Text(sala),
                );
              }).toList(),
              hint: Text('Selecione a Sala'),
            ),
            TextField(
              onChanged: (value) {
                reservaController.horasReservadas.value = int.parse(value);
              },
              decoration: InputDecoration(labelText: 'Horas Reservadas'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                reservaController.iniciarReserva();
              },
              child: Text('Iniciar Reserva'),
            ),
            ElevatedButton(
              onPressed: () {
                reservaController.salvarReserva();
              },
              child: Text('Salvar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
