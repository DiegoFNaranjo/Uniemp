import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class crearProducto extends StatefulWidget {
  const crearProducto({super.key});

  @override
  _crearProductoState createState() => _crearProductoState();
}

class _crearProductoState extends State<crearProducto> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _productoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioCompraController = TextEditingController();
  final TextEditingController _precioVentaController = TextEditingController();
  String? ruc;

  void _crearProducto() async {
    String codigo = _codigoController.text;
    String producto = _productoController.text;
    int cantidad = int.parse(_cantidadController.text);
    double precioCompra = double.parse(_precioCompraController.text);
    double precioVenta = double.parse(_precioVentaController.text);

    if (_codigoController.text.isEmpty ||
        _productoController.text.isEmpty ||
        _cantidadController.text.isEmpty ||
        _precioCompraController.text.isEmpty ||
        _precioVentaController.text.isEmpty) {
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
      String collectionName = '${ruc!}PRODUCTO';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(codigo)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Advertencia'),
                  content: const Text('Ya existe un producto registrado'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'))
                  ],
                ));
      } else {
        try {
          await _firestore.collection(collectionName).doc(codigo).set({
            'código': codigo,
            'producto': producto,
            'cantidad': cantidad.toString(),
            'precio compra': precioCompra.toStringAsFixed(2),
            'precio venta': precioVenta.toStringAsFixed(2),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Producto ingresado correctamente'),
            ),
          );

          _codigoController.clear();
          _productoController.clear();
          _cantidadController.clear();
          _precioCompraController.clear();
          _precioVentaController.clear();
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Ocurrió un error: ${e.toString()}'),
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
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _productoController.dispose();
    _cantidadController.dispose();
    _precioCompraController.dispose();
    _precioVentaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREAR PRODUCTO'),
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
              height: 30,
            ),
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(labelText: 'Código'),
            ),
            TextField(
              controller: _productoController,
              decoration: const InputDecoration(labelText: 'Producto'),
            ),
            TextField(
              controller: _cantidadController,
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _precioCompraController,
              decoration: const InputDecoration(labelText: 'Precio Compra'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _precioVentaController,
              decoration: const InputDecoration(labelText: 'Precio Venta'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: _crearProducto, child: const Text('Crear Producto'))
          ],
        )),
      ),
    );
  }
}
