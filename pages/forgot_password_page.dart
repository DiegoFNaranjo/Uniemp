import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? errorMessage = '';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget _errorMessage() {
    return Text(errorMessage == ''
        ? ''
        : 'Error no está registrado el email ingresado');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF04884C),
          title: const Text('Resetear Contraseña'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('imagenes/Uniemp.png')),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'recibará un enlace en su correo para resetear su contraseña',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Color(0xFF04884C)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: const Color(0xFF04884C),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: 'Email'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'ingrese un email válido'
                            : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.email_outlined),
                    label: const Text('Resetear contraseña',
                        style: TextStyle(fontSize: 24)),
                    onPressed: resetPassword,
                  ),
                  _errorMessage(),
                ],
              ),
            ),
          ),
        ),
      );
  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 6,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Color(0xFF04884C)),
              ),
            ));
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); 
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Email enviado',
          style: TextStyle(fontSize: 13, backgroundColor: Color(0xFF04884C)),
        ),
        backgroundColor: Color(0xFF04884C),
      ));
    } on FirebaseAuthException catch (e) {
      print(e);
      setState(() {
        errorMessage = e.message;
      });
    }
  }
}
