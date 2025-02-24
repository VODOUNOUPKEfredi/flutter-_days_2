import 'package:flutter/material.dart';
import 'package:dclic_pay/transaction.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String phoneNumber = "+229 98 00 00 00";
  String balance = "10000";
  String paymentMethod = "Carte Visa **** 1234";
  

  void _editField(String title, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modifier $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
            keyboardType: title == "Solde" ? TextInputType.number : TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  onSave(controller.text);
                });
                Navigator.pop(context);
              },
              child: Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil')), 
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/1.png'),
            ),
            SizedBox(height: 16),
            Text('frediv', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('fredi@example.com', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Divider(),

            _buildProfileOption(Icons.phone, 'Téléphone', phoneNumber, (newValue) {
              setState(() => phoneNumber = newValue);
            }),

            _buildProfileOption(Icons.account_balance_wallet, 'Solde',balance, (newValue) {
              setState(() => balance = newValue);
            }),

            _buildProfileOption(Icons.payment, 'Mode de paiement', paymentMethod, (newValue) {
              setState(() => paymentMethod = newValue);
            }),

           
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout),
              label: Text('Déconnexion'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, String value, Function(String) onSave) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      trailing: Icon(Icons.edit, color: Colors.grey),
      onTap: () {
        _editField(title, value, onSave);
      },
    );
  }
}
