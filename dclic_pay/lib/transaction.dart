class Transaction {
  final int id;
  final String nomEnvoyeur;
  final double montant;
  final DateTime date;

  Transaction({
    required this.id,
    required this.nomEnvoyeur,
    required this.montant,
    required this.date,
  });

  // Convertir un Map en Transaction
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      nomEnvoyeur: map['nomEnvoyeur'],
      montant: map['montant'],
      date: DateTime.parse(map['date']),
    );
  }
}