
import 'package:flutter/material.dart';
import 'package:dclic_pay/sendPage.dart'; 
import 'package:dclic_pay/db_helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = DbHelper.getTransactions(); // Charger les transactions depuis SQLite
  }

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
          Card(
            elevation: 15,
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fredi account", style: TextStyle(color: Colors.white)),
                      Text("Arian zesan", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "\$6,190.00", // Remplace par le vrai solde SQLite si nécessaire
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(),
                  Center(
                    child: Text("Total balance", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 10)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Added cart 05", style: TextStyle(color: Colors.white)),
                      Text("Ac no 2234521", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          // Boutons d'actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(
                icon: Icons.send,
                label: "Envoyer",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SendPage()));
                },
              ),
              _actionButton(
                icon: Icons.download,
                label: "Recevoir",
                onTap: () {},
              ),
              _actionButton(
                icon: Icons.card_giftcard,
                label: "Récompenses",
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Liste des transactions avec ListView.builder
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Loader en attendant les données
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erreur : ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Aucune transaction trouvée"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final transaction = snapshot.data![index];
                      bool isReceived = transaction['amount'] > 0; // Déterminer si c'est un envoi ou une réception

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SendPage()));
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isReceived ? Colors.green : Colors.red,
                              child: Icon(
                                isReceived ? Icons.arrow_downward : Icons.arrow_upward,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(transaction['sender'], style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(transaction['date']),
                            trailing: Text(
                              "${transaction['amount']} F CFA",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isReceived ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
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
}