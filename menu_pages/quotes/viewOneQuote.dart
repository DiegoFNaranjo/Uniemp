import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class printCotizacion extends StatefulWidget {
  const printCotizacion ({super.key});

  @override
  _printCotizacionState createState() => _printCotizacionState();
}

class _printCotizacionState extends State<printCotizacion> {
  final TextEditingController _numeroCotizacionController =
      TextEditingController();
  String numero = '';
  String fecha = '';
  String credito = '';
  String rucCliente = '';
  String cliente = '';
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
  String? totalCotizacion = '';

  Map<String, dynamic> _cotizacionData = {};
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

  String direccionCliente = '';
  String ciudadCliente = '';
  String provinciaCliente = '';
  String paisCliente = '';

  Future<void> _verCotizacion() async {
    String numeroDoc = _numeroCotizacionController.text;

    try {
      String collectionNameCotizacion = '${ruc!}COTIZACION';
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionNameCotizacion)
          .doc(numeroDoc)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> dataCotizacion =
            snapshot.data() as Map<String, dynamic>;

        setState(() {
          _cotizacionData = dataCotizacion;
          numero = dataCotizacion['Numero'];
          fecha = dataCotizacion['Fecha'];
          credito = dataCotizacion['crédito'];
          rucCliente = dataCotizacion['RUC cliente'];
          cliente = dataCotizacion['Cliente'];
          codigoP1 = dataCotizacion['código P1'];
          producto1 = dataCotizacion['Producto1'];
          cantidad1 = dataCotizacion['cantidad1'];
          precioUnitario1 = dataCotizacion['Precio Unitario1'];
          codigoP2 = dataCotizacion['código P2'];
          producto2 = dataCotizacion['Producto2'];
          cantidad2 = dataCotizacion['cantidad2'];
          precioUnitario2 = dataCotizacion['Precio Unitario2'];
          codigoP3 = dataCotizacion['código P3'];
          producto3 = dataCotizacion['Producto3'];
          cantidad3 = dataCotizacion['cantidad3'];
          precioUnitario3 = dataCotizacion['Precio Unitario3'];

          codigoP4 = dataCotizacion['código P4'];
          producto4 = dataCotizacion['Producto4'];
          cantidad4 = dataCotizacion['cantidad4'];
          precioUnitario4 = dataCotizacion['Precio Unitario4'];

          codigoP5 = dataCotizacion['código P5'];
          producto5 = dataCotizacion['Producto5'];
          cantidad5 = dataCotizacion['cantidad5'];
          precioUnitario5 = dataCotizacion['Precio Unitario5'];

          codigoP6 = dataCotizacion['código P6'];
          producto6 = dataCotizacion['Producto6'];
          cantidad6 = dataCotizacion['cantidad6'];
          precioUnitario6 = dataCotizacion['Precio Unitario6'];
          subtotal = dataCotizacion['subtotal'];
          iva = dataCotizacion['iva'];
          total = dataCotizacion['total'];
          transporte = dataCotizacion['Transporte'];
          totalCotizacion = dataCotizacion['TOTAL COTIZACIÓN'];
        });
        extraerClienteDatos();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(' El número de Cotización ingresado no existe'),
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
                'Un error se ha presentado al cargar los datos de la Cotización: $e'),
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

  Future<void> extraerClienteDatos() async {
    String collectionName = '${ruc!}CLIENTE';
    const String nombreCliente = 'Razón Social';
    String bloquear = 'Bloquear';
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(collectionName).doc(rucCliente);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;

    if (documentSnapshot.exists &&
        documentSnapshot.data() != null &&
        data?[bloquear] == 'no') {
      setState(() {
        direccionCliente = data?['Dirección'] ?? '';
        ciudadCliente = data?['Ciudad'] ?? '';
        provinciaCliente = data?['Provincia'] ?? '';
        paisCliente = data?['País'] ?? '';
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

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Cotización'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _numeroCotizacionController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ingrese el número de Cotización',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _verCotizacion,
                child: const Text('Ver Cotización'),
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
                    child: Text('Cotización #: $numero',
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
                  child: Text('Cliente: $cliente',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 140,
                  height: 25,
                  child: Text('RUC: $rucCliente',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                    width: 230,
                    height: 20,
                    child: Text('Dirección: $direccionCliente', style: const TextStyle(
                          fontSize: 12))),
                SizedBox(
                  width: 140,
                  height: 20,
                  child: Text('Ciudad: $ciudadCliente',style: const TextStyle(
                          fontSize: 12 ),)
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                  width: 230,
                  height: 20,
                  child: Text('Provincia: $provinciaCliente', style: const TextStyle(
                          fontSize: 12
                  ),)
                ),
                SizedBox(
                    width: 140, height: 20, child: Text('País: $paisCliente', style: const TextStyle(
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
            
Text('TOTAL COTIZACIÓN inc transp: $totalCotizacion'),
          
            ],
          ),
        ),
      ),
    );
  }
}
