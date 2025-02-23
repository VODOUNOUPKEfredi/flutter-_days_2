class User {
  int? id;
  String name;
  String email;
  String password;
  double balance;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.balance = 0.0,
  });

  // Fonction pour convertir un utilisateur en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'balance': balance,
    };
  }

  // Fonction pour créer un utilisateur à partir d'un Map SQLite
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      balance: map['balance'] ?? 0.0,
    );
  }
}