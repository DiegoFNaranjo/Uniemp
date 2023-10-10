import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editarProducto extends StatefulWidget {
  const editarProducto({super.key});

  @override
  _editarProductoState createState() => _editarProductoState();
}

class _editarProductoState extends State<editarProducto> {
  final TextEditingController docController = TextEditingController();
  final TextEditingController productoController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController precioCompraController = TextEditingController();
  final TextEditingController precioVentaController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  String? ruc;
  Map<String, dynamic> productoData = {};

  Future<void> extraerYeditarDatos() async {
    try {
      final String codigoProducto = docController.text;
      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          productoData = data;
          codigoController.text = data['código'];
          productoController.text = data['producto'];
          cantidadController.text = data['cantidad'];
          precioCompraController.text = data['precio compra'];
          precioVentaController.text = data['precio venta'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
    if (docController.text == codigoController.text) {
      try {
        final String codigoProducto = docController.text;
        String collectionName = '${ruc!}PRODUCTO';
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(codigoProducto.toString())
            .update({
          'producto': productoController.text,
          'código': codigoController.text,
          'cantidad': cantidadController.text,
          'precio compra': precioCompraController.text,
          'precio venta': precioVentaController.text,
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
                    Navigator.of(context).pop();
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
    } else {
      try {
        final String codigoProducto = codigoController.text;
        String collectionName = '${ruc!}PRODUCTO';
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(codigoProducto.toString())
            .set({
          'producto': productoController.text,
          'código': codigoController.text,
          'cantidad': cantidadController.text,
          'precio compra': precioCompraController.text,
          'precio venta': precioVentaController.text,
        });
        String collectionNameOld = '${ruc!}PRODUCTO';
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection(collectionNameOld);
        QuerySnapshot querySnapshot = await collectionReference
            .where('código', isEqualTo: docController.text)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          await collectionReference.doc(docController.text).delete();
        }
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Actualización satisfactoria'),
              content: const Text(
                  'Los datos han sido actualizados con nuevo código'),
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
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Ocurrió un error al crear los nuevos datos y eliminar los anteriores: $e'),
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
    docController.clear();
    codigoController.clear();
    productoController.clear();
    cantidadController.clear();
    precioCompraController.clear();
    precioVentaController.clear();
  }

  @override
  void dispose() {
    codigoController.dispose();
    productoController.dispose();
    cantidadController.dispose();
    precioCompraController.dispose();
    precioVentaController.dispose();
    docController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
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
                decoration:
                    const InputDecoration(labelText: 'ingrese el código del Producto'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: extraerYeditarDatos,
                child: const Text('Extraer datos'),
              ),
              if (productoData.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text('Editar Datos:'),
                TextField(
                  controller: codigoController,
                  decoration: const InputDecoration(labelText: 'código'),
                ),
                TextField(
                  controller: productoController,
                  decoration: const InputDecoration(labelText: 'producto'),
                ),
                TextField(
                  controller: cantidadController,
                  decoration: const InputDecoration(labelText: 'cantidad'),
                ),
                TextField(
                  controller: precioCompraController,
                  decoration: const InputDecoration(labelText: 'precio compra'),
                ),
                TextField(
                  controller: precioVentaController,
                  decoration: const InputDecoration(labelText: 'precio venta'),
                ),
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
