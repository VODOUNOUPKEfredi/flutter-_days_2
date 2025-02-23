import 'package:fl_chart/fl_chart.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

final List<FlSpot> spendingData = [
  FlSpot(0, 150),
  FlSpot(1, 200),
  FlSpot(2, 180),
  FlSpot(3, 267),
  FlSpot(4, 320),
  FlSpot(5, 210),
  FlSpot(6, 190),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPeriodIndex = 1; 
  final List<String> periods = ["Day", "Week", "Month", "Custom Range"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wallet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 30),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: CreditCardUi(
              width: 300,
              cardHolderFullName: 'Ulrich MIDJINDOU',
              cardNumber: '1234567812345678',
              validFrom: '01/23',
              validThru: '01/28',
              topLeftColor: Colors.blue,
              doesSupportNfc: true,
              placeNfcIconAtTheEnd: true,
              cardType: CardType.debit,
              cardProviderLogo: const FlutterLogo(),
              cardProviderLogoPosition: CardProviderLogoPosition.right,
              showBalance: true,
              balance: 128.32,
              autoHideBalance: true,
              enableFlipping: true,
              cvvNumber: '123',
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total spending",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    selectedBorderColor: Colors.purple,
                    selectedColor: Colors.white,
                    fillColor: Colors.purple,
                    color: Colors.black,
                    isSelected: List.generate(
                      periods.length,
                      (index) => index == selectedPeriodIndex,
                    ),
                    onPressed: (index) {
                      setState(() {
                        selectedPeriodIndex = index;
                      });
                    },
                    children: periods
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(e, style: const TextStyle(fontSize: 14)),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 5),
                    ],
                  ),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              List<String> days = [
                                "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
                              ];
                              int index = value.toInt();
                              if (index < 0 || index >= days.length) return const Text("");
                              return Text(days[index], style: const TextStyle(fontSize: 12));
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spendingData,
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 4,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.blue.withOpacity(0.3),
                          ),
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
                 const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildExpenseCard("Weekly spend", "\$1,454.00"),
                    _buildExpenseCard("Shopping", "\$890.00"),
                    _buildExpenseCard("Others", "\$564.00"),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 5),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weekly income",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$2,960.00",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(String title, String amount) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
