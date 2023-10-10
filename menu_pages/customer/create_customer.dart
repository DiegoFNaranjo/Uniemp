import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class crearCliente extends StatefulWidget {
  const crearCliente({super.key});

  @override
  _crearClienteState createState() => _crearClienteState();
}

class _crearClienteState extends State<crearCliente> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _rucClienteController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String credito = 'no';
  String bloquear = 'no';
  String? ruc;
  void _crearCliente() async {
    String cliente = _clienteController.text;
    String rucCliente = _rucClienteController.text;
    String telefono = _telefonoController.text;
    String direccion = _direccionController.text;
    String ciudad = _ciudadController.text;
    String provincia = _provinciaController.text;
    String pais = _paisController.text;
    String codigoPostal = _codigoPostalController.text;
    String email = _emailController.text;

    if (_clienteController.text.isEmpty ||
        _rucClienteController.text.isEmpty ||
        _rucClienteController.text.length != 13 ||
        _telefonoController.text.isEmpty ||
        _telefonoController.text.length < 9 ||
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
      String collectionName = '${ruc!}CLIENTE';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(_rucClienteController.text)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Advertencia'),
                  content: const Text('El R.U.C. ingresado ya existe'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'))
                  ],
                ));
      } else {
        try {
          await _firestore.collection(collectionName).doc(rucCliente).set({
            'Razón Social': cliente,
            'RUC': rucCliente,
            'Teléfono': telefono,
            'Dirección': direccion,
            'Ciudad': ciudad,
            'Provincia': provincia,
            'País': pais,
            'Código Postal': codigoPostal,
            'email': email,
            'Crédito': credito,
            'Bloquear': bloquear,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cliente ingresado correctamente'),
            ),
          );

          _clienteController.clear();
          _rucClienteController.clear();
          _telefonoController.clear();
          _direccionController.clear();
          _ciudadController.clear();
          _provinciaController.clear();
          _paisController.clear();
          _codigoPostalController.clear();
          _emailController.clear();
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
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
        appBar: AppBar(
          title: const Text('CREAR CLIENTE'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Image(image: AssetImage('imagenes/Uniemp.png')),
              const SizedBox(
                height: 15,
              ),
              Text(
                'RUC: $ruc',
                style: const TextStyle(
                    fontSize: 18, color: Colors.white, backgroundColor: Color(0xFF04884C)),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _clienteController,
                decoration: const InputDecoration(labelText: 'Cliente'),
              ),
              TextField(
                controller: _rucClienteController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'RUC'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 170,
                    height: 70,
                    child: RadioListTile(
                      title: const Text('Crédito'),
                      value: "si",
                      groupValue: credito,
                      onChanged: (value) {
                        setState(() {
                          credito = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    height: 70,
                    child: RadioListTile(
                      title: const Text('Bloquear'),
                      value: "si",
                      groupValue: bloquear,
                      onChanged: (value) {
                        setState(() {
                          bloquear = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: _crearCliente, child: const Text('Crear Cliente'))
            ],
          )),
        ));
  }
}
