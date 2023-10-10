import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_uniemp/pages/forgot_password_page.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('U N I E M P - APP');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  Widget _entryFieldEmail(String title, TextEditingController emailController) {
    return TextFormField(
                    controller: emailController,
                    cursorColor: const Color(0xFF04884C),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: 'Email'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'ingrese un email válido'
                            : null,
                  );
  }

  Widget _entryFieldPassword(
      String title, TextEditingController passwordController) {
    return TextField(
        controller: passwordController,
        decoration: InputDecoration(
          labelText: title,
        ),
        obscureText: true);
  }

  Widget _errorMessage() {
    return Text(
        errorMessage == '' ? '' : 'Advertencia, credenciales incorrectas');
  }

  Widget _forgotPassword() {
    return GestureDetector(
        child: Text(
          'Olvidó su contraseña?',
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12),
        ),
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ForgotPasswordPage())));
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Ingresar' : 'Registrarse'));
  }

  Widget _loginOnRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Registrarse' : 'Ingresar Credenciales'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image(),
              const SizedBox(
                height: 30,
                width: 30,
              ),
              _entryFieldEmail('email', _controllerEmail),
              _entryFieldPassword('password', _controllerPassword),
              _errorMessage(),
              const SizedBox(height: 20, width: 10),
              _submitButton(),
              const SizedBox(height: 20, width: 10),
              _forgotPassword(),
              _loginOnRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
