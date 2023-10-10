import 'package:app_uniemp/menu_pages/business/manage_business.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class crearNegocio extends StatefulWidget {
  const crearNegocio({super.key});

  @override
  _crearNegocioState createState() => _crearNegocioState();
}

class _crearNegocioState extends State<crearNegocio> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _negocioController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? ruc;

  void _crearNegocio() async {
    String negocio = _negocioController.text;
    String telefono = _telefonoController.text;
    String direccion = _direccionController.text;
    String ciudad = _ciudadController.text;
    String provincia = _provinciaController.text;
    String pais = _paisController.text;
    String codigoPostal = _codigoPostalController.text;
    String email = _emailController.text;

    if (_negocioController.text.isEmpty ||
        _telefonoController.text.isEmpty ||
        _direccionController.text.isEmpty ||
        _ciudadController.text.isEmpty ||
        _provinciaController.text.isEmpty ||
        _paisController.text.isEmpty ||
        _emailController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Aviso'),
                content: const Text(
                    'Uno o más campos están vacíos o requieren revisión'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cerrar'))
                ],
              ));
    } else {
      String collectionName = '${ruc!}NEGOCIO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(ruc)
          .get();

      if (documentSnapshot.exists) {
       

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Advertencia'),
                  content: const Text('Ya existe un negocio registrado'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'))
                  ],
                ));
      } else {
        try {
          await _firestore.collection(collectionName).doc(ruc).set({
            'Razón Social': negocio,
            'RUC': ruc,
            'Teléfono': telefono,
            'Dirección': direccion,
            'Ciudad': ciudad,
            'Provincia': provincia,
            'País': pais,
            'Código Postal': codigoPostal,
            'email': email,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Negocio ingresado correctamente',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      backgroundColor: Color(0xFF04884C))),
            ),
          );
          _negocioController.clear();
          _telefonoController.clear();
          _direccionController.clear();
          _ciudadController.clear();
          _provinciaController.clear();
          _paisController.clear();
          _codigoPostalController.clear();
          _emailController.clear();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const menuNegocio(
                        ciudad: '',
                        codigoPostal: '',
                        direccion: '',
                        email: '',
                        pais: '',
                        provincia: '',
                        razonSocial: '',
                        ruc: '',
                        telefono: '',
                      ),
                  ));
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Ocurrió un error: ${e.toString()}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _negocioController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _ciudadController.dispose();
    _provinciaController.dispose();
    _paisController.dispose();
    _codigoPostalController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREAR NEGOCIO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const Image(image: AssetImage('imagenes/Uniemp.png')),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _negocioController,
              decoration: const InputDecoration(labelText: 'Negocio'),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'RUC: $ruc',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  backgroundColor: Color(0xFF04884C)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _telefonoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _direccionController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _ciudadController,
              decoration: const InputDecoration(labelText: 'Ciudad'),
            ),
            TextField(
              controller: _provinciaController,
              decoration: const InputDecoration(labelText: 'Provincia'),
            ),
            TextField(
              controller: _paisController,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            TextField(
              controller: _codigoPostalController,
              decoration: const InputDecoration(labelText: 'Código Postal'),
            ),
            TextFormField(
              controller: _emailController,
              cursorColor: const Color(0xFF04884C),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'ingrese un email válido'
                      : null,
            ),
            ElevatedButton(
                onPressed: _crearNegocio, child: const Text('Crear Negocio'))
          ],
        )),
      ),
    );
  }
}
