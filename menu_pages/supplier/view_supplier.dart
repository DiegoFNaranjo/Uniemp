import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verProveedor extends StatefulWidget {
  const verProveedor({super.key});

  @override
  _verProveedorState createState() => _verProveedorState();
}

class _verProveedorState extends State<verProveedor> {
  List<Map<String, dynamic>> proveedores = [];
  String? ruc;
  Future<void> fetchClientes() async {
    try {
      String collectionName = '${ruc!}PROVEEDOR';
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> tempData = [];
        for (var doc in querySnapshot.docs) {
          tempData.add({
            'Proveedor': doc['Proveedor'],
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
          proveedores = tempData;
        });
      } else {
        setState(() {
          proveedores = [
            {
              'Proveedor': 'No existen datos',
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
        proveedores = [
          {
            'Proveedor': 'Error al extraer datos',
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
        title: const Text('VER PROVEEDORES'),
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
            if (proveedores.isEmpty)
              const Text(
                '',
                style: TextStyle(fontSize: 20),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: proveedores.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'Proveedor: ${proveedores[index]['Proveedor']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('RUC: ${proveedores[index]['RUC']}'),
                          Text('Teléfono: ${proveedores[index]['Teléfono']}'),
                          Text('Dirección: ${proveedores[index]['Dirección']}'),
                          Text('Ciudad: ${proveedores[index]['Ciudad']}'),
                          Text('Provincia: ${proveedores[index]['Provincia']}'),
                          Text('País: ${proveedores[index]['País']}'),
                          Text(
                              'Código Postal: ${proveedores[index]['Código Postal']}'),
                          Text('email: ${proveedores[index]['email']}'),
                          Text('Crédito: ${proveedores[index]['Crédito']}'),
                          Text('Bloquear: ${proveedores[index]['Bloquear']}'),
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
