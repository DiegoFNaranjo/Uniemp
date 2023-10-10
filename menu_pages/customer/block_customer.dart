import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'manage_customer.dart';

class bloquearCliente extends StatefulWidget {
  const bloquearCliente({super.key});

  @override
  _bloquearClienteState createState() => _bloquearClienteState();
}

class _bloquearClienteState extends State<bloquearCliente> {
  final TextEditingController rucClienteController = TextEditingController();
  String? ruc;
  Map<String, dynamic> clienteData = {};

  Future<void> buscarCliente() async {
    try {
      String collectionNameCliente = '${ruc!}CLIENTE';
      final String rucCliente = rucClienteController.text;
      const String Bloquear = 'Bloquear';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionNameCliente)
          .doc(rucCliente.toString())
          .get();
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (documentSnapshot.exists && data?[Bloquear] == 'no') {
        await FirebaseFirestore.instance
            .collection(collectionNameCliente)
            .doc(rucCliente.toString())
            .update({
          'Bloquear': 'si',
        });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => clientes(),
                settings: RouteSettings(arguments: ruc)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El cliente ha sido bloqueado',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
        rucClienteController.clear();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cliente no existe o está bloqueado'),
              content: const Text(
                  'El número de Cliente no existe o ya fue bloqueado'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
        rucClienteController.clear();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Un error se ha presentado: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      rucClienteController.clear();
    }
  }

  @override
  void dispose() {
    rucClienteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloquear Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Image(image: AssetImage('imagenes/Uniemp.png')),
              const SizedBox(
                height: 15,
              ),
              Text(
                'RUC: $ruc',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    backgroundColor: Color(0xFF04884C)),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: rucClienteController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText:
                        'ingrese el número de RUC del cliente a bloquear '),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: buscarCliente,
                child: const Text('BLOQUEAR CLIENTE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
