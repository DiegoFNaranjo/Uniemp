
import 'package:app_uniemp/menu_pages/quotes/viewAllquotes.dart';
import 'package:app_uniemp/menu_pages/quotes/viewOneQuote.dart';
import 'package:flutter/material.dart';

class subemenuVerCotizaciones extends StatelessWidget {
  late final VoidCallback? onPressedCallback;

  subemenuVerCotizaciones({super.key, this.onPressedCallback});
  Widget _verCotizaciones() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const verCotizaciones(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER TODAS'),
      ),
    );
  }

  Widget _printCotizacion() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const printCotizacion(),
              settings: RouteSettings(arguments: ruc),
            ),
          );
        },
        icon: const Icon(Icons.list_rounded, size: 24),
        label: const Text('VER UNA COTIZACIÓN'),
      ),
    );
  }

  String? ruc;

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VER COTIZACIONES'),
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
              _verCotizaciones(),
              const SizedBox(
                height: 30,
              ),
              _printCotizacion()
            ],
          ),
        ),
      ),
    );
  }
}
