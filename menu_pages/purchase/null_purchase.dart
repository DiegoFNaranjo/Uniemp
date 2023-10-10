import 'package:app_uniemp/menu_pages/purchase/menu_purchase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class anularCompra extends StatefulWidget {
  const anularCompra({super.key});

  @override
  _anularCompraState createState() => _anularCompraState();
}

class _anularCompraState extends State<anularCompra> {
  final TextEditingController numeroOrdenController = TextEditingController();
  String? ruc;

  Future<void> buscarOrden() async {
    try {
      String collectionNameCompra = '${ruc!}ORDEN DE COMPRA';
      final String numeroOrdenCompra = numeroOrdenController.text;
      const String anular = 'Anulada';
      
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection(collectionNameCompra)
          .doc(numeroOrdenCompra);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (documentSnapshot.exists &&
          documentSnapshot.data() != null &&
          data?[anular] == 'no') {
        await FirebaseFirestore.instance
            .collection(collectionNameCompra)
            .doc(numeroOrdenCompra)
            .update({
          anular: 'ANULADA',
          'subtotal': '0.00',
          'iva': '0.00',
          'total': '0.00',
        });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => compra(),
                settings: RouteSettings(arguments: ruc)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La orden de compra ha sido anulada',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
        numeroOrdenController.clear();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Orden de Compra no existe'),
              content: const Text(
                  'El número de Orden de Compra ingresado no existe o ya ha sido anulado'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
        numeroOrdenController.clear();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Un error se ha presentado al extraer los datos: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      numeroOrdenController.clear();
    }
  }

  @override
  void dispose() {
    numeroOrdenController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anular Orden de Compra'),
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
                controller: numeroOrdenController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'ingrese el número de orden de compra '),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: buscarOrden,
                child: const Text('ANULAR ORDEN DE COMPRA'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
