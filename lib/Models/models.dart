// models.dart

// 1. Defina a classe Sala
class Sala {
  final String nome;
  final int capacidadeMaxima;
  final List<String> recursosDisponiveis;
  final double custoPorHora;

  Sala({
    required this.nome,
    required this.capacidadeMaxima,
    required this.recursosDisponiveis,
    required this.custoPorHora,
  });
}

// 2. Defina a classe Reserva
class Reserva {
  final Usuario usuario;
  final Sala sala;
  final DateTime dataHoraInicio;
  final DateTime dataHoraFim;
  final double custoTotal;

  Reserva({
    required this.usuario,
    required this.sala,
    required this.dataHoraInicio,
    required this.dataHoraFim,
    required this.custoTotal,
  });
}

// 3. Defina a classe Usuario (opcional, se desejar rastrear usuários)
class Usuario {
  final String nome;
  final String email;

  Usuario({
    required this.nome,
    required this.email,
  });
}
