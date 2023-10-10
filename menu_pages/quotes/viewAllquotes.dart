import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verCotizaciones extends StatefulWidget {
  const verCotizaciones ({super.key});

  @override
  _verCotizacionesState createState() => _verCotizacionesState();
}

class _verCotizacionesState extends State<verCotizaciones> {
  String? ruc;
  List<Map<String, dynamic>> cotizacionesData = [];

  Future<void> fetchCotizacionesData() async {
    try {
      String collectionNameCotizaciones = '${ruc!}COTIZACION';
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionNameCotizaciones)
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
            'TOTAL COTIZACIÓN': doc['TOTAL COTIZACIÓN'] ?? '',
          });
        }

        setState(() {
          cotizacionesData = tempData;
        });
      } else {
        setState(() {
          cotizacionesData = [
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
              'TOTAL COTIZACIÓN':'',
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
        cotizacionesData = [
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
            'TOTAL COTIZACIÓN': '',
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
        title: const Text('VER COTIZACIONES'),
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
              onPressed: fetchCotizacionesData,
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
            if (cotizacionesData.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: cotizacionesData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Numero: ${cotizacionesData[index]['Numero']}'),
                            Text('Fecha: ${cotizacionesData[index]['Fecha']}'),
                            Text('crédito: ${cotizacionesData[index]['crédito']}'),
                            Text('Cliente: ${cotizacionesData[index]['Cliente']}'),
                            Text(
                                'RUC cliente: ${cotizacionesData[index]['RUC cliente']}'),
                            Text('código P1: ${cotizacionesData[index]['código P1']}'),
                            Text(
                                'Producto 1: ${cotizacionesData[index]['Producto1']}'),
                            Text(
                                'cantidad 1: ${cotizacionesData[index]['cantidad1']}'),
                            Text(
                                'Precio Unitario 1: \$${cotizacionesData[index]['Precio Unitario1']}'),
                            if (cotizacionesData[index]['cod. P2'] != '') ...[
                              Text(
                                  'código P2: ${cotizacionesData[index]['código P2']}'),
                              Text(
                                  'Producto 2: ${cotizacionesData[index]['Producto2']}'),
                              Text(
                                  'cantidad 2: ${cotizacionesData[index]['cantidad2']}'),
                              Text(
                                  'Precio Unitario 2: \$${cotizacionesData[index]['Precio Unitario2']}'),
                            ],
                            if (cotizacionesData[index]['cod. P3'] != '') ...[
                              Text(
                                  'código P3: ${cotizacionesData[index]['código P3']}'),
                              Text(
                                  'Producto 3: ${cotizacionesData[index]['Producto3']}'),
                              Text(
                                  'cantidad 3: ${cotizacionesData[index]['cantidad3']}'),
                              Text(
                                  'Precio Unitario 3: \$${cotizacionesData[index]['Precio Unitario3']}'),
                            ],

                             if (cotizacionesData[index]['cod. P4'] != '') ...[
                              Text(
                                  'código P4: ${cotizacionesData[index]['código P4']}'),
                              Text(
                                  'Producto 4: ${cotizacionesData[index]['Producto4']}'),
                              Text(
                                  'cantidad 4: ${cotizacionesData[index]['cantidad4']}'),
                              Text(
                                  'Precio Unitario 4: \$${cotizacionesData[index]['Precio Unitario4']}'),
                            ],

                             if (cotizacionesData[index]['cod. P5'] != '') ...[
                              Text(
                                  'código P5: ${cotizacionesData[index]['código P5']}'),
                              Text(
                                  'Producto 5: ${cotizacionesData[index]['Producto5']}'),
                              Text(
                                  'cantidad 5: ${cotizacionesData[index]['cantidad5']}'),
                              Text(
                                  'Precio Unitario 5: \$${cotizacionesData[index]['Precio Unitario5']}'),
                            ],

                             if (cotizacionesData[index]['cod. P6'] != '') ...[
                              Text(
                                  'código P6: ${cotizacionesData[index]['código P6']}'),
                              Text(
                                  'Producto 6: ${cotizacionesData[index]['Producto6']}'),
                              Text(
                                  'cantidad 6: ${cotizacionesData[index]['cantidad6']}'),
                              Text(
                                  'Precio Unitario 6: \$${cotizacionesData[index]['Precio Unitario6']}'),
                            ],
                            Text(
                                'subtotal: \$${cotizacionesData[index]['subtotal']}'),
                            Text('iva: \$${cotizacionesData[index]['iva']}'),
                            Text('total: \$${cotizacionesData[index]['total']}'),
                            
                              Text(
                                  'Transporte: \$${cotizacionesData[index]['Transporte']}'),
                            Text(
                                  'TOTAL COTIZACIÓN inc. transporte: \$${cotizacionesData[index]['TOTAL COTIZACIÓN']}'),
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
