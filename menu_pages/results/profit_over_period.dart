import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class utilidadPeriodo extends StatefulWidget {
  const utilidadPeriodo({super.key});

  @override
  _utilidadPeriodoState createState() => _utilidadPeriodoState();
}

class _utilidadPeriodoState extends State<utilidadPeriodo> {
  double ventasTotales = 0.0;
  double comprasTotales = 0.0;
  double notasDeCredito = 0.0;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String? ruc;

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

  Future<void> calcular() async {
    try {
      String collectionName = '${ruc!}FACTURA';
      CollectionReference ventasCollection =
          FirebaseFirestore.instance.collection(collectionName);
      String formattedStartDate = DateFormat('dd/MM/yyyy').format(_startDate);
      String formattedEndDate = DateFormat('dd/MM/yyyy').format(_endDate);

      QuerySnapshot querySnapshot = await ventasCollection
          .where('Fecha', isGreaterThanOrEqualTo: formattedStartDate)
          .where('Fecha', isLessThanOrEqualTo: formattedEndDate)
          .get();

      if (querySnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No existen datos en el rango seleccionado'),
        ));
        return;
      }

      double sumaFacturas = 0.0;

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        var valorTotal = document.data() as Map<String, dynamic>?;

        if (valorTotal != null) {
          var total = double.parse(valorTotal['subtotal']);

          double totalValue = total.toDouble();
          sumaFacturas += totalValue;
        }
      }
      setState(() {
        ventasTotales = sumaFacturas;
      });
    } catch (e) {
      print('Error:$e');

      setState(() {
        ventasTotales = 0.0;
      });
    }
    try {
      String collectionNameCompra = '${ruc!}ORDEN DE COMPRA';
      final CollectionReference comprasCollection =
          FirebaseFirestore.instance.collection(collectionNameCompra);

      String formattedStartDate = DateFormat('dd/MM/yyyy').format(_startDate);
      String formattedEndDate = DateFormat('dd/MM/yyyy').format(_endDate);

      QuerySnapshot querySnapshot = await comprasCollection
          .where('Fecha', isGreaterThanOrEqualTo: formattedStartDate)
          .where('Fecha', isLessThanOrEqualTo: formattedEndDate)
          .get();

      if (querySnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No existen datos en el rango seleccionado'),
        ));
        return;
      }

      double sumaCompras = 0.0;

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        var totalField = document.data() as Map<String, dynamic>?;

        if (totalField != null) {
          var total = double.parse(totalField['subtotal']);

          double totalValue = total.toDouble();
          sumaCompras += totalValue;
        }
      }
      setState(() {
        comprasTotales = sumaCompras;
      });
    } catch (e) {
      print('Error:$e');

      setState(() {
        comprasTotales = 0.0;
      });
    }
    try {
      String collectionNameNotaCredito = '${ruc!}NOTA DE CREDITO';
      final CollectionReference notaCreditoCollection =
          FirebaseFirestore.instance.collection(collectionNameNotaCredito);

      String formattedStartDate = DateFormat('dd/MM/yyyy').format(_startDate);
      String formattedEndDate = DateFormat('dd/MM/yyyy').format(_endDate);

      QuerySnapshot querySnapshot = await notaCreditoCollection
          .where('Fecha', isGreaterThanOrEqualTo: formattedStartDate)
          .where('Fecha', isLessThanOrEqualTo: formattedEndDate)
          .get();

      if (querySnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No existen datos en el rango seleccionado'),
        ));
        return;
      }

      double sumaNC = 0.0;

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        var totalField = document.data() as Map<String, dynamic>?;

        if (totalField != null) {
          var total = double.parse(totalField['subtotal']);

          double totalValue = total.toDouble();
          sumaNC += totalValue;
        }
      }

      setState(() {
        notasDeCredito = sumaNC;
      });
    } catch (e) {
      print('Error:$e');

      setState(() {
        ventasTotales = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTILIDAD ANTES DE IMPUESTOS'),
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
                    fontSize: 18, color: Colors.white, backgroundColor: Color(0xFF04884C)),
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
              Text(
                'Total Facturas (antes de IVA): \$${(ventasTotales).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Total Compras (antes de IVA): \$${(comprasTotales).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Total Notas de Crédito (antes de IVA): \$${(notasDeCredito).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Utilidad antes de impuestos: \$${(ventasTotales - comprasTotales - notasDeCredito).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: calcular,
                child: const Text('Calcular'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
