import 'package:flutter/material.dart';
import 'package:dclic_pay/db_helper.dart';
import 'package:dclic_pay/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Vérifier si l'utilisateur existe
      User? existingUser = await DbHelper.getUserByEmail(email);
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("L'email existe déjà")),
        );
        return;
      }

      // Créer un nouvel utilisateur et l'insérer dans la base de données
      User newUser = User(name: name, email: email, password: password);
      await DbHelper.insertUser(newUser.name,newUser.email,0.0);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inscription réussie")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nom"),
                validator: (value) => value!.isEmpty ? "Entrez votre nom" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Entrez un email valide" : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Mot de passe"),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? "Le mot de passe doit contenir au moins 6 caractères"
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text("S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}