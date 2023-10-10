import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/customer/create_customer.dart';
import 'package:app_uniemp/menu_pages/customer/edit_customer.dart';
import 'package:app_uniemp/menu_pages/customer/block_customer.dart';
import 'package:app_uniemp/menu_pages/customer/view_customer.dart';



class clientes extends StatelessWidget {
   clientes({super.key});
  Widget _title() {
    return const Text('CLIENTE');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  Widget _crearCliente() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const crearCliente(),
                settings: RouteSettings(arguments: rucnegocio)),
          );
        },
        icon: const Icon(Icons.create_new_folder, size: 24),
        label: const Text('Crear'),
      ),
    );
  }

  Widget _editarCliente() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const editarCliente(),
              settings: RouteSettings(arguments: rucnegocio)),
             );
        },
        icon: const Icon(Icons.edit, size: 24),
        label: const Text('Editar'),
      ),
    );
  }

  Widget _bloquearCliente() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const bloquearCliente(),
              settings: RouteSettings(arguments: rucnegocio)
            ),
          );
        },
        icon: const Icon(Icons.block, size: 24),
        label: const Text('Bloquear'),
      ),
    );
  }

  Widget _verCliente() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const verCliente(),
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
                    child: _crearCliente(),
                  ),
                  SizedBox(width: 125, height: 100, child: _editarCliente()),
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
                    child: _bloquearCliente(),
                  ),
                  SizedBox(width: 125, height: 100, child: _verCliente()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
