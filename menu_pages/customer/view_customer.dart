import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verCliente extends StatefulWidget {
  const verCliente({super.key});

  @override
  _verClienteState createState() => _verClienteState();
}

class _verClienteState extends State<verCliente> {
  List<Map<String, dynamic>> clientes = [];
  String? ruc;
  Future<void> fetchClientes() async {
    try {
      String collectionName = '${ruc!}CLIENTE';
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'Razón Social': doc['Razón Social'],
            'RUC': doc['RUC'],
            'Dirección': doc['Dirección'],
            'Ciudad': doc['Ciudad'],
            'Provincia': doc['Provincia'],
            'País': doc['País'],
            'Código Postal': doc['Código Postal'],
            'Teléfono': doc['Teléfono'],
            'email': doc['email'],
            'Crédito': doc['Crédito'],
            'Bloquear': doc['Bloquear'],
          });
        }

        setState(() {
          clientes = tempData;
        });
      } else {
        setState(() {
          clientes = [
            {
              'Razón Social': 'No existen datos',
              'RUC': '',
              'Dirección': '',
              'Ciudad': '',
              'Provincia': '',
              'País': '',
              'Código Postal': '',
              'Teléfono': '',
              'email': '',
              'Crédito': '',
              'Bloquear': '',
            }
          ];
        });
      }
    } catch (e) {
      setState(() {
        clientes = [
          {
            'Razón Social': 'Error al extraer datos',
            'RUC': '',
            'Dirección': '',
            'Ciudad': '',
            'Provincia': '',
            'País': '',
            'Código Postal': '',
            'Teléfono': '',
            'email': '',
            'Crédito': '',
            'Bloquear': '',
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
        title: const Text('VER CLIENTES'),
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
              onPressed: fetchClientes,
              child: const Text('VER'),
            ),
            const SizedBox(height: 20),
            if (clientes.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'Razón Social: ${clientes[index]['Razón Social']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('RUC: ${clientes[index]['RUC']}'),
                          Text('Teléfono: ${clientes[index]['Teléfono']}'),
                          Text('Dirección: ${clientes[index]['Dirección']}'),
                          Text('Ciudad: ${clientes[index]['Ciudad']}'),
                          Text('Provincia: ${clientes[index]['Provincia']}'),
                          Text('País: ${clientes[index]['País']}'),
                          Text(
                              'Código Postal: ${clientes[index]['Código Postal']}'),
                          Text('email: ${clientes[index]['email']}'),
                          Text('Crédito: ${clientes[index]['Crédito']}'),
                          Text('Bloquear: ${clientes[index]['Bloquear']}'),
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
