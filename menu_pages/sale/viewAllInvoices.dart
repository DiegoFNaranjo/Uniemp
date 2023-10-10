import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verFacturas extends StatefulWidget {
  const verFacturas({super.key});

  @override
  _verFacturasState createState() => _verFacturasState();
}

class _verFacturasState extends State<verFacturas> {
  String? ruc;
  List<Map<String, dynamic>> facturasData = [];

  Future<void> fetchFacturasData() async {
    try {
      String collectionNameFacturas = '${ruc!}FACTURA';
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionNameFacturas)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'Numero': doc['Numero'],
            'Fecha': doc['Fecha'],
            'Cliente': doc['Cliente'],
            'RUC cliente': doc['RUC cliente'],
            'crédito': doc['crédito'],
            'código P1': doc['código P1'],
            'Producto1': doc['Producto1'],
            'cantidad1': doc['cantidad1'],
            'Precio Unitario1': doc['Precio Unitario1'],
            'código P2': doc['código P2'] ?? '',
            'Producto2': doc['Producto2'] ?? '',
            'cantidad2': doc['cantidad2'] ?? '',
            'Precio Unitario2': doc['Precio Unitario2'] ?? '',
            'código P3': doc['código P3'] ?? '',
            'Producto3': doc['Producto3'] ?? '',
            'cantidad3': doc['cantidad3'] ?? '',
            'Precio Unitario3': doc['Precio Unitario3'] ?? '',
            'subtotal': doc['subtotal'],
            'iva': doc['iva'],
            'total': doc['total'],
            'Transporte': doc['Transporte'] ?? '',
            'TOTAL FACTURA': doc['TOTAL FACTURA'] ?? '',
          });
        }

        setState(() {
          facturasData = tempData;
        });
      } else {
        setState(() {
          facturasData = [
            {
              'Numero': 'No existen datos',
              'Fecha': '',
              'Cliente': '',
              'RUC cliente': '',
              'crédito': '',
              'código P1': '',
              'Producto1': '',
              'cantidad1': '',
              'Precio Unitario1': '',
              'cod. P2': '',
              'Producto2': '',
              'cantidad2': '',
              'Precio Unitario2': '',
              'cod. P3': '',
              'Producto3': '',
              'cantidad3': '',
              'Precio Unitario3': '',
              'subtotal': '',
              'iva': '',
              'total': '',
              'Transporte': '',
              'TOTAL FACTURA': '',
            }
          ];
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Ocurrió un error al extraer los datos: ${e.toString()}'),
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
      setState(() {
        facturasData = [
          {
            'Numero': 'Error al extraer datos',
            'Fecha': '',
            'Cliente': '',
            'RUC cliente': '',
            'crédito': '',
            'código P1': '',
            'Producto1': '',
            'cantidad1': '',
            'Precio Unitario1': '',
            'cod. P2': '',
            'Producto2': '',
            'cantidad2': '',
            'Precio Unitario2': '',
            'cod. P3': '',
            'Producto3': '',
            'cantidad3': '',
            'Precio Unitario3': '',
            'subtotal': '',
            'iva': '',
            'total': '',
            'Transporte': '',
            'TOTAL FACTURA':'',
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
        title: const Text('VER FACTURAS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('imagenes/Uniemp.png')),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: fetchFacturasData,
              child: const Text('VER'),
            ),
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
            const SizedBox(height: 20),
            if (facturasData.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: facturasData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Numero: ${facturasData[index]['Numero']}'),
                            Text('Fecha: ${facturasData[index]['Fecha']}'),
                            Text('crédito: ${facturasData[index]['crédito']}'),
                            Text('Cliente: ${facturasData[index]['Cliente']}'),
                            Text(
                                'RUC cliente: ${facturasData[index]['RUC cliente']}'),
                            Text('código P1: ${facturasData[index]['código P1']}'),
                            Text(
                                'Producto 1: ${facturasData[index]['Producto1']}'),
                            Text(
                                'cantidad 1: ${facturasData[index]['cantidad1']}'),
                            Text(
                                'Precio Unitario 1: \$${facturasData[index]['Precio Unitario1']}'),
                            if (facturasData[index]['cod. P2'] != '') ...[
                              Text(
                                  'código P2: ${facturasData[index]['código P2']}'),
                              Text(
                                  'Producto 2: ${facturasData[index]['Producto2']}'),
                              Text(
                                  'cantidad 2: ${facturasData[index]['cantidad2']}'),
                              Text(
                                  'Precio Unitario 2: \$${facturasData[index]['Precio Unitario2']}'),
                            ],
                            if (facturasData[index]['cod. P3'] != '') ...[
                              Text(
                                  'código P3: ${facturasData[index]['código P3']}'),
                              Text(
                                  'Producto 3: ${facturasData[index]['Producto3']}'),
                              Text(
                                  'cantidad 3: ${facturasData[index]['cantidad3']}'),
                              Text(
                                  'Precio Unitario 3: \$${facturasData[index]['Precio Unitario3']}'),
                            ],
                            Text(
                                'subtotal: \$${facturasData[index]['subtotal']}'),
                            Text('iva: \$${facturasData[index]['iva']}'),
                            Text('total: \$${facturasData[index]['total']}'),
                            
                              Text(
                                  'Transporte: \$${facturasData[index]['Transporte']}'),
                                  Text('TOTAL FACTURA incluye transporte: \$${facturasData[index]['TOTAL FACTURA']}'),
                            
                          ],
                        ),
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
