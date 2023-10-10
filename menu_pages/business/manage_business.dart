import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/business/create_business.dart';
import 'package:app_uniemp/menu_pages/business/view_business.dart';
import 'edit_business.dart';

Widget _title() {
  return const Text('NEGOCIO');
}

Widget _image() {
  return const Image(image: AssetImage('imagenes/Uniemp.png'));
}

Widget _crearNegocio() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const crearNegocio(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.create_new_folder, size: 24),
      label: const Text('Crear'),
    ),
  );
}

Widget _editarNegocio() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const editarNegocio(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.edit, size: 24),
      label: const Text('Editar'),
    ),
  );
}

Widget _verNegocio() {
  return Builder(
    builder: (context) => ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const verNegocio(),
              settings: RouteSettings(arguments: rucnegocio)),
        );
      },
      icon: const Icon(Icons.edit, size: 24),
      label: const Text('Ver'),
    ),
  );
}

class menuNegocio extends StatefulWidget {
  const menuNegocio({
    Key? key,
    required this.razonSocial,
    required this.ruc,
    required this.telefono,
    required this.direccion,
    required this.ciudad,
    required this.provincia,
    required this.pais,
    required this.codigoPostal,
    required this.email,
  }) : super(key: key);

  final String razonSocial;
  final String ruc;
  final String telefono;
  final String direccion;
  final String ciudad;
  final String provincia;
  final String pais;
  final String codigoPostal;
  final String email;

  @override
  State<menuNegocio> createState() => _menuNegocioState();
}

String? rucnegocio;

class _menuNegocioState extends State<menuNegocio> {
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
              'RUC: $ruc',
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  backgroundColor: Color(0xFF04884C)),
            ),
            const SizedBox(
              height: 30,
            ),
            _crearNegocio(),
            const SizedBox(
              height: 30,
            ),
            _editarNegocio(),
            const SizedBox(
              height: 30,
            ),
            _verNegocio()
          ],
        )),
      ),
    );
  }
}
