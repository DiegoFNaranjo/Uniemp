import 'package:app_uniemp/menu_pages/results/profit_over_period.dart';
import 'package:app_uniemp/menu_pages/results/purchase_over_period.dart';
import 'package:app_uniemp/menu_pages/results/sales_over_period.dart';
import 'package:flutter/material.dart';

class resultado extends StatelessWidget {
   resultado ({super.key});
 Widget _title() {
    return const Text('RESULTADOS');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }
  Widget _ventasPeriodo() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const ventasPeriodo(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.point_of_sale_rounded, size: 24),
        label: const Text('ventas/período'),
      ),
    );
  }
   Widget _comprasPeriodo() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const comprasPeriodo(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.money, size: 24),
        label: const Text('compras/período'),
      ),
    );
  }

  Widget _utilidadPeriodo() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const utilidadPeriodo(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.money_off_outlined, size: 24),
        label: const Text('Utilidad/período'),
      ),
    );
  }

  String? rucnegocio;
  @override
  Widget build(BuildContext context) {
rucnegocio = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(appBar: AppBar(
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
                    fontSize: 18,
                    color: Colors.white,
                    backgroundColor: Color(0xFF04884C)),
              ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _ventasPeriodo(),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _comprasPeriodo(),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 125,
                  height: 100,
                  child: _utilidadPeriodo(),
                ),
              ],
            ),
          ],
        ),),
      ),
    );
  }
}
