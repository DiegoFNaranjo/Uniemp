import 'package:app_uniemp/menu_pages/purchase/view_all_purchase.dart';
import 'package:app_uniemp/menu_pages/purchase/view_one_purchase.dart';
import 'package:flutter/material.dart';

class subemenuVerCompras extends StatelessWidget {
  late final VoidCallback? onPressedCallback;

  subemenuVerCompras({super.key, this.onPressedCallback});
  Widget _verCompras() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const verCompras(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER TODAS'),
      ),
    );
  }

  Widget _printCompra() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const printCompra(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER UNA ORDEN DE COMPRA'),
      ),
    );
  }

  String? ruc;

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VER ÓRDENES DE COMPRA'),
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
              _verCompras(),
              const SizedBox(
                height: 30,
              ),
              _printCompra()
            ],
          ),
        ),
      ),
    );
  }
}
