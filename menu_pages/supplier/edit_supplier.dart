import 'package:app_uniemp/menu_pages/supplier/manage_supplier.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editarProveedor extends StatefulWidget {
  const editarProveedor({super.key});

  @override
  _editarProveedorState createState() => _editarProveedorState();
}

class _editarProveedorState extends State<editarProveedor> {
  final TextEditingController docController = TextEditingController();
  final TextEditingController bloquearController = TextEditingController();
  final TextEditingController proveedorController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codigoPostalController = TextEditingController();
  final TextEditingController creditoController = TextEditingController();
  String? ruc;
  Map<String, dynamic> proveedorData = {};

  Future<void> extraerYeditarDatos() async {
    try {
      String collectionName = '${ruc!}PROVEEDOR';

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docController.text.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          proveedorData = data;
          proveedorController.text = data['Proveedor'];
          rucController.text = data['RUC'];
          direccionController.text = data['Dirección'];
          ciudadController.text = data['Ciudad'];
          telefonoController.text = data['Teléfono'];
          provinciaController.text = data['Provincia'];
          paisController.text = data['País'];
          codigoPostalController.text = data['Código Postal'];
          emailController.text = data['email'];
          creditoController.text = data['Crédito'];
          bloquearController.text = data['Bloquear'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Proveedor no existe'),
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
    if (rucController.text == docController.text) {
      try {
        String collectionName = '${ruc!}PROVEEDOR';

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(docController.text.toString())
            .update({
          'Proveedor': proveedorController.text,
          'RUC': rucController.text,
          'Dirección': direccionController.text,
          'Ciudad': ciudadController.text,
          'Teléfono': telefonoController.text,
          'Provincia': provinciaController.text,
          'País': paisController.text,
          'Código Postal': codigoPostalController.text,
          'email': emailController.text,
          'Crédito': creditoController.text,
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
                          builder: (context) => proveedor(),
                          settings: RouteSettings(arguments: ruc)),
                    );
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
              content: Text('Ocurrió un error al grabar los nuevos datos: $e'),
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
    } else {
      try {
        String collectionNameNew = '${ruc!}PROVEEDOR';

        await FirebaseFirestore.instance
            .collection(collectionNameNew)
            .doc(rucController.text.toString())
            .set({
          'Proveedor': proveedorController.text,
          'RUC': rucController.text,
          'Dirección': direccionController.text,
          'Ciudad': ciudadController.text,
          'Teléfono': telefonoController.text,
          'Provincia': provinciaController.text,
          'País': paisController.text,
          'Código Postal': codigoPostalController.text,
          'email': emailController.text,
          'Crédito': creditoController.text,
          'Bloquear': bloquearController.text,
        });
        String collectionNameOld = '${ruc!}PROVEEDOR';
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection(collectionNameOld);
        QuerySnapshot querySnapshot = await collectionReference
            .where('RUC', isEqualTo: docController.text)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          await collectionReference.doc(docController.text).delete();
        }
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Actualización satisfactoria con nuevo RUC'),
              content: const Text('Los datos han sido actualizados'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => proveedor(),
                          settings: RouteSettings(arguments: ruc)),
                    );
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
              content: Text(
                  'Ocurrió un error al crear el nuevo documento y eliminar el anterior: $e'),
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

      proveedorController.clear();
      rucController.clear();
      direccionController.clear();
      ciudadController.clear();
      telefonoController.clear();
      provinciaController.clear();
      paisController.clear();
      codigoPostalController.clear();
      emailController.clear();
      docController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Proveedor'),
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
                controller: docController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ingrese el RUC'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: extraerYeditarDatos,
                child: const Text('Extraer datos'),
              ),
              if (proveedorData.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text('Editar Datos:'),
                TextField(
                  controller: proveedorController,
                  decoration: const InputDecoration(labelText: 'Proveedor'),
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
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'email'),
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
