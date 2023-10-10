import 'package:app_uniemp/menu_pages/purchase/menu_purchase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class editarCompra extends StatefulWidget {
  const editarCompra({super.key});

  @override
  _editarCompraState createState() => _editarCompraState();
}

DateTime datetime = DateTime.now();
String dateStr = DateFormat('dd/MM/yyyy').format(datetime);
double cant1 = 0;
double cant2 = 0;
double cant3 = 0;
double cant4 = 0;
double cant5 = 0;
double cant6 = 0;
double? valorTransporte = 0.00;
double precioU1 = 0.00;
double precioU2 = 0.00;
double precioU3 = 0.00;
double precioU4 = 0.00;
double precioU5 = 0.00;
double precioU6 = 0.00;

class _editarCompraState extends State<editarCompra> {
  double get subtotal =>
      cant1 * precioU1 +
      cant2 * precioU2 +
      cant3 * precioU3 +
      cant4 * precioU4 +
      cant5 * precioU5 +
      cant6 * precioU6;
  double get iva => subtotal / 12;
  double get total => iva + subtotal;
  double get totalOrdenCompra => total + valorTransporte!;
  final TextEditingController docController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController _rucProveedorController = TextEditingController();
  final TextEditingController _proveedorController = TextEditingController();
  final TextEditingController precioUnitario1Controller =
      TextEditingController();
  final TextEditingController _codigoProducto1Controller =
      TextEditingController();
  final TextEditingController producto1Controller = TextEditingController();
  final TextEditingController cantidad1Controller = TextEditingController();
  final TextEditingController precioUnitario2Controller =
      TextEditingController();
  final TextEditingController _codigoProducto2Controller =
      TextEditingController();
  final TextEditingController producto2Controller = TextEditingController();
  final TextEditingController cantidad2Controller = TextEditingController();
  final TextEditingController precioUnitario3Controller =
      TextEditingController();
  final TextEditingController _codigoProducto3Controller =
      TextEditingController();
  final TextEditingController producto3Controller = TextEditingController();
  final TextEditingController cantidad3Controller = TextEditingController();

  final TextEditingController precioUnitario4Controller =
      TextEditingController();
  final TextEditingController _codigoProducto4Controller =
      TextEditingController();
  final TextEditingController producto4Controller = TextEditingController();
  final TextEditingController cantidad4Controller = TextEditingController();

  final TextEditingController precioUnitario5Controller =
      TextEditingController();
  final TextEditingController _codigoProducto5Controller =
      TextEditingController();
  final TextEditingController producto5Controller = TextEditingController();
  final TextEditingController cantidad5Controller = TextEditingController();

  final TextEditingController precioUnitario6Controller =
      TextEditingController();
  final TextEditingController _codigoProducto6Controller =
      TextEditingController();
  final TextEditingController producto6Controller = TextEditingController();
  final TextEditingController cantidad6Controller = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController transporteController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  final TextEditingController ivaController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController creditoController = TextEditingController();
  final TextEditingController totalOrdenCompraController =
      TextEditingController();
  final TextEditingController anularController = TextEditingController();
  String? ruc;
  String? credito;
  Map<String, dynamic> ordenCompraData = {};
  Map<String, dynamic> producto1Data = {};
  Map<String, dynamic> producto2Data = {};
  Map<String, dynamic> producto3Data = {};
  Map<String, dynamic> producto4Data = {};
  Map<String, dynamic> producto5Data = {};
  Map<String, dynamic> producto6Data = {};

  Map<String, dynamic> proveedorData = {};

