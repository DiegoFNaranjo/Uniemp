import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/sale/create_credit_note.dart';
import 'package:app_uniemp/menu_pages/sale/create_invoice.dart';
import 'package:app_uniemp/menu_pages/sale/submenu_view_credit_notes.dart';
import 'package:app_uniemp/menu_pages/sale/submenu_view_invoices.dart';

class venta extends StatelessWidget {
   venta({super.key});
  Widget _title() {
    return const Text('VENTA');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  Widget _crearFactura() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const crearFactura(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.create_new_folder, size: 24),
        label: const Text('Crear'),
      ),
    );
  }

  Widget _verFactura() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  subemenuVerFacturas(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.list, size: 24),
        label: const Text('Ver/Listar'),
      ),
    );
  }

  Widget _crearNotaCredito() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const crearNotaCredito(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.create_new_folder, size: 24),
        label: const Text('Crear'),
      ),
    );
  }

  Widget _verNotaCredito() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => submenuVerNotasCredito(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.list, size: 24),
        label: const Text('Ver/Listar'),
      ),
    );
  }
String? rucnegocio;
  @override
  Widget build(BuildContext context) {
     rucnegocio = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image(),
            const SizedBox(
                height: 15,
              ),
              Text(
                'RUC: $rucnegocio',
                style: const TextStyle(
                    fontSize: 18, color: Colors.white, backgroundColor: Color(0xFF04884C)),
              ),
            const SizedBox(
              height: 30,
            ),
            const Text('FACTURA',
                style: TextStyle(
                  color: Color(0xFF04884C),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _crearFactura(),
                ),
                SizedBox(width: 125, height: 100, child: _verFactura()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'NOTA DE CREDITO',
              style: TextStyle(
                color: Color(0xFF04884C),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _crearNotaCredito(),
                ),
                SizedBox(width: 125, height: 100, child: _verNotaCredito()),
              ],
            ),
          ],
        ),),
      ),
    );
  }
}
