import 'package:app_uniemp/menu_pages/purchase/submenu_view_purchases.dart';
import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/purchase/create_purchase.dart';
import 'package:app_uniemp/menu_pages/purchase/null_purchase.dart';
import 'package:app_uniemp/menu_pages/purchase/edit_purchase.dart';

class compra extends StatelessWidget {
   compra({super.key});
  Widget _title() {
    return const Text('COMPRA');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  Widget _crearCompra() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const crearCompra(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.create_new_folder, size: 24),
        label: const Text('Crear'),
      ),
    );
  }

  Widget _editarCompra() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const editarCompra(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.edit, size: 24),
        label: const Text('Editar'),
      ),
    );
  }

  Widget _anularCompra() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const anularCompra(),
               settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.cancel_outlined, size: 24),
        label: const Text('Anular'),
      ),
    );
  }

  Widget _verCompra() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  subemenuVerCompras(),
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
            _image(),const SizedBox(
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
                  child: _crearCompra(),
                ),
                SizedBox(width: 125, height: 100, child: _editarCompra()),
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
                  child: _anularCompra(),
                ),
                SizedBox(width: 125, height: 100, child: _verCompra()),
              ],
            ),
          ],
        ),
      ),),
    );
  }
}
