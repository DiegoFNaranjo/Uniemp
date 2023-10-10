import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verNegocio extends StatefulWidget {
  const verNegocio({super.key});

  @override
  _verNegocioState createState() => _verNegocioState();
}

String? ruc;

class _verNegocioState extends State<verNegocio> {
  List<Map<String, dynamic>> negocioData = [];

  Future<void> fetchNegocioData() async {
    try {
      String collectionName = '${ruc!}NEGOCIO';
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'Razón Social': doc['Razón Social'],
            'RUC': doc['RUC'],
            'Teléfono': doc['Teléfono'],
            'Dirección': doc['Dirección'],
            'Ciudad': doc['Ciudad'],
            'Provincia': doc['Provincia'],
            'País': doc['País'],
            'Código Postal': doc['Código Postal'],
            'email': doc['email'],
          });
        }

        setState(() {
          negocioData = tempData;
        });
      } else {
        setState(() {
          negocioData = [
            {
              'Razón Social': 'No existen datos',
              'RUC.': '',
              'Teléfono': '',
              'Dirección': '',
              'Ciudad': '',
              'Provincia': '',
              'País': '',
              'Código Postal': '',
              'email': '',
            }
          ];
        });
      }
    } catch (e) {
      setState(() {
        negocioData = [
          {
            'Razón Social': 'Error al extraer datos',
            'RUC': '',
            'Teléfono': '',
            'Dirección': '',
            'Ciudad': '',
            'Provincia': '',
            'País': '',
            'Código Postal': '',
            'email': '',
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
        title: const Text('DATOS NEGOCIO REGISTRADO'),
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
              onPressed: fetchNegocioData,
              child: const Text('VER'),
            ),
            const SizedBox(height: 20),
            if (negocioData.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: negocioData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Razón Social: ${negocioData[index]['Razón Social']}'),
                            Text('RUC: ${negocioData[index]['RUC']}'),
                            Text('Teléfono: ${negocioData[index]['Teléfono']}'),
                            Text(
                                'Dirección: ${negocioData[index]['Dirección']}'),
                            Text('Ciudad: ${negocioData[index]['Ciudad']}'),
                            Text(
                                'Provincia: ${negocioData[index]['Provincia']}'),
                            Text('País: ${negocioData[index]['País']}'),
                            Text(
                                'Código Postal: ${negocioData[index]['Código Postal']}'),
                            Text('email: ${negocioData[index]['email']}'),
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
