import 'package:flutter/material.dart';
import 'package:dclic_pay/sendPage.dart'; // Assurez-vous que cette page existe
import 'db_helper.dart'; // Importation de la classe DbHelper

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> transactions = [];
  final DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final data =
        await DbHelper.getTransactions(); // Récupération des transactions depuis SQLite
    print("-----------------data");
    print(data);
    print(DbHelper);
    setState(() {
      transactions = data;
      print(transactions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('images/1.png'),
            ),
            SizedBox(width: 10),
            Text(
              "Hello fredi !",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
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
                      "\$10000.00",
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
          SizedBox(height: 25),
           Padding(
            padding: EdgeInsets.all(20),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Features",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("See all",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),)
            ],
          ),
            ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SendPage()),
                  );
                },
                child: Text("Send"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Receive")),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(transaction['name'][0])),
                  title: Text(transaction['name']),
                  subtitle: Text(transaction['date']),
                  trailing: Text(
                    "${transaction['amount'] > 0 ? '+' : ''}\$${transaction['amount'].toStringAsFixed(2)}",
                    style: TextStyle(
                      color:
                          transaction['amount'] > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
