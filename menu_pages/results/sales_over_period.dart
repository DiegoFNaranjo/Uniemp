import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ventasPeriodo extends StatefulWidget {
  const ventasPeriodo({super.key});

  @override
  _ventasPeriodoState createState() => _ventasPeriodoState();
}

class _ventasPeriodoState extends State<ventasPeriodo> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String? ruc;
  String? totalVentas;
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> _fetchAndSumTotal() async {
    try {
      String collectionNameFactura = '${ruc!}FACTURA';
      final CollectionReference ventasCollection =
          FirebaseFirestore.instance.collection(collectionNameFactura);

      String formattedStartDate = DateFormat('dd/MM/yyyy').format(_startDate);
      String formattedEndDate = DateFormat('dd/MM/yyyy').format(_endDate);

      QuerySnapshot querySnapshot = await ventasCollection
          .where('Fecha', isGreaterThanOrEqualTo: formattedStartDate)
          .where('Fecha', isLessThanOrEqualTo: formattedEndDate)
          .get();

      if (querySnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No existen datos en el rango seleccionado', style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    backgroundColor: Color(0xFF04884C)
          ),
        )));
        return;
      }

      double totalSum = querySnapshot.docs
          .map<double>((doc) => double.tryParse(doc['subtotal']) ?? 0)
          .reduce((value, element) => value + element);
      

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Total ventas antes de IVA: \$${(totalSum).toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white,
              fontSize: 20, backgroundColor: Color(0xFF04884C)),
        ),
        backgroundColor: const Color(0xFF04884C),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al extraer datos: $error',style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    backgroundColor: Color(0xFF04884C) 
        )),
        duration:const Duration(seconds: 10),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas por Período'),
      ),
      body: Center(
        child: SingleChildScrollView(
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
              Text(
                  'Fecha Inicial: ${DateFormat('dd/MM/yyyy').format(_startDate)}'),
              ElevatedButton(
                onPressed: () => _selectStartDate(context),
                child: const Text('Seleccione'),
              ),
              const SizedBox(height: 20.0),
              Text('Fecha Final: ${DateFormat('dd/MM/yyyy').format(_endDate)}'),
              ElevatedButton(
                onPressed: () => _selectEndDate(context),
                child: const Text('Seleccione'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _fetchAndSumTotal,
                child: const Text('Calcular'),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
