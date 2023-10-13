// sala_controller.dart

import 'package:get/get.dart';
import '../Models/models.dart';


class SalaController extends GetxController {
  final List<Sala> salas = [].obs as List<Sala>;

  // Método para adicionar uma nova sala
  void adicionarSala(Sala sala) {
    salas.add(sala);
  }

// Outros métodos relacionados à gestão de salas
}
