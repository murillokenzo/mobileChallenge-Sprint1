class Perfil {
  final String nome, email, area, nivel;
  final int idade;
  const Perfil({required this.nome, required this.email, required this.idade, required this.area, required this.nivel});
  String get primeiroNome => nome.split(' ').first;
}
