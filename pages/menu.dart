import 'package:app_uniemp/menu_pages/business/manage_business.dart';
import 'package:app_uniemp/menu_pages/customer/manage_customer.dart';
import 'package:flutter/material.dart';
import 'package:app_uniemp/menu_pages/product/manage_product.dart';
import 'package:app_uniemp/menu_pages/sale/menu_sale.dart';
import 'package:app_uniemp/menu_pages/purchase/menu_purchase.dart';
import 'package:app_uniemp/menu_pages/supplier/manage_supplier.dart';
import 'package:app_uniemp/menu_pages/results/results.dart';

import '../menu_pages/quotes/menu_quotes.dart';

class menu_principal extends StatelessWidget {
  menu_principal({super.key});

  Widget _title() {
    return const Text('MENU');
  }

  Widget _image() {
    return const Image(image: AssetImage('imagenes/Uniemp.png'));
  }

  Widget _clientes() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => clientes(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.people, size: 24),
        label: const Text('Cliente'),
      ),
    );
  }

  Widget _productos() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const menuProducto(
                cantidad: '',
                codigo: '',
                precioCompra: '',
                precioVenta: '',
                producto: '',
              ),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.inventory, size: 24),
        label: const Text('Producto'),
      ),
    );
  }

  Widget _ventas() {
    const IconData point_of_sale =
        IconData(0xe4d8, fontFamily: 'MaterialIcons');
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => venta(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.point_of_sale, size: 24),
        label: const Text('Venta'),
      ),
    );
  }

  Widget _compra() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => compra(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.money, size: 24),
        label: const Text('Compra'),
      ),
    );
  }

  Widget _proveedor() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => proveedor(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.store, size: 24),
        label: const Text('Proveedor'),
      ),
    );
  }

  Widget _resultado() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => resultado(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.money_off, size: 24),
        label: const Text('Resultado'),
      ),
    );
  }

  Widget _cotizaciones() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const menuCotizaciones(),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.currency_bitcoin_outlined, size: 24),
        label: const Text('Cotizaciones'),
      ),
    );
  }

  Widget _NegocioDatos() {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const menuNegocio(
                  ciudad: '',
                  codigoPostal: '',
                  pais: '',
                  telefono: '',
                  direccion: '',
                  provincia: '',
                  razonSocial: '',
                  ruc: '',
                  email: ''),
              settings: RouteSettings(arguments: rucnegocio),
            ),
          );
        },
        icon: const Icon(Icons.business, size: 24),
        label: const Text('Negocio'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
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
                    child: _clientes(),
                  ),
                  SizedBox(width: 125, height: 100, child: _productos()),
                  SizedBox(width: 125, height: 100, child: _ventas())
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
                    child: _compra(),
                  ),
                  SizedBox(width: 125, height: 100, child: _proveedor()),
                  SizedBox(width: 125, height: 100, child: _resultado())
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(width: 175, height: 65, child: _cotizaciones())
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 175, height: 65, child: _NegocioDatos())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
