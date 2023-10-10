import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verCompras extends StatefulWidget {
  const verCompras ({super.key});

  @override
  _verComprasState createState() => _verComprasState();
}

class _verComprasState extends State<verCompras> {
  String? ruc;
  List<Map<String, dynamic>> comprasData = [];

  Future<void> fetchComprasData() async {
    try {
      String collectionNameCompras = '${ruc!}ORDEN DE COMPRA';
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionNameCompras)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'Numero': doc['Numero'],
            'Fecha': doc['Fecha'],
            'Proveedor': doc['Proveedor'],
            'RUC proveedor': doc['RUC proveedor'],
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
            
             'código P4': doc['código P4'] ?? '',
            'Producto4': doc['Producto4'] ?? '',
            'cantidad4': doc['cantidad4'] ?? '',
            'Precio Unitario4': doc['Precio Unitario4'] ?? '',

             'código P5': doc['código P5'] ?? '',
            'Producto5': doc['Producto5'] ?? '',
            'cantidad5': doc['cantidad5'] ?? '',
            'Precio Unitario5': doc['Precio Unitario5'] ?? '',

             'código P6': doc['código P6'] ?? '',
            'Producto6': doc['Producto6'] ?? '',
            'cantidad6': doc['cantidad6'] ?? '',
            'Precio Unitario6': doc['Precio Unitario6'] ?? '',
            'subtotal': doc['subtotal'],
            'iva': doc['iva'],
            'total': doc['total'],
            'Transporte': doc['Transporte'] ?? '',
            'TOTAL ORDEN DE COMPRA': doc['TOTAL ORDEN DE COMPRA'] ?? '',
            'anular':doc['anular'] ?? '',
          });
        }

        setState(() {
          comprasData = tempData;
        });
      } else {
        setState(() {
          comprasData = [
            {
              'Numero': 'No existen datos',
              'Fecha': '',
              'Proveedor': '',
              'RUC proveedor': '',
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

              'cod. P4': '',
              'Producto4': '',
              'cantidad4': '',
              'Precio Unitario4': '',

              'cod. P5': '',
              'Producto5': '',
              'cantidad5': '',
              'Precio Unitario5': '',

              'cod. P6': '',
              'Producto6': '',
              'cantidad6': '',
              'Precio Unitario6': '',
              'subtotal': '',
              'iva': '',
              'total': '',
              'Transporte': '',
              'TOTAL ORDEN DE COMPRA':'',
              'anular':'',
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
            content: Text('Ocurrió un error al extraer los datos de las Órdenes de Compra: ${e.toString()}'),
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
        comprasData = [
          {
            'Numero': 'Error al extraer datos',
            'Fecha': '',
            'Proveedor': '',
            'RUC proveedor': '',
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

            'cod. P4': '',
            'Producto4': '',
            'cantidad4': '',
            'Precio Unitario4': '',

            'cod. P5': '',
            'Producto5': '',
            'cantidad5': '',
            'Precio Unitario5': '',

            'cod. P6': '',
            'Producto6': '',
            'cantidad6': '',
            'Precio Unitario6': '',
            'subtotal': '',
            'iva': '',
            'total': '',
            'Transporte': '',
            'TOTAL ORDEN DE COMPRA': '',
            'anular':'',
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
        title: const Text('VER ÓRDENES DE COMPRA'),
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
              onPressed: fetchComprasData,
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
            if (comprasData.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: comprasData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Numero: ${comprasData[index]['Numero']}'),
                            Text('Fecha: ${comprasData[index]['Fecha']}'),
                            Text('crédito: ${comprasData[index]['crédito']}'),
                            Text('Proveedor: ${comprasData[index]['Proveedor']}'),
                            Text(
                                'RUC Proveedor: ${comprasData[index]['RUC proveedor']}'),
                            Text('código P1: ${comprasData[index]['código P1']}'),
                            Text(
                                'Producto 1: ${comprasData[index]['Producto1']}'),
                            Text(
                                'cantidad 1: ${comprasData[index]['cantidad1']}'),
                            Text(
                                'Precio Unitario 1: \$${comprasData[index]['Precio Unitario1']}'),
                            if (comprasData[index]['cod. P2'] != '') ...[
                              Text(
                                  'código P2: ${comprasData[index]['código P2']}'),
                              Text(
                                  'Producto 2: ${comprasData[index]['Producto2']}'),
                              Text(
                                  'cantidad 2: ${comprasData[index]['cantidad2']}'),
                              Text(
                                  'Precio Unitario 2: \$${comprasData[index]['Precio Unitario2']}'),
                            ],
                            if (comprasData[index]['cod. P3'] != '') ...[
                              Text(
                                  'código P3: ${comprasData[index]['código P3']}'),
                              Text(
                                  'Producto 3: ${comprasData[index]['Producto3']}'),
                              Text(
                                  'cantidad 3: ${comprasData[index]['cantidad3']}'),
                              Text(
                                  'Precio Unitario 3: \$${comprasData[index]['Precio Unitario3']}'),
                            ],

                             if (comprasData[index]['cod. P4'] != '') ...[
                              Text(
                                  'código P4: ${comprasData[index]['código P4']}'),
                              Text(
                                  'Producto 4: ${comprasData[index]['Producto4']}'),
                              Text(
                                  'cantidad 4: ${comprasData[index]['cantidad4']}'),
                              Text(
                                  'Precio Unitario 4: \$${comprasData[index]['Precio Unitario4']}'),
                            ],

                             if (comprasData[index]['cod. P5'] != '') ...[
                              Text(
                                  'código P5: ${comprasData[index]['código P5']}'),
                              Text(
                                  'Producto 5: ${comprasData[index]['Producto5']}'),
                              Text(
                                  'cantidad 5: ${comprasData[index]['cantidad5']}'),
                              Text(
                                  'Precio Unitario 5: \$${comprasData[index]['Precio Unitario5']}'),
                            ],

                             if (comprasData[index]['cod. P6'] != '') ...[
                              Text(
                                  'código P6: ${comprasData[index]['código P6']}'),
                              Text(
                                  'Producto 6: ${comprasData[index]['Producto6']}'),
                              Text(
                                  'cantidad 6: ${comprasData[index]['cantidad6']}'),
                              Text(
                                  'Precio Unitario 6: \$${comprasData[index]['Precio Unitario6']}'),
                            ],
                            Text(
                                'subtotal: \$${comprasData[index]['subtotal']}'),
                            Text('iva: \$${comprasData[index]['iva']}'),
                            Text('total: \$${comprasData[index]['total']}'),
                            
                              Text(
                                  'Transporte: \$${comprasData[index]['Transporte']}'),
                            Text(
                                  'TOTAL ORDEN DE COMPRA: \$${comprasData[index]['TOTAL ORDEN DE COMPRA']}'),
                                   Text(
                                  'anular: \$${comprasData[index]['anular']}'),
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
