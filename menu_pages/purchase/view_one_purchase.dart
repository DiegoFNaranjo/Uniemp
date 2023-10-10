import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class printCompra extends StatefulWidget {
  const printCompra ({super.key});

  @override
  _printCompraState createState() => _printCompraState();
}

class _printCompraState extends State<printCompra> {
  final TextEditingController _numeroCompraController =
      TextEditingController();
  String numero = '';
  String fecha = '';
  String credito = '';
  String rucProveedor = '';
  String proveedor = '';
  String? codigoP1 = '';
  String? producto1 = '';
  String? precioUnitario1 = '';
  String? cantidad1 = '';
  String? codigoP2 = '';
  String? producto2 = '';
  String? precioUnitario2 = '';
  String? cantidad2 = '';
  String? codigoP3 = '';
  String? producto3 = '';
  String? precioUnitario3 = '';
  String? cantidad3 = '';
  String? codigoP4 = '';
  String? producto4 = '';
  String? precioUnitario4 = '';
  String? cantidad4 = '';
  String? codigoP5 = '';
  String? producto5 = '';
  String? precioUnitario5 = '';
  String? cantidad5 = '';
  String? codigoP6 = '';
  String? producto6 = '';
  String? precioUnitario6 = '';
  String? cantidad6 = '';
  String? subtotal = '';
  String? iva = '';
  String? total = '';
  String? transporte = '';
  String? totalOrdenCompra = '';
String? anular ='';
  Map<String, dynamic> _ordenCompraData = {};
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

  String direccionProveedor = '';
  String ciudadProveedor = '';
  String provinciaProveedor = '';
  String paisProveedor = '';

  Future<void> _verCompra() async {
    String numeroDoc = _numeroCompraController.text;

    try {
      String collectionNameCotizacion = '${ruc!}ORDEN DE COMPRA';
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionNameCotizacion)
          .doc(numeroDoc)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> dataCompra =
            snapshot.data() as Map<String, dynamic>;

        setState(() {
          _ordenCompraData = dataCompra;
          numero = dataCompra['Numero'];
          fecha = dataCompra['Fecha'];
          credito = dataCompra['crédito'];
          rucProveedor = dataCompra['RUC proveedor'];
          proveedor = dataCompra['Proveedor'];
          codigoP1 = dataCompra['código P1'];
          producto1 = dataCompra['Producto1'];
          cantidad1 = dataCompra['cantidad1'];
          precioUnitario1 = dataCompra['Precio Unitario1'];
          codigoP2 = dataCompra['código P2'];
          producto2 = dataCompra['Producto2'];
          cantidad2 = dataCompra['cantidad2'];
          precioUnitario2 = dataCompra['Precio Unitario2'];
          codigoP3 = dataCompra['código P3'];
          producto3 = dataCompra['Producto3'];
          cantidad3 = dataCompra['cantidad3'];
          precioUnitario3 = dataCompra['Precio Unitario3'];

          codigoP4 = dataCompra['código P4'];
          producto4 = dataCompra['Producto4'];
          cantidad4 = dataCompra['cantidad4'];
          precioUnitario4 = dataCompra['Precio Unitario4'];

          codigoP5 = dataCompra['código P5'];
          producto5 = dataCompra['Producto5'];
          cantidad5 = dataCompra['cantidad5'];
          precioUnitario5 = dataCompra['Precio Unitario5'];

          codigoP6 = dataCompra['código P6'];
          producto6 = dataCompra['Producto6'];
          cantidad6 = dataCompra['cantidad6'];
          precioUnitario6 = dataCompra['Precio Unitario6'];
          subtotal = dataCompra['subtotal'];
          iva = dataCompra['iva'];
          total = dataCompra['total'];
          transporte = dataCompra['Transporte'];
          totalOrdenCompra = dataCompra['TOTAL ORDEN DE COMPRA'];
anular = dataCompra['anular'];
        });
        extraerProveedorDatos();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(' El número de Orden de Compra ingresado no existe'),
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
                'Un error se ha presentado al cargar los datos de la Orden de Compra: $e'),
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

