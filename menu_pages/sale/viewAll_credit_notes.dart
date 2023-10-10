import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verNotasCredito extends StatefulWidget {
  const verNotasCredito({super.key});

  @override
  _verNotasCreditoState createState() => _verNotasCreditoState();
}

class _verNotasCreditoState extends State<verNotasCredito> {
  String? ruc;
  List<Map<String, String>> notasDeCredito = [];

  Future<void> fetchNotasDeCredito() async {
    try {
      String collectionNameNotaCredito = '${ruc!}NOTA DE CREDITO';
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionNameNotaCredito)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, String>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'numero': doc['numero'],
            'Razón Social': doc['Razón Social'],
            'RUC': doc['RUC'],
            'Fecha': doc['Fecha'],
            'descripcion': doc['descripcion'],
            'cantidad': doc['cantidad'],
            'Precio Unitario': doc['Precio Unitario'],
            'subtotal': doc['subtotal'],
            'iva': doc['iva'],
            'total': doc['total'],
          });
        }

        setState(() {
          notasDeCredito = tempData;
        });
      } else {
        setState(() {
          notasDeCredito = [
            {
              'numero': '',
              'Razón Social': 'No hay datos',
              'RUC': '',
              'Fecha': '',
              'descripcion': '',
              'cantidad': '',
              'Precio Unitario': '',
              'subtotal': '',
              'iva': '',
              'total': '',
            }
          ];
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        notasDeCredito = [
          {
            'numero': 'Error al extraer datos',
            'Razón Social': '',
            'RUC': '',
            'Fecha': '',
            'descripcion': '',
            'cantidad': '',
            'Precio Unitario': '',
            'subtotal': '',
            'iva': '',
            'total': '',
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
        title: const Text('VER NOTAS DE CREDITO'),
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
                  fontSize: 18, color:Colors.white, backgroundColor: Color(0xFF04884C)),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: fetchNotasDeCredito,
              child: const Text('VER'),
            ),
            const SizedBox(height: 20),
            if (notasDeCredito.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: notasDeCredito.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('numero: ${notasDeCredito[index]['numero']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Razón Social: ${notasDeCredito[index]['Razón Social']}'),
                          Text('RUC: ${notasDeCredito[index]['RUC']}'),
                          Text('Fecha: ${notasDeCredito[index]['Fecha']}'),
                          Text(
                              'descripcion: ${notasDeCredito[index]['descripcion']}'),
                          Text(
                              'cantidad: ${notasDeCredito[index]['cantidad']}'),
                          Text(
                              'Precio Unitario: ${notasDeCredito[index]['Precio Unitario']}'),
                          Text(
                              'subtotal: \$${notasDeCredito[index]['subtotal']}'),
                          Text('iva: \$${notasDeCredito[index]['iva']}'),
                          Text('total: \$${notasDeCredito[index]['total']}'),
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
