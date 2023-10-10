import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class borrarProducto extends StatefulWidget {
  const borrarProducto({super.key});

  @override
  _borrarProductoState createState() => _borrarProductoState();
}

class _borrarProductoState extends State<borrarProducto> {
  final TextEditingController codigoProductoController =
      TextEditingController();

  String? ruc;

  Future<void> buscarOrden() async {
    try {
      String codigoProducto = codigoProductoController.text;
      String collectionName = '${ruc!}PRODUCTO';
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);
      QuerySnapshot querySnapshot = await collectionReference
          .where('código', isEqualTo: codigoProducto)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await collectionReference.doc(querySnapshot.docs[0].id).delete();

        setState(() {});
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Actualización satisfactoria'),
              content: const Text('El producto ha sido eliminado'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
        codigoProductoController.clear();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código del producto ingresado no existe'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
        codigoProductoController.clear();
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
      codigoProductoController.clear();
    }
  }

  @override
  void dispose() {
    codigoProductoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Producto'),
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
                controller: codigoProductoController,
                decoration: const InputDecoration(
                    labelText: 'ingrese el código del producto '),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: buscarOrden,
                child: const Text('ELIMINAR PRODUCTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
