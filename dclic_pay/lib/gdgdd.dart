import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AcceuilPage(),
    ),
  );
}

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() {
    return AcceuilPageStates();
  }
}

class AcceuilPageStates extends State<AcceuilPage> {
  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    EdgeInsets.all(40);

    EdgeInsets.only(bottom: 20);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "hello Fredi!",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),

      body: ListView(
        children: [
          SizedBox(height: 30),
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
                      "\$6,190.00",
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

          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Features",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("See all",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),)
            ],
          ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.black.withOpacity(0.5),
                width: screenWidth*0.3,
                height: screenHeight*0.05,
                child: Row(
                children: [
                  Icon(Icons.arrow_downward),
                  Text("send")
                ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                width: screenWidth*0.3,
                height: screenHeight*0.05,
                child: Row(
                children: [
                  Icon(Icons.arrow_downward),
                  Text("Receive")
                ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                width: screenWidth*0.3,
                height: screenHeight*0.05,
                child: Row(
                children: [
                  Icon(Icons.card_giftcard_sharp),
                  Text("Rewards")
                ],
                ),
              )
            ],
          ),
          )
        ],
      ),
    );
  }
}
