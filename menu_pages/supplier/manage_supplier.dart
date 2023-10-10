import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/supplier/create_supplier.dart';
import 'package:app_uniemp/menu_pages/supplier/edit_supplier.dart';
import 'package:app_uniemp/menu_pages/supplier/block_supplier.dart';
import 'package:app_uniemp/menu_pages/supplier/view_supplier.dart';

class proveedor extends StatelessWidget {
  proveedor({super.key});
  Widget _title() {
    return const Text('PROVEEDOR');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  Widget _crearProveedor() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const crearProveedor(),
                settings: RouteSettings(arguments: rucnegocio)),
          );
        },
        icon: const Icon(Icons.create_new_folder, size: 24),
        label: const Text('Crear'),
      ),
    );
  }

  Widget _editarProveedor() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const editarProveedor(),
                settings: RouteSettings(arguments: rucnegocio)),
          );
        },
        icon: const Icon(Icons.edit, size: 24),
        label: const Text('Editar'),
      ),
    );
  }

  Widget _bloquearProveedor() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const bloquearProveedor(),
                settings: RouteSettings(arguments: rucnegocio)),
          );
        },
        icon: const Icon(Icons.block, size: 24),
        label: const Text('Bloquear'),
      ),
    );
  }

  Widget _verProveedor() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const verProveedor(),
                settings: RouteSettings(arguments: rucnegocio)),
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
        child: SingleChildScrollView(
          child: Column(
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
                    child: _crearProveedor(),
                  ),
                  SizedBox(width: 125, height: 100, child: _editarProveedor()),
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
                    child: _bloquearProveedor(),
                  ),
                  SizedBox(width: 125, height: 100, child: _verProveedor()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
