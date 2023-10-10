import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'menu_sale.dart';

class crearFactura extends StatefulWidget {
  const crearFactura({super.key});

  @override
  _crearFacturaState createState() => _crearFacturaState();
}

DateTime datetime = DateTime.now();
String dateStr = DateFormat('dd/MM/yyyy').format(datetime);

double cant1 = 0;
double cant2 = 0;
double cant3 = 0;
double cant4 = 0;
double cant5 = 0;
double cant6 = 0;

double precioU1 = 0.00;
double precioU2 = 0.00;
double precioU3 = 0.00;
double precioU4 = 0.00;
double precioU5 = 0.00;
double precioU6 = 0.00;
double valorTransporte = 0.00;

class _crearFacturaState extends State<crearFactura> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _rucClienteController = TextEditingController();
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _codigoProducto1Controller =
      TextEditingController();
  final TextEditingController _producto1Controller = TextEditingController();
  final TextEditingController _cantidad1Controller = TextEditingController();
  final TextEditingController _precio1Controller = TextEditingController();
  final TextEditingController _codigoProducto2Controller =
      TextEditingController();
  final TextEditingController _producto2Controller = TextEditingController();
  final TextEditingController _cantidad2Controller = TextEditingController();
  final TextEditingController _precio2Controller = TextEditingController();
  final TextEditingController _codigoProducto3Controller =
      TextEditingController();
  final TextEditingController _producto3Controller = TextEditingController();
  final TextEditingController _cantidad3Controller = TextEditingController();
  final TextEditingController _precio3Controller = TextEditingController();
  final TextEditingController _codigoProducto4Controller =
      TextEditingController();
  final TextEditingController _producto4Controller = TextEditingController();
  final TextEditingController _cantidad4Controller = TextEditingController();
  final TextEditingController _precio4Controller = TextEditingController();
  final TextEditingController _codigoProducto5Controller =
      TextEditingController();
  final TextEditingController _producto5Controller = TextEditingController();
  final TextEditingController _cantidad5Controller = TextEditingController();
  final TextEditingController _precio5Controller = TextEditingController();
  final TextEditingController _codigoProducto6Controller =
      TextEditingController();
  final TextEditingController _producto6Controller = TextEditingController();
  final TextEditingController _cantidad6Controller = TextEditingController();
  final TextEditingController _precio6Controller = TextEditingController();
  final TextEditingController _transporteController = TextEditingController();

  double get subtotal =>
      cant1 * precioU1 +
      cant2 * precioU2 +
      cant3 * precioU3 +
      cant4 * precioU4 +
      cant5 * precioU5 +
      cant6 * precioU6;
  double get iva => subtotal / 12;
  double get total => iva + subtotal;
  double get totalFactura => total + valorTransporte;
  String credito = 'no';
  int? numeroFactura;
  String? ruc;
  Map<String, dynamic> producto1Data = {};
  Map<String, dynamic> producto2Data = {};
  Map<String, dynamic> producto3Data = {};
  Map<String, dynamic> producto4Data = {};
  Map<String, dynamic> producto5Data = {};
  Map<String, dynamic> producto6Data = {};

  Map<String, dynamic> clienteData = {};

  Future<void> extraerClienteDatos() async {
    const String nombreCliente = 'Razon Social';
    String bloquear = 'Bloquear';
    String collectionName = '${ruc!}CLIENTE';
    String rucCliente = _rucClienteController.text;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(collectionName).doc(rucCliente);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;

    if (documentSnapshot.exists &&
        documentSnapshot.data() != null &&
        data?[bloquear] == 'no') {
      setState(() {
        clienteData = data!;
        _clienteController.text = data['Razón Social'];
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Advertencia'),
                content: const Text('Cliente no existe o está bloqueado'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cerrar'))
                ],
              ));
    }
  }

  Future<void> extraerProducto1Datos() async {
    try {
      String codigoProducto1 = _codigoProducto1Controller.text;

      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto1.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> dataP1 =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          producto1Data = dataP1;
          _codigoProducto1Controller.text = dataP1['código'];
          _producto1Controller.text = dataP1['producto'];
          _cantidad1Controller.text = dataP1['cantidad'];
          _precio1Controller.text = dataP1['precio venta'];
          cant1 = double.parse(_cantidad1Controller.text);
          precioU1 = double.parse(_precio1Controller.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
            content: Text('Un error se ha presentado al cargar los datos: $e'),
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

  Future<void> extraerProducto2Datos() async {
    try {
      String codigoProducto2 = _codigoProducto2Controller.text;

      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto2.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> dataP2 =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          producto2Data = dataP2;
          _codigoProducto2Controller.text = dataP2['código'];
          _producto2Controller.text = dataP2['producto'];
          _cantidad2Controller.text = dataP2['cantidad'];
          _precio2Controller.text = dataP2['precio venta'];
          cant2 = double.parse(_cantidad2Controller.text);
          precioU2 = double.parse(_precio2Controller.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
            content: Text('Un error se ha presentado al cargar los datos: $e'),
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

  Future<void> extraerProducto3Datos() async {
    try {
      String codigoProducto3 = _codigoProducto3Controller.text;

      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto3.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> dataP3 =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          producto3Data = dataP3;
          _codigoProducto3Controller.text = dataP3['código'];
          _producto3Controller.text = dataP3['producto'];
          _cantidad3Controller.text = dataP3['cantidad'];
          _precio3Controller.text = dataP3['precio venta'];
          cant3 = double.parse(_cantidad3Controller.text);
          precioU3 = double.parse(_precio3Controller.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
            content: Text('Un error se ha presentado al cargar los datos: $e'),
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

  Future<void> extraerProducto4Datos() async {
    try {
      String codigoProducto4 = _codigoProducto4Controller.text;

      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto4.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> dataP4 =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          producto4Data = dataP4;
          _codigoProducto4Controller.text = dataP4['código'];
          _producto4Controller.text = dataP4['producto'];
          _cantidad4Controller.text = dataP4['cantidad'];
          _precio4Controller.text = dataP4['precio venta'];
          cant4 = double.parse(_cantidad4Controller.text);
          precioU4 = double.parse(_precio4Controller.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
            content: Text('Un error se ha presentado al cargar los datos: $e'),
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

  Future<void> extraerProducto5Datos() async {
    try {
      String codigoProducto5 = _codigoProducto5Controller.text;

      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto5.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> dataP5 =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          producto5Data = dataP5;
          _codigoProducto5Controller.text = dataP5['código'];
          _producto5Controller.text = dataP5['producto'];
          _cantidad5Controller.text = dataP5['cantidad'];
          _precio5Controller.text = dataP5['precio venta'];
          cant5 = double.parse(_cantidad5Controller.text);
          precioU5 = double.parse(_precio5Controller.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
            content: Text('Un error se ha presentado al cargar los datos: $e'),
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

  Future<void> extraerProducto6Datos() async {
    try {
      String codigoProducto6 = _codigoProducto6Controller.text;

      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigoProducto6.toString())
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> dataP6 =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          producto6Data = dataP6;
          _codigoProducto6Controller.text = dataP6['código'];
          _producto6Controller.text = dataP6['producto'];
          _cantidad6Controller.text = dataP6['cantidad'];
          _precio6Controller.text = dataP6['precio venta'];
          cant6 = double.parse(_cantidad6Controller.text);
          precioU6 = double.parse(_precio6Controller.text);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto no existe'),
              content: const Text('El código ingresado no existe'),
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
            content: Text('Un error se ha presentado al cargar los datos: $e'),
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
  void _crearFactura() async {
    String rucCliente = _rucClienteController.text;
    String cliente = _clienteController.text;
    String codigoProducto1 = _codigoProducto1Controller.text;
    String producto1 = _producto1Controller.text;
    String cantidad1 = _cantidad1Controller.text;
    String precio1 = _precio1Controller.text;
    String codigoProducto2 = _codigoProducto2Controller.text;
    String producto2 = _producto2Controller.text;
    String cantidad2 = _cantidad2Controller.text;
    String precio2 = _precio2Controller.text;
    String codigoProducto3 = _codigoProducto3Controller.text;
    String producto3 = _producto3Controller.text;
    String cantidad3 = _cantidad3Controller.text;
    String precio3 = _precio3Controller.text;
    String codigoProducto4 = _codigoProducto4Controller.text;
    String producto4 = _producto4Controller.text;
    String cantidad4 = _cantidad4Controller.text;
    String precio4 = _precio4Controller.text;
    String codigoProducto5 = _codigoProducto5Controller.text;
    String producto5 = _producto5Controller.text;
    String cantidad5 = _cantidad5Controller.text;
    String precio5 = _precio5Controller.text;
    String codigoProducto6 = _codigoProducto6Controller.text;
    String producto6 = _producto6Controller.text;
    String cantidad6 = _cantidad6Controller.text;
    String precio6 = _precio6Controller.text;
    String transporte = _transporteController.text;

    if (_rucClienteController.text.isEmpty ||
        _rucClienteController.text.length != 13 ||
        _codigoProducto1Controller.text.isEmpty ||
        _producto1Controller.text.isEmpty ||
        _cantidad1Controller.text.isEmpty ||
        _precio1Controller.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Aviso'),
                content: const Text(
                    'Uno o más campos están vacíos o requieren revisión'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cerrar'))
                ],
              ));
    } else {
      try {
        String collectionNameFactura = '${ruc!}FACTURA';
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(collectionNameFactura)
            .orderBy('Numero', descending: true)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          numeroFactura = int.parse(querySnapshot.docs[0]['Numero'].toString());
          numeroFactura = numeroFactura! + 1;
        } else {
          numeroFactura = 10000;
        }

        await _firestore
            .collection(collectionNameFactura)
            .doc(numeroFactura.toString())
            .set({
          'Numero': numeroFactura.toString(),
          'Fecha': dateStr,
          'Cliente': cliente,
          'RUC cliente': rucCliente,
          'crédito': credito,
          'código P1': codigoProducto1,
          'Producto1': producto1,
          'cantidad1': cantidad1,
          'Precio Unitario1': precio1,
          'código P2': codigoProducto2,
          'Producto2': producto2,
          'cantidad2': cantidad2,
          'Precio Unitario2': precio2,
          'código P3': codigoProducto3,
          'Producto3': producto3,
          'cantidad3': cantidad3,
          'Precio Unitario3': precio3,
          'código P4': codigoProducto4,
          'Producto4': producto4,
          'cantidad4': cantidad4,
          'Precio Unitario4': precio4,
          'código P5': codigoProducto5,
          'Producto5': producto5,
          'cantidad5': cantidad5,
          'Precio Unitario5': precio5,
          'código P6': codigoProducto6,
          'Producto6': producto6,
          'cantidad6': cantidad6,
          'Precio Unitario6': precio6,
          'subtotal': subtotal.toStringAsFixed(2),
          'iva': iva.toStringAsFixed(2),
          'total': total.toStringAsFixed(2),
          'Transporte': transporte,
          'TOTAL FACTURA': totalFactura.toStringAsFixed(2),
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => venta(),
                settings: RouteSettings(arguments: ruc)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Factura creada satisfactoriamente',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
        _clienteController.clear();
        _rucClienteController.clear();
        _producto1Controller.clear();
        _cantidad1Controller.clear();
        _precio1Controller.clear();
        _producto2Controller.clear();
        _cantidad2Controller.clear();
        _precio2Controller.clear();
        _producto3Controller.clear();
        _cantidad3Controller.clear();
        _precio3Controller.clear();
        _producto4Controller.clear();
        _cantidad4Controller.clear();
        _precio4Controller.clear();
        _producto5Controller.clear();
        _cantidad5Controller.clear();
        _precio5Controller.clear();
        _producto6Controller.clear();
        _cantidad6Controller.clear();
        _precio6Controller.clear();
        _transporteController.clear();
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content:
                  Text('Ocurrió un error al grabar los datos: ${e.toString()}'),
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
        appBar: AppBar(
          title: const Text('CREAR FACTURA'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: Text('Fecha: $dateStr',
                          style: const TextStyle(fontSize: 13)),
                    ),
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: RadioListTile(
                        title: const Text('crédito',
                            style: TextStyle(fontSize: 12)),
                        value: "si",
                        groupValue: credito,
                        onChanged: (value) {
                          setState(() {
                            credito = value.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: RadioListTile(
                        title: const Text('contado',
                            style: TextStyle(fontSize: 13)),
                        value: "no",
                        groupValue: credito,
                        onChanged: (value) {
                          setState(() {
                            credito = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 15,
                        child:
                            Text('RUC Cliente', style: TextStyle(fontSize: 10)),
                      ),
                      SizedBox(
                        width: 180,
                        height: 15,
                        child: Text('Cliente', style: TextStyle(fontSize: 10)),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 25,
                        child: TextField(
                            controller: _rucClienteController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 13)),
                      ),
                      SizedBox(
                        width: 180,
                        height: 25,
                        child: TextField(
                            controller: _clienteController,
                            onTap: () => extraerClienteDatos(),
                            style: const TextStyle(fontSize: 13)),
                      )
                    ]),
                const SizedBox(height: 10),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 85, height: 15, child: Text('Código')),
                      SizedBox(width: 150, height: 15, child: Text('Producto')),
                      SizedBox(width: 50, height: 15, child: Text('cant.')),
                      SizedBox(width: 75, height: 15, child: Text('Precio U.')),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 85,
                      height: 40,
                      child: TextField(
                          controller: _codigoProducto1Controller,
                          style: const TextStyle(fontSize: 13)),
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                          controller: _producto1Controller,
                          onTap: () => extraerProducto1Datos(),
                          style: const TextStyle(fontSize: 13)),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: _cantidad1Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => cant1 = 0);
                          } else {
                            setState(() => cant1 = double.parse(value));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 40,
                      child: TextField(
                        controller: _precio1Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU1 = 0);
                          } else {
                            setState(
                              () => precioU1 = NumberFormat.simpleCurrency(
                                      locale: 'en-US', decimalDigits: 2)
                                  .format(value) as double,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 85,
                      height: 40,
                      child: TextField(
                        controller: _codigoProducto2Controller,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        controller: _producto2Controller,
                        onTap: () => extraerProducto2Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: _cantidad2Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => cant2 = 0);
                          } else {
                            setState(() => cant2 = double.parse(value));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 40,
                      child: TextField(
                        controller: _precio2Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU2 = 0);
                          } else {
                            setState(
                              () => precioU2 = NumberFormat.simpleCurrency(
                                      locale: 'en-US', decimalDigits: 2)
                                  .format(value) as double,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 85,
                      height: 40,
                      child: TextField(
                        controller: _codigoProducto3Controller,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        controller: _producto3Controller,
                        onTap: () => extraerProducto3Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: _cantidad3Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => cant3 = 0);
                          } else {
                            setState(() => cant3 = double.parse(value));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 40,
                      child: TextField(
                        controller: _precio3Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU3 = 0);
                          } else {
                            setState(
                              () => precioU3 = NumberFormat.simpleCurrency(
                                      locale: 'en-US', decimalDigits: 2)
                                  .format(value) as double,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 85,
                      height: 40,
                      child: TextField(
                        controller: _codigoProducto4Controller,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        controller: _producto4Controller,
                        onTap: () => extraerProducto4Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: _cantidad4Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => cant4 = 0);
                          } else {
                            setState(() => cant4 = double.parse(value));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 40,
                      child: TextField(
                        controller: _precio4Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU4 = 0);
                          } else {
                            setState(
                              () => precioU4 = NumberFormat.simpleCurrency(
                                      locale: 'en-US', decimalDigits: 2)
                                  .format(value) as double,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 85,
                      height: 40,
                      child: TextField(
                        controller: _codigoProducto5Controller,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        controller: _producto5Controller,
                        onTap: () => extraerProducto5Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: _cantidad5Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => cant5 = 0);
                          } else {
                            setState(() => cant5 = double.parse(value));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 40,
                      child: TextField(
                        controller: _precio5Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU5 = 0);
                          } else {
                            setState(
                              () => precioU5 = NumberFormat.simpleCurrency(
                                      locale: 'en-US', decimalDigits: 2)
                                  .format(value) as double,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 85,
                      height: 40,
                      child: TextField(
                        controller: _codigoProducto6Controller,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        controller: _producto6Controller,
                        onTap: () => extraerProducto6Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: _cantidad6Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => cant6 = 0);
                          } else {
                            setState(() => cant6 = double.parse(value));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 40,
                      child: TextField(
                        controller: _precio6Controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU6 = 0);
                          } else {
                            setState(
                              () => precioU6 = NumberFormat.simpleCurrency(
                                      locale: 'en-US', decimalDigits: 2)
                                  .format(value) as double,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 20,
                      child: Text('SUBTOTAL'),
                    ),
                    SizedBox(
                      width: 90,
                      height: 20,
                      child: Text('IVA'),
                    ),
                    SizedBox(
                      width: 140,
                      height: 20,
                      child: Text('TOTAL'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 20,
                      child: Text(
                        NumberFormat.simpleCurrency(
                                locale: 'en-US', decimalDigits: 2)
                            .format(subtotal),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      height: 20,
                      child: Text(
                        NumberFormat.simpleCurrency(
                                locale: 'en-US', decimalDigits: 2)
                            .format(iva),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 20,
                      child: Text(
                        NumberFormat.simpleCurrency(
                                locale: 'en-US', decimalDigits: 2)
                            .format(total),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _transporteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Transporte'),
                  style: const TextStyle(fontSize: 13),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() => valorTransporte = 0);
                    } else {
                      setState(() => valorTransporte = double.parse(value));
                    }
                  },
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const SizedBox(
                      width: 185,
                      height: 15,
                      child: Text('TOTAL FACTURA inc. transp.:')),
                  SizedBox(
                    width: 185,
                    height: 15,
                    child: Text(
                      NumberFormat.simpleCurrency(
                              locale: 'en-US', decimalDigits: 2)
                          .format(totalFactura),
                    ),
                  ),
                ]),
                ElevatedButton(
                    onPressed: _crearFactura,
                    child: const Text('Crear Factura')),
              ],
            ))));
  }
}
