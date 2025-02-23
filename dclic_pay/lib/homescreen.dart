import 'package:flutter/material.dart';
import 'package:dclic_pay/sendPage.dart'; // Assurez-vous d'importer la page d'envoi d'argent

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Sacof!"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Solde principal
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Sacof account",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  "\$6,190.00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Total balance",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          // Boutons d'actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(
                icon: Icons.send,
                label: "Envoyer",
                onTap: () {
                  // Navigation vers la page d'envoi d'argent
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SendPage()),
                  );
                },
              ),
              _actionButton(
                icon: Icons.download,
                label: "Recevoir",
                onTap: () {
                  // Logique pour recevoir de l'argent
                },
              ),
              _actionButton(
                icon: Icons.card_giftcard,
                label: "Récompenses",
                onTap: () {
                  // Logique pour les récompenses
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Activité récente
          Expanded(
            child: ListView(
              children: [
                _transactionTile("Miradie", "+1,190.00", Colors.green),
                _transactionTile("Emeric", "-75.00", Colors.red),
                _transactionTile("Nelly", "-220.00", Colors.red),
                _transactionTile("Silas", "+2,000.00", Colors.green),
              ],
            ),
          ),
        ],
      ),
     
    );
  }

  Widget _actionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 24,
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _transactionTile(String name, String amount, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.person, color: Colors.black),
      ),
      title: Text(name),
      subtitle: const Text("22 Jan 2025"),
      trailing: Text(
        amount,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}