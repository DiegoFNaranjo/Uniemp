import 'package:app_uniemp/menu_pages/business/create_business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_uniemp/auth.dart';
import 'package:flutter/material.dart';
import 'package:app_uniemp/pages/menu.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _rucNegocioController = TextEditingController();
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('U N I E M P - APP');
  }

  Widget _userId() {
    return Text(user?.email ?? 'user email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  void _registrarRuc(BuildContext context) async {
    String pasarRucNegocio = _rucNegocioController.text;
    if (_rucNegocioController.text.isEmpty ||
        _rucNegocioController.text.length != 13) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Ingrese su RUC',
          style: TextStyle(backgroundColor: Color(0xFF04884C)),
        ),
        backgroundColor: Color(0xFF04884C),
      ));
    } else {
      String collectionName = '${pasarRucNegocio}NEGOCIO';
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(pasarRucNegocio);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (documentSnapshot.exists &&
          _rucNegocioController.text != data?['RUC']) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Aviso'),
                  content: const Text(
                      'El RUC ingresado no corresponde con el existente'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'))
                  ],
                ));
      } else if (documentSnapshot.exists &&
          _rucNegocioController.text == data?['RUC']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => menu_principal(),
                settings: RouteSettings(arguments: pasarRucNegocio)));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('BIENVENIDO; RUC ingresado correctamente',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
      } else if (!documentSnapshot.exists) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const crearNegocio(),
                settings: RouteSettings(arguments: pasarRucNegocio)));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deberá crear su negocio como primer paso',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image(),
              const Text('Bienvenido'),
              const SizedBox(
                height: 20,
              ),
              _userId(),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _rucNegocioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'RUC'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _registrarRuc(context);
                  },
                  child: const Text('Ingresar RUC')),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