  Future<void> extraerProveedorDatos() async {
    String bloquear = 'Bloquear';
    String collectionName = '${ruc!}PROVEEDOR';
    String rucProveedor = _rucProveedorController.text;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(collectionName).doc(rucProveedor);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;

    if (documentSnapshot.exists &&
        documentSnapshot.data() != null &&
        data?[bloquear] == 'no') {
      setState(() {
        proveedorData = data!;
        _proveedorController.text = data['Proveedor'];
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Advertencia'),
                content: const Text('Proveedor no existe o está bloqueado'),
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
          producto1Controller.text = dataP1['producto'];
          cantidad1Controller.text = dataP1['cantidad'];
          precioUnitario1Controller.text = dataP1['precio compra'];
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
            content: Text(
                'Un error se ha presentado al cargar los datos del Producto 1: $e'),
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
          producto2Controller.text = dataP2['producto'];
          cantidad2Controller.text = dataP2['cantidad'];
          precioUnitario2Controller.text = dataP2['precio compra'];
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
            content: Text(
                'Un error se ha presentado al cargar los datos del Producto 2: $e'),
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
          producto3Controller.text = dataP3['producto'];
          cantidad3Controller.text = dataP3['cantidad'];
          precioUnitario3Controller.text = dataP3['precio compra'];
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
            content: Text(
                'Un error se ha presentado al cargar los datos del Producto 3: $e'),
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
          producto4Controller.text = dataP4['producto'];
          cantidad4Controller.text = dataP4['cantidad'];
          precioUnitario4Controller.text = dataP4['precio compra'];
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
            content: Text(
                'Un error se ha presentado al cargar los datos del Producto 1: $e'),
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
          producto5Controller.text = dataP5['producto'];
          cantidad5Controller.text = dataP5['cantidad'];
          precioUnitario5Controller.text = dataP5['precio compra'];
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
            content: Text(
                'Un error se ha presentado al cargar los datos del Producto 1: $e'),
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
          producto6Controller.text = dataP6['producto'];
          cantidad6Controller.text = dataP6['cantidad'];
          precioUnitario6Controller.text = dataP6['precio compra'];
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
            content: Text(
                'Un error se ha presentado al cargar los datos del Producto 1: $e'),
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

  Future<void> extraerYeditarDatos() async {
 ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debe re-ingresar cantidades y valores sino el total dará cero',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );

    try {
      String collectionName = '${ruc!}ORDEN DE COMPRA';
      final String numeroOrdenCompra = docController.text;

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(numeroOrdenCompra.toString())
          .get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      if (documentSnapshot.exists) {
        setState(() {
          ordenCompraData = data;
          numeroController.text = data['Numero'];
          fechaController.text = data['Fecha'];
          _proveedorController.text = data['Proveedor'];
          _rucProveedorController.text = data['RUC proveedor'];
          _codigoProducto1Controller.text = data['código P1'];
          producto1Controller.text = data['Producto1'];
          cantidad1Controller.text = data['cantidad1'];
          precioUnitario1Controller.text = data['Precio Unitario1'];
          _codigoProducto2Controller.text = data['código P2'] ?? '';
          producto2Controller.text = data['Producto2'];
          cantidad2Controller.text = data['cantidad2'] ?? '';
          precioUnitario2Controller.text = data['Precio Unitario2'] ?? '';
          _codigoProducto3Controller.text = data['código P3'] ?? '';
          producto3Controller.text = data['Producto3'] ?? '';
          cantidad3Controller.text = data['cantidad3'] ?? '';
          precioUnitario3Controller.text = data['Precio Unitario3'] ?? '';

          _codigoProducto4Controller.text = data['código P4'] ?? '';
          producto4Controller.text = data['Producto4'] ?? '';
          cantidad4Controller.text = data['cantidad4'] ?? '';
          precioUnitario4Controller.text = data['Precio Unitario4'] ?? '';

          _codigoProducto5Controller.text = data['código P5'] ?? '';
          producto5Controller.text = data['Producto5'] ?? '';
          cantidad5Controller.text = data['cantidad5'] ?? '';
          precioUnitario5Controller.text = data['Precio Unitario5'] ?? '';

          _codigoProducto6Controller.text = data['código P6'] ?? '';
          producto6Controller.text = data['Producto6'] ?? '';
          cantidad6Controller.text = data['cantidad6'] ?? '';
          precioUnitario6Controller.text = data['Precio Unitario6'] ?? '';
          subtotalController.text = data['subtotal'].toString();
          ivaController.text = data['iva'].toString();
          totalController.text = data['total'].toString();
          transporteController.text = data['Transporte'].toString();
          creditoController.text = data['crédito'];
          totalOrdenCompraController.text = data['TOTAL ORDEN DE COMPRA'];
          anularController.text = data['anular'];
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cotización no existe'),
              content: const Text(
                  'El número de Cotización ingresado no existe o está anulada'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
        docController.clear();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                'Un error se ha presentado al extraer los datos de la Cotización : $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      docController.clear();
    }
  }

  Future<void> actualizarDatosEnFirestore() async {
    try {
      String collectionName = '${ruc!}ORDEN DE COMPRA';
      final String numeroOrdenCompra = docController.text;

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(numeroOrdenCompra.toString())
          .update({
        'Numero': numeroController.text,
        'Fecha': dateStr,
        'Proveedor': _proveedorController.text,
        'RUC proveedor': _rucProveedorController.text,
        'crédito': creditoController.text,
        'código P1': _codigoProducto1Controller.text,
        'Producto1': producto1Controller.text,
        'cantidad1': cantidad1Controller.text,
        'Precio Unitario1': precioUnitario1Controller.text,
        'código P2': _codigoProducto2Controller.text,
        'Producto2': producto2Controller.text,
        'cantidad2': cantidad2Controller.text,
        'Precio Unitario2': precioUnitario2Controller.text,
        'código P3': _codigoProducto3Controller.text,
        'Producto3': producto3Controller.text,
        'cantidad3': cantidad3Controller.text,
        'Precio Unitario3': precioUnitario3Controller.text,
        'código P4': _codigoProducto4Controller.text,
        'Producto4': producto4Controller.text,
        'cantidad4': cantidad4Controller.text,
        'Precio Unitario4': precioUnitario4Controller.text,
        'código P5': _codigoProducto5Controller.text,
        'Producto5': producto5Controller.text,
        'cantidad5': cantidad5Controller.text,
        'Precio Unitario5': precioUnitario5Controller.text,
        'código P6': _codigoProducto6Controller.text,
        'Producto6': producto6Controller.text,
        'cantidad6': cantidad6Controller.text,
        'Precio Unitario6': precioUnitario6Controller.text,
        'subtotal': subtotal.toStringAsFixed(2),
        'iva': iva.toStringAsFixed(2),
        'total': total.toStringAsFixed(2),
        'Transporte': transporteController.text,
        'TOTAL ORDEN DE COMPRA': totalOrdenCompra.toStringAsFixed(2),
        'anular': anularController.text,
      });

      setState(() {
        double iva = 0.00;
        double subtotal = 0.00;
        double total = 0.00;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => compra(),
              settings: RouteSettings(arguments: ruc)));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Orden de Compra editada satisfactoriamente',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  backgroundColor: Color(0xFF04884C))),
        ),
      );
      numeroController.clear();
      cantidad1Controller.clear();
      producto1Controller.clear();
      precioUnitario1Controller.clear();
      producto2Controller.clear();
      cantidad2Controller.clear();
      precioUnitario2Controller.clear();
      producto3Controller.clear();
      cantidad3Controller.clear();
      precioUnitario3Controller.clear();

      producto4Controller.clear();
      cantidad4Controller.clear();
      precioUnitario4Controller.clear();

      producto5Controller.clear();
      cantidad5Controller.clear();
      precioUnitario5Controller.clear();

      producto6Controller.clear();
      cantidad6Controller.clear();
      precioUnitario6Controller.clear();
      subtotalController.clear();
      ivaController.clear();
      totalController.clear();
      transporteController.clear();
      creditoController.clear();
      docController.clear();
      anularController.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Ocurrió un error: $e'),
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
  void dispose() {
    fechaController.dispose();
    numeroController.dispose();
    cantidad1Controller.dispose();
    producto1Controller.dispose();
    precioUnitario1Controller.dispose();
    producto2Controller.dispose();
    cantidad2Controller.dispose();
    precioUnitario2Controller.dispose();
    producto3Controller.dispose();
    cantidad3Controller.dispose();
    precioUnitario3Controller.dispose();

    producto4Controller.dispose();
    cantidad4Controller.dispose();
    precioUnitario4Controller.dispose();

    producto5Controller.dispose();
    cantidad5Controller.dispose();
    precioUnitario5Controller.dispose();

    producto6Controller.dispose();
    cantidad6Controller.dispose();
    precioUnitario6Controller.dispose();
    transporteController.dispose();
    docController.dispose();
    anularController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Orden de Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Image(image: AssetImage('imagenes/Uniemp.png')),
              const SizedBox(
                height: 15,
              ),
              Text(
                'RUC: $ruc',
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    backgroundColor: Color(0xFF04884C)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: docController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'ingrese el número de la Orden de Compra'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: extraerYeditarDatos,
                child: const Text('Extraer datos'),
              ),
              if (ordenCompraData.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text('Editar Datos:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 25,
                      child: TextField(
                          controller: numeroController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Número Orden de Compra'),
                          style: const TextStyle(fontSize: 13)),
                    ),
                    SizedBox(
                      width: 80,
                      height: 25,
                      child: TextField(
                          controller: fechaController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Fecha'),
                          style: const TextStyle(fontSize: 13)),
                    ),
                    SizedBox(
                      width: 120,
                      height: 25,
                      child: TextField(
                          controller: creditoController,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'crédito'),
                          style: const TextStyle(fontSize: 13)),
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
                        child: Text('RUC Proveedor',
                            style: TextStyle(fontSize: 10)),
                      ),
                      SizedBox(
                        width: 180,
                        height: 15,
                        child:
                            Text('Proveedor', style: TextStyle(fontSize: 10)),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 180,
                          height: 25,
                          child: TextField(
                            controller: _rucProveedorController,
                            keyboardType: TextInputType.number,
                          )),
                      SizedBox(
                        width: 180,
                        height: 25,
                        child: TextField(
                          controller: _proveedorController,
                          keyboardType: TextInputType.number,
                          onTap: () => extraerProveedorDatos(),
                        ),
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
                      height: 75,
                      child: TextField(
                        controller: _codigoProducto1Controller,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 75,
                      child: TextField(
                        controller: producto1Controller,
                        onTap: () => extraerProducto1Datos(),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 75,
                      child: TextField(
                        controller: cantidad1Controller,
                        keyboardType: TextInputType.number,
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
                      height: 75,
                      child: TextField(
                        controller: precioUnitario1Controller,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU1 = 0);
                          } else {
                            setState(() => precioU1 = double.parse(value));
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
                      height: 75,
                      child: TextField(
                        controller: _codigoProducto2Controller,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 75,
                      child: TextField(
                        controller: producto2Controller,
                        onTap: () => extraerProducto2Datos(),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 75,
                      child: TextField(
                        controller: cantidad2Controller,
                        keyboardType: TextInputType.number,
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
                      height: 75,
                      child: TextField(
                        controller: precioUnitario2Controller,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU2 = 0);
                          } else {
                            setState(() => precioU2 = double.parse(value));
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
                      height: 75,
                      child: TextField(
                        controller: _codigoProducto3Controller,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 75,
                      child: TextField(
                        controller: producto3Controller,
                        onTap: () => extraerProducto3Datos(),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 75,
                      child: TextField(
                        controller: cantidad3Controller,
                        keyboardType: TextInputType.number,
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
                      height: 75,
                      child: TextField(
                        controller: precioUnitario3Controller,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => precioU3 = 0);
                          } else {
                            setState(() => precioU3 = double.parse(value));
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
                        controller: producto4Controller,
                        onTap: () => extraerProducto4Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: cantidad4Controller,
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
                        controller: precioUnitario4Controller,
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
                        controller: producto5Controller,
                        onTap: () => extraerProducto5Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: cantidad5Controller,
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
                        controller: precioUnitario5Controller,
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
                        controller: producto6Controller,
                        onTap: () => extraerProducto6Datos(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        controller: cantidad6Controller,
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
                        controller: precioUnitario6Controller,
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
                      height: 35,
                      child: Text('SUBTOTAL'),
                    ),
                    SizedBox(
                      width: 90,
                      height: 35,
                      child: Text('IVA'),
                    ),
                    SizedBox(
                      width: 140,
                      height: 35,
                      child: Text('TOTAL'),
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
                        NumberFormat.simpleCurrency(
                                locale: 'en-US', decimalDigits: 2)
                            .format(subtotal),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      height: 35,
                      child: Text(
                        NumberFormat.simpleCurrency(
                                locale: 'en-US', decimalDigits: 2)
                            .format(iva),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 35,
                      child: Text(
                        NumberFormat.simpleCurrency(
                                locale: 'en-US', decimalDigits: 2)
                            .format(total),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: transporteController,
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
                      child: Text('TOTAL ORDEN DE COMPRA:')),
                  SizedBox(
                    width: 185,
                    height: 15,
                    child: Text(
                      NumberFormat.simpleCurrency(
                              locale: 'en-US', decimalDigits: 2)
                          .format(totalOrdenCompra),
                    ),
                  ),
                ]),
                TextField(
                    controller: anularController,
                    decoration: const InputDecoration(labelText: 'anular'),
                    style: const TextStyle(fontSize: 13)),
                ElevatedButton(
                  onPressed: actualizarDatosEnFirestore,
                  child: const Text(
                    'Actualizar datos',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
