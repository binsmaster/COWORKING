class Cliente {
  final String nome;
  final String cpf;
  final String email;

  Cliente({
    required this.nome,
    required this.cpf,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      nome: map['nome'],
      cpf: map['cpf'],
      email: map['email'],
    );
  }
}
