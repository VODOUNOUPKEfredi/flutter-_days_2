import 'package:dclic_pay/db_helper.dart';

class Transaction {
  final int? id;
  final String sender;
  final String recipient;
  final double amount;
  final String date;
  //constructeur
  Transaction({
    this.id,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.date,
  });
  // convertir un Map pour l'insertion dans SQlite
  static Map<String, dynamic> toMap(id, sender, recipient, amount, date) {

    return {
      "id": id,
      "sender": sender,
      "recipient": recipient,
      " amount": amount,
      "date": date,
    };
  }

  //convertir un Map sqlite en Transaction
  factory Transaction .fromMap(Map<String, dynamic> map) {
    return Transaction(
      sender: map["sender"] as String,
      recipient: map["recipient"] as String,
      amount: map["amount"] as double,
      date: map["date"] ,
      
    );
    
  }


  // // ajouter une transaction
  // static Future<void> inserTransaction({
  //   required String sender,
  //   required String recipient,
  //   required double amount,
  // }) async{
  //   String currentDate = DateTime.now().toString();
  //   Transaction transaction= Transaction(sender: sender,
  //    recipient: recipient,
  //     amount: amount,
  //      date: currentDate);
  //      await DbHelper.inserTransactions(transaction);
  // }
}
