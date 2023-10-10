import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class printNotaCredito extends StatefulWidget {
  const printNotaCredito({super.key});

  @override
  _printNotaCreditoState createState() => _printNotaCreditoState();
}

class _printNotaCreditoState extends State<printNotaCredito> {
  final TextEditingController _numeroNotaCreditoController =
      TextEditingController();
  String numero = '';
  String fecha = '';
  String credito = '';
  String rucCliente = '';
  String cliente = '';
  String? precioUnitario;
  String? cantidad = '';
  String? descripcion = '';
  String? subtotal = '';
  String? iva= '';
  String? total= '';
  

  Map<String, dynamic> _notaCreditoData = {};
  Map<String, dynamic> _negocioData = {};
  String? ruc;
  String negocio = '';
  String razonSocial = '';
  String direccion = '';
  String ciudad = '';
  String provincia = '';
  String pais = '';
  String telefono = '';
  String email = '';

  Future<void> _verNotaCredito() async {
    String numeroDoc = _numeroNotaCreditoController.text;

    try {
      String collectionNameNotaCredito = '${ruc!}NOTA DE CREDITO';
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionNameNotaCredito)
          .doc(numeroDoc)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> dataNotaCredito =
            snapshot.data() as Map<String, dynamic>;

        setState(() {
          _notaCreditoData = dataNotaCredito;
          numero = dataNotaCredito['numero'];
          fecha = dataNotaCredito['Fecha'];

          rucCliente = dataNotaCredito['RUC'];
          cliente = dataNotaCredito['Razón Social'];
          descripcion = dataNotaCredito['descripcion'];

          cantidad = dataNotaCredito['cantidad'];
          precioUnitario = dataNotaCredito['Precio Unitario'];

          subtotal = dataNotaCredito['subtotal'];
          iva = dataNotaCredito['iva'];
          total = dataNotaCredito['total'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(' El número de Nota de Crédito ingresado no existe'),
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
            content: Text(
                'Un error se ha presentado al cargar los datos de la Nota de Crédito: $e'),
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
    try {
      String collectionName = '${ruc!}NEGOCIO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(ruc)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _negocioData = data;
          razonSocial = data['Razón Social'];
          direccion = data['Dirección'];
          ciudad = data['Ciudad'];
          provincia = data['Provincia'];
          pais = data['País'];
          telefono = data['Teléfono'];
          email = data['email'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Negocio no existe'),
              content: const Text('El negocio no existe'),
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
            content: Text(
                'Un error se ha presentado al cargar los datos del negocio: $e'),
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

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Nota de Crédito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _numeroNotaCreditoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ingrese el número de la Nota de Crédito',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _verNotaCredito,
                child: const Text('Ver Nota de Crédito'),
              ),
              const Image(image: AssetImage('imagenes/Uniemp.png')),
              const SizedBox(
                height: 15,
              ),
              Text(
                razonSocial,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                '$ruc',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                direccion,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                ciudad,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                provincia,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                pais,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                telefono,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF04884C),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 250,
                    height: 25,
                    child: Text('Nota de Crédito #: $numero',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: Text('Fecha: $fecha',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                 
                ],
              ),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                  width: 370,
                  height: 25,
                  child: Text('RUC: $rucCliente',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
               
              ]),
              const SizedBox(height: 15),const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                
                SizedBox(
                  width: 370,
                  height: 25,
                  child: Text('Cliente: $cliente',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                
                  SizedBox(
                    width: 190,
                    height: 75,
                    child: Text('Descripción:\n $descripcion',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 75,
                    child: Text(
                      'cant.:\n $cantidad',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 75,
                    child: Text(
                      'Precio U.: \$$precioUnitario',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 140,
                    height: 35,
                    child: Text(
                      'SUBTOTAL: \$$subtotal',
                      style:
                          const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 35,
                    child: Text(
                      'IVA: \$$iva',
                      style:
                          const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    height: 35,
                    child: Text(
                      'TOTAL: \$$total',
                      style:
                          const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
