import 'package:app_uniemp/menu_pages/product/list_product.dart';
import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/product/create_product.dart';
import 'package:app_uniemp/menu_pages/product/delete_product.dart';
import 'package:app_uniemp/menu_pages/product/edit_product.dart';

Widget _title() {
  return const Text('PRODUCTO');
}

Widget _image() {
  return const Image(image: AssetImage('imagenes/Uniemp.png'));
}

Widget _crearProducto() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const crearProducto(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.create_new_folder, size: 24),
      label: const Text('Crear'),
    ),
  );
}

Widget _editarProducto() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const editarProducto(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.edit, size: 24),
      label: const Text('Editar'),
    ),
  );
}

Widget _verProducto() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const verProducto(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.list, size: 24),
      label: const Text('Ver'),
    ),
  );
}

Widget _borrarProducto() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const borrarProducto(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.delete, size: 24),
      label: const Text('Borrar'),
    ),
  );
}

class menuProducto extends StatefulWidget {
  const menuProducto({
    Key? key,
    required this.codigo,
    required this.producto,
    required this.cantidad,
    required this.precioCompra,
    required this.precioVenta,
  }) : super(key: key);

  final String codigo;
  final String producto;
  final String cantidad;
  final String precioCompra;
  final String precioVenta;

  @override
  State<menuProducto> createState() => _menuProductoState();
}

String? rucnegocio;

class _menuProductoState extends State<menuProducto> {
  @override
  Widget build(BuildContext context) {
    rucnegocio = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            _image(),
            const SizedBox(
              height: 15,
            ),
            Text(
              'RUC: $rucnegocio',
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  backgroundColor: Color(0xFF04884C)),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _crearProducto(),
                ),
                SizedBox(width: 125, height: 100, child: _editarProducto()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _borrarProducto(),
                ),
                SizedBox(width: 125, height: 100, child: _verProducto()),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
