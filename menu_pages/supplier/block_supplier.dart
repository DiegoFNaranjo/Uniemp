import 'package:app_uniemp/menu_pages/supplier/manage_supplier.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bloquearProveedor extends StatefulWidget {
  const bloquearProveedor({super.key});

  @override
  _bloquearProveedorState createState() => _bloquearProveedorState();
}

class _bloquearProveedorState extends State<bloquearProveedor> {
  final TextEditingController rucProveedorController = TextEditingController();
  String? ruc;
  Map<String, dynamic> clienteData = {};

  Future<void> buscarCliente() async {
    try {
      String collectionNameProveedor = '${ruc!}PROVEEDOR';
      final String rucProveedor = rucProveedorController.text;
      const String Bloquear = 'Bloquear';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionNameProveedor)
          .doc(rucProveedor.toString())
          .get();
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (documentSnapshot.exists && data?[Bloquear] == 'no') {
        await FirebaseFirestore.instance
            .collection(collectionNameProveedor)
            .doc(rucProveedor.toString())
            .update({
          'Bloquear': 'si',
        });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => proveedor(),
                settings: RouteSettings(arguments: ruc)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El Proveedor ha sido bloqueado',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    backgroundColor: Color(0xFF04884C))),
          ),
        );
        rucProveedorController.clear();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Proveedor no existe o está bloqueado'),
              content: const Text(
                  'El número de Proveedor no existe o ya fue bloqueado'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
        rucProveedorController.clear();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Un error se ha presentado: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      rucProveedorController.clear();
    }
  }

  @override
  void dispose() {
    rucProveedorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ruc = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloquear Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              TextField(
                controller: rucProveedorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText:
                        'ingrese el número de RUC del proveedor a bloquear '),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: buscarCliente,
                child: const Text('BLOQUEAR PROVEEDOR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// import 'package:app_uniemp/menu_pages/supplier/edit_supplier.dart';
// import 'package:flutter/material.dart';

// class bloquearProveedor extends StatelessWidget {
//   const bloquearProveedor ({super.key});
//  Widget _title() {
//     return const Text('BLOQUEAR PROVEEDOR');
//   }

//   Widget _image() {
//     return const Image(image: AssetImage('imagenes/Uniemp.png'));
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(
//           title: _title(),
//         ),
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _image(),
//               const SizedBox(height: 30,),
//               const Text('Para bloquear debe realizarlo en la opción de editar, de lo contrario regrese con la flecha en la parte superior', style: TextStyle(fontSize: 25),),
//               const SizedBox(height: 30,),
//               ElevatedButton(onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const editarProveedor(),
//             ),
//           );
//         }, child: const Text('Ir a Editar'))],),),);
//   }
// }