import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../database/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  double totalBalance = 6190.00;
  List<Transaction> transactions = [];

  TransactionProvider() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    transactions = await DatabaseHelper.instance.getTransactions();
    totalBalance = transactions.isNotEmpty
        ? transactions.fold(0, (sum, item) => sum + item.amount)
        : 6190.00;

    print("Total Balance: $totalBalance");
    print("Transactions chargées dans le provider : $transactions");

    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    int id = await DatabaseHelper.instance.insert(transaction);
    transaction.id = id;
    await loadTransactions();
    print("Nouvelle balance apres ajout: $totalBalance");
    notifyListeners();
  }

  Future<void> deleteTransaction(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadTransactions();
  }

  void filterTransactions(String selectedFilter) {
    loadTransactions();

    if (selectedFilter == 'All') {
      return;
    } else {
      transactions = transactions
          .where((transaction) =>
              (selectedFilter == 'Income' && transaction.amount > 0) ||
              (selectedFilter == 'Expenses' && transaction.amount < 0))
          .toList();
      notifyListeners();
    }
  }
}