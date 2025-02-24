import 'package:flutter/material.dart';
import 'package:dclic_pay/db_helper.dart'; // Assure-toi d'importer correctement ton DbHelper
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dclic_pay/sendPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historique des Transactions")),
      body: Column(
        children: [
          // Ajouter ici tous les autres widgets (comme la carte, les boutons, etc.)
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
                      Text(
                        "Fredi account",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Arian zesan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "\$6,190.00", // Remplace par le vrai solde SQLite si nécessaire
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(),
                  Center(
                    child: Text(
                      "Total balance",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Added cart 05",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Ac no 2234521",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          // Boutons d'actions
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Facture"), Text("See more")],
                ),

                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SendPage()),
                        );
                      },
                      icon: FaIcon(FontAwesomeIcons.moneyBill),
                      label: Text("Send"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withAlpha(50),
                      ),
                    ),
                     ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SendPage()),
                        );
                      },
                      icon: FaIcon(FontAwesomeIcons.moneyBill),
                      label: Text("Receive"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withAlpha(50),
                      ),
                    ),
                     ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SendPage()),
                        );
                      },
                      icon: FaIcon(FontAwesomeIcons.moneyBill),
                      label: Text("Reward"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withAlpha(50),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Recent activity"), Text("All")],
                ),
              ],
            ),
          ),
          // Utilisation de FutureBuilder pour attendre la récupération des transactions
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future:
                  DbHelper.getTransactions(), // Appeler la méthode pour récupérer les transactions
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); // Afficher un indicateur de chargement pendant la récupération
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Erreur: ${snapshot.error}"));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Aucune transaction"));
                }

                // Récupérer les transactions récupérées
                List<Map<String, dynamic>> transactions = snapshot.data!;

                return ListView.builder(
                  itemCount:
                      transactions
                          .length, // Utiliser le nombre d'éléments dans transactions
                  itemBuilder: (context, index) {
                    var transaction =
                        transactions[index]; // Récupérer la transaction
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      title: Text(
                        "Sender: ${transaction['sender_id']}",
                      ), // Afficher l'expéditeur
                      subtitle: Text(
                        "Recipient: ${transaction['recipient_id']}",
                      ), // Afficher le destinataire
                      trailing: Text(
                        "\$${transaction['amount']}",
                      ), // Afficher le montant
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Section qui charge et affiche les transactions
    );
  }
}
