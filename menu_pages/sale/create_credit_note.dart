import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class crearNotaCredito extends StatefulWidget {
  const crearNotaCredito({super.key});

  @override
  _crearNotaCreditoState createState() => _crearNotaCreditoState();
}

DateTime datetime = DateTime.now();
String dateStr = DateFormat('dd/MM/yyyy').format(datetime);
double cant1 = 0;
double precioU1 = 0;
String? ruc;

class _crearNotaCreditoState extends State<crearNotaCredito> {
  String? Cliente = '';
  String? direccion = '';
  String? ciudad = '';
  String? provincia = '';
  String? pais = '';
  double get subtotal => cant1 * precioU1;
  double get iva => subtotal / 12;
  double get total => iva + subtotal;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _rucClienteController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  int? numeroNC;

  void _crearNotaCredito() async {
    String rucCliente = _rucClienteController.text;
    String descripcion = _descripcionController.text;
    String cantidad = _cantidadController.text;
    String precio = _precioController.text;

    if (_rucClienteController.text.isEmpty ||
        _descripcionController.text.isEmpty ||
        _cantidadController.text.isEmpty ||
        _precioController.text.isEmpty) {
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
        String collectionNameNotaCredito = '${ruc!}NOTA DE CREDITO';
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(collectionNameNotaCredito)
            .orderBy('numero', descending: true)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          numeroNC = int.parse(querySnapshot.docs[0]['numero'].toString());
          numeroNC = numeroNC! + 1;
        } else {
          numeroNC = 1000;
        }
        await _firestore
            .collection(collectionNameNotaCredito)
            .doc(numeroNC.toString())
            .set({
          'numero': numeroNC.toString(),
          'Razón Social': Cliente,
          'RUC': rucCliente,
          'Fecha': dateStr,
          'descripcion': descripcion,
          'cantidad': cantidad,
          'Precio Unitario': precio,
          'subtotal': subtotal.toStringAsFixed(2),
          'iva': iva.toStringAsFixed(2),
          'total': total.toStringAsFixed(2),
        });
        _clienteController.clear();
        _rucClienteController.clear();
        _descripcionController.clear();
        _cantidadController.clear();
        _precioController.clear();
      } catch (e) {
        print('Error:$e');
      }
    }
  }

  Future<void> extraerClienteDatos() async {
    String rucCliente = _rucClienteController.text;
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
        Cliente = data?[nombreCliente] ?? '';
        _clienteController.text = Cliente!;
        direccion = data?['Dirección'] ?? '';
        ciudad = data?['Ciudad'] ?? '';
        provincia = data?['Provincia'] ?? '';
        pais = data?['País'] ?? '';
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
      _rucClienteController.clear();
    }
  }

  @override
  void dispose() {
    _rucClienteController.dispose();
    _descripcionController.dispose();
    _cantidadController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
        appBar: AppBar(
          title: const Text('CREAR NOTA DE CREDITO'),
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 270,
                    height: 30,
                    child: TextField(
                      controller: _rucClienteController,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: 'RUC Cliente'),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: Text('Fecha: $dateStr'),
                  ),
                ],
              ),const SizedBox(
                height: 15,
              ),Column(mainAxisAlignment: MainAxisAlignment.start,
               children:[
               SizedBox(
                width: 200,
                height: 20,
                child: TextField(
                  controller: _clienteController,
                  decoration: const InputDecoration(hintText: 'Cliente', border: InputBorder.none),
                  onTap: extraerClienteDatos,
                ),
              ),
              SizedBox(
                width: 200,
                height: 15,
                child: Text('Dirección: $direccion'),
              ),
              SizedBox(
                width: 200,
                height: 15,
                child: Text('Ciudad: $ciudad'),
              ),
              SizedBox(
                width: 200,
                height: 15,
                child: Text('Provincia: $provincia'),
              ),
              SizedBox(
                width: 200,
                height: 15,
                child: Text('País: $pais'),
              ),
              const SizedBox(
                height: 15,
              ),],),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 235,
                    height: 75,
                    child: TextField(
                      controller: _descripcionController,
                      decoration:
                          const InputDecoration(labelText: 'Descripcion'),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 75,
                    child: TextField(
                      controller: _cantidadController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'cant.'),
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
                      controller: _precioController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Precio U.'),
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
              ElevatedButton(
                  onPressed: _crearNotaCredito,
                  child: const Text('Crear Nota de Credito'))
            ],
          )),
        ));
  }
}
