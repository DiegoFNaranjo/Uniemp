import 'package:app_uniemp/menu_pages/customer/manage_customer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editarCliente extends StatefulWidget {
  const editarCliente({super.key});

  @override
  _editarClienteState createState() => _editarClienteState();
}

class _editarClienteState extends State<editarCliente> {
  final TextEditingController docController = TextEditingController();
  final TextEditingController bloquearController = TextEditingController();
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController codigoPostalController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController creditoController = TextEditingController();
  String? ruc;
  Map<String, dynamic> clienteData = {};

  Future<void> extraerYeditarDatos() async {
    try {
      final String numeroRUC = docController.text;
      String collectionName = '${ruc!}CLIENTE';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(numeroRUC.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          clienteData = data;
          clienteController.text = data['Razón Social'];
          rucController.text = data['RUC'];
          direccionController.text = data['Dirección'];
          ciudadController.text = data['Ciudad'];
          telefonoController.text = data['Teléfono'];
          provinciaController.text = data['Provincia'];
          paisController.text = data['País'];
          codigoPostalController.text = data['Código Postal'];
          creditoController.text = data['Crédito'];
          emailController.text = data['email'];
          bloquearController.text = data['Bloquear'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cliente no existe'),
              content: const Text('El RUC ingresado no existe'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Un error se ha presentado al cargar los datos: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  
  Future<void> actualizarDatosEnFirestore() async {
    if(docController.text == rucController.text){
    try {
      final String numeroRUC = docController.text;
      String collectionName = '${ruc!}CLIENTE';
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(numeroRUC.toString())
          .update({
        'Razón Social': clienteController.text,
        'RUC': rucController.text,
        'Dirección': direccionController.text,
        'Ciudad': ciudadController.text,
        'Teléfono': telefonoController.text,
        'Provincia': provinciaController.text,
        'País': paisController.text,
        'Código Postal': codigoPostalController.text,
        'Crédito': creditoController.text,
        'email': emailController.text,
        'Bloquear': bloquearController.text,
      });

             Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => clientes(),
                settings: RouteSettings(arguments: ruc)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El cliente ha sido actualizado',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
      
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Ocurrió un error: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }else{try {
      final String numeroRUCNuevo = rucController.text;
      String collectionName = '${ruc!}CLIENTE';
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(numeroRUCNuevo.toString())
          .set({
        'Razón Social': clienteController.text,
        'RUC': rucController.text,
        'Dirección': direccionController.text,
        'Ciudad': ciudadController.text,
        'Teléfono': telefonoController.text,
        'Provincia': provinciaController.text,
        'País': paisController.text,
        'Código Postal': codigoPostalController.text,
        'Crédito': creditoController.text,
        'email': emailController.text,
        'Bloquear': bloquearController.text,
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Actualización satisfactoria'),
            content: const Text('Los datos han sido actualizados'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => clientes(),
                settings: RouteSettings(arguments: ruc)));
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Ocurrió un error: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
    String collectionNameOld = '${ruc!}CLIENTE';
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection(collectionNameOld);
        QuerySnapshot querySnapshot = await collectionReference
            .where('RUC', isEqualTo: docController.text)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          await collectionReference.doc(docController.text).delete();
        }
  }
  
  docController.clear();
  clienteController.clear();
      rucController.clear();
      direccionController.clear();
      ciudadController.clear();
      telefonoController.clear();
      provinciaController.clear();
      paisController.clear();
      codigoPostalController.clear();
      creditoController.clear();
      emailController.clear();
      bloquearController.clear();
  }
  @override
  void dispose() {
    clienteController.dispose();
    rucController.dispose();
    direccionController.dispose();
    ciudadController.dispose();
    telefonoController.dispose();
    provinciaController.dispose();
    paisController.dispose();
    codigoPostalController.dispose();
    creditoController.dispose();
    emailController.dispose();
    bloquearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
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
                    fontSize: 18, color: Colors.white, backgroundColor: Color(0xFF04884C)),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: docController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ingrese el RUC'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: extraerYeditarDatos,
                child: const Text('Extraer datos'),
              ),
              if (clienteData.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text('Editar Datos:'),
                TextField(
                  controller: clienteController,
                  decoration: const InputDecoration(labelText: 'Razón Social'),
                ),
                TextField(
                  controller: rucController,
                  decoration: const InputDecoration(labelText: 'R.U.C.'),
                ),
                TextField(
                  controller: direccionController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                ),
                TextField(
                  controller: ciudadController,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                ),
                TextField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                ),
                TextField(
                  controller: provinciaController,
                  decoration: const InputDecoration(labelText: 'Provincia'),
                ),
                TextField(
                  controller: paisController,
                  decoration: const InputDecoration(labelText: 'País'),
                ),
                TextField(
                  controller: codigoPostalController,
                  decoration: const InputDecoration(labelText: 'Código Postal'),
                ),
                TextField(
                  controller: creditoController,
                  decoration: const InputDecoration(labelText: 'Crédito'),
                ),
                TextField(
                  controller: bloquearController,
                  decoration: const InputDecoration(labelText: 'Bloquear'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: actualizarDatosEnFirestore,
                  child: const Text('Actualizar datos'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