  Future<void> extraerProveedorDatos() async {
    String collectionName = '${ruc!}PROVEEDOR';
    const String nombreProveedor = 'Proveedor';
    String bloquear = 'Bloquear';
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(collectionName).doc(rucProveedor);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;

    if (documentSnapshot.exists &&
        documentSnapshot.data() != null &&
        data?[bloquear] == 'no') {
      setState(() {
        direccionProveedor = data?['Dirección'] ?? '';
        ciudadProveedor = data?['Ciudad'] ?? '';
        provinciaProveedor = data?['Provincia'] ?? '';
        paisProveedor = data?['País'] ?? '';
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

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Orden de Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _numeroCompraController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ingrese el número de Orden de Compra',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _verCompra,
                child: const Text('Ver Orden de Compra'),
              ),
              const Image(image: AssetImage('imagenes/Uniemp.png')),
              const SizedBox(
                height: 15,
              ),
              Text(
                razonSocial,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                  fontSize: 12,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                ciudad,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                provincia,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                pais,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                telefono,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF04884C),
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF04884C),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 145,
                    height: 25,
                    child: Text('Orden de Compra #: $numero',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 145,
                    height: 25,
                    child: Text('Fecha: $fecha',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 80,
                    height: 25,
                    child: Text('crédito: $credito',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                  width: 230,
                  height: 25,
                  child: Text('Proveedor: $proveedor',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 140,
                  height: 25,
                  child: Text('RUC: $rucProveedor',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                    width: 230,
                    height: 20,
                    child: Text('Dirección: $direccionProveedor', style: const TextStyle(
                          fontSize: 12))),
                SizedBox(
                  width: 140,
                  height: 20,
                  child: Text('Ciudad: $ciudadProveedor',style: const TextStyle(
                          fontSize: 12 ),)
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                  width: 230,
                  height: 20,
                  child: Text('Provincia: $provinciaProveedor', style: const TextStyle(
                          fontSize: 12
                  ),)
                ),
                SizedBox(
                    width: 140, height: 20, child: Text('País: $paisProveedor', style: const TextStyle(
                          fontSize: 12)))
              ]),
              const SizedBox(height: 7),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                    width: 70,
                    height: 35,
                    child: Text('Código',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('Producto',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                  width: 40,
                  height: 35,
                  child: Text('cant',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                    width: 70,
                    height: 35,
                    child: Text('Precio U.',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child:
                        Text('$codigoP1', style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('$producto1',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: Text(
                      '$cantidad1',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: Text(
                      '\$$precioUnitario1',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child:
                        Text('$codigoP2', style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('$producto2',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: Text(
                      ' $cantidad2',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: Text(
                      '\$$precioUnitario2',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child:
                        Text('$codigoP3', style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('$producto3',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: Text(
                      '$cantidad3',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: Text(
                      '\$$precioUnitario3',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child:
                        Text('$codigoP4', style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('$producto4',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: Text(
                      '$cantidad4',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: Text(
                      '\$$precioUnitario4',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child:
                        Text('$codigoP5', style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('$producto5',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: Text(
                      '$cantidad5',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: Text(
                      '\$$precioUnitario5',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child:
                        Text('$codigoP6', style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 190,
                    height: 35,
                    child: Text('$producto6',
                        style: const TextStyle(fontSize: 13)),
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: Text(
                      '$cantidad6',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: Text(
                      '\$$precioUnitario6',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                  width: 180,
                  height: 60,
                  child: Text(
                    'Transporte: \$$transporte',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(
                  width: 180,
                  height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 20,
                          child: Text(
                            'SUBTOTAL: \$$subtotal',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 20,
                          child: Text(
                            'IVA (12%):   \$$iva',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 20,
                          child: Text(
                            'TOTAL:       \$$total',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                )
              ]),
            
Text('TOTAL ORDEN DE COMPRA: $totalOrdenCompra'),
          Text('anular: $anular'),
            ],
          ),
        ),
      ),
    );
  }
}
