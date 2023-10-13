import 'package:get/get.dart'; // Importe a biblioteca GetX

class ReservaSalaController extends GetxController {
  var selectedCliente = ''.obs;
  var selectedSala = ''.obs;
  var horasReservadas = 0.obs;

  void selecionarCliente(String cliente) {
    selectedCliente.value = cliente;
  }

  void selecionarSala(String sala) {
    selectedSala.value = sala;
  }
}