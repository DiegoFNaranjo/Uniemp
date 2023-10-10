import 'package:app_uniemp/menu_pages/sale/viewAllInvoices.dart';
import 'package:app_uniemp/menu_pages/sale/viewSingleInvoice.dart';
import 'package:flutter/material.dart';

class subemenuVerFacturas extends StatelessWidget {
  late final VoidCallback? onPressedCallback;

  subemenuVerFacturas({super.key, this.onPressedCallback});
  Widget _verFacturas() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const verFacturas(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER TODAS'),
      ),
    );
  }

  Widget _printFactura() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const printFactura(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER UNA FACTURA'),
      ),
    );
  }

  String? ruc;

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VER FACTURAS'),
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
              _verFacturas(),
              const SizedBox(
                height: 30,
              ),
              _printFactura()
            ],
          ),
        ),
      ),
    );
  }
}
