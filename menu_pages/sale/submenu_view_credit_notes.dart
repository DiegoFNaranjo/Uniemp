import 'package:app_uniemp/menu_pages/sale/viewAll_credit_notes.dart';
import 'package:app_uniemp/menu_pages/sale/viewSingleCreditNote.dart';

import 'package:flutter/material.dart';

class submenuVerNotasCredito extends StatelessWidget {
  late final VoidCallback? onPressedCallback;

  submenuVerNotasCredito ({super.key, this.onPressedCallback});
  Widget _verNotasCredito() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const verNotasCredito(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER TODAS'),
      ),
    );
  }

  Widget _printNotaCredito() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const printNotaCredito(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER UNA NOTA DE CRÉDITO'),
      ),
    );
  }

  String? ruc;

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VER NOTAS DE CRÉDITO'),
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
              _verNotasCredito(),
              const SizedBox(
                height: 30,
              ),
              _printNotaCredito()
            ],
          ),
        ),
      ),
    );
  }
}
