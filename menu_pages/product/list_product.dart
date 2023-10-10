import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verProducto extends StatefulWidget {
  const verProducto({super.key});

  @override
  _verProductoState createState() => _verProductoState();
}

class _verProductoState extends State<verProducto> {
  List<Map<String, dynamic>> productos = [];
  String? ruc;

  Future<void> fetchProductos() async {
    try {
      String collectionName = '${ruc!}PRODUCTO';
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'producto': doc['producto'],
            'código': doc['código'],
            'precio_venta': doc['precio venta'],
            'cantidad': doc['cantidad'],
          });
        }

        setState(() {
          productos = tempData;
        });
      } else {
        setState(() {
          productos = [
            {
              'producto': 'No hay datos',
              'código': '',
              'precio_venta': '',
              'cantidad': '',
            }
          ];
        });
      }
    } catch (e) {
      setState(() {
        productos = [
          {
            'producto': 'Error al extraer datos',
            'código': '',
            'precio_venta': '',
            'cantidad': '',
          }
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VER PRODUCTOS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            ElevatedButton(
              onPressed: fetchProductos,
              child: const Text('VER'),
            ),
            const SizedBox(height: 20),
            if (productos.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Producto: ${productos[index]['producto']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código: ${productos[index]['código']}'),
                          Text(
                              'Precio de Venta: \$${productos[index]['precio_venta']}'),
                          Text('Cantidad: ${productos[index]['cantidad']}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
