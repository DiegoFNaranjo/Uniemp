
import 'package:app_uniemp/menu_pages/quotes/create_quote.dart';
import 'package:app_uniemp/menu_pages/quotes/submenu_view_quotes.dart';
import 'package:flutter/material.dart';
import 'edit_quotes.dart';


Widget _title() {
  return const Text('COTIZACIONES');
}

Widget _image() {
  return const Image(image: AssetImage('imagenes/Uniemp.png'));
}

Widget _crearCotizacion() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const crearCotizacion(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.create_new_folder, size: 24),
      label: const Text('Crear'),
    ),
  );
}

Widget _editarCotizacion() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const editarCotizacion(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.edit, size: 24),
      label: const Text('Editar'),
    ),
  );
}

Widget _verCotizacion() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => subemenuVerCotizaciones(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.list, size: 24),
      label: const Text('Ver'),
    ),
  );
}

class menuCotizaciones extends StatefulWidget {
  const menuCotizaciones ({super.key});

  
  @override
  State<menuCotizaciones> createState() => _menuCotizacionesState();
}

String? rucnegocio;

class _menuCotizacionesState extends State<menuCotizaciones> {
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
                  child: _crearCotizacion(),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 125, height: 100, child: _editarCotizacion()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 125, height: 100, child: _verCotizacion()),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
