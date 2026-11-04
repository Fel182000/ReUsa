import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'detalle_producto_screen.dart';
import 'favoritos_provider.dart';
import 'producto_card.dart';
import 'producto_model.dart';

/// Pantalla principal: catalogo con busqueda por nombre y filtro por categoria.
class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  String _busqueda = '';
  String _categoria = 'Todas';

  List<Producto> get _productosFiltrados {
    return listaProductos
        .where(
          (p) => p.nombre.toLowerCase().contains(
            _busqueda.toLowerCase().trim(),
          ),
        )
        .where((p) => _categoria == 'Todas' || p.categoria == _categoria)
        .toList();
  }

  Widget _chipCategoria(String texto) {
    final seleccionado = _categoria == texto;
    return ChoiceChip(
      label: Text(texto),
      selected: seleccionado,
      showCheckmark: false,
      selectedColor: AppColors.primario,
      backgroundColor: Colors.white,
      side: const BorderSide(color: AppColors.primarioClaro),
      labelStyle: TextStyle(
        color: seleccionado ? Colors.white : AppColors.textoPrincipal,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _categoria = texto),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productos = _productosFiltrados;
    final favoritos = context.watch<FavoritosProvider>().cantidad;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ReUsa Tolcayuca',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '❤ $favoritos',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de busqueda
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (valor) => setState(() => _busqueda = valor),
              decoration: const InputDecoration(
                hintText: 'Buscar artículo...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Filtros de categoria (scroll horizontal)
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categorias.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) => _chipCategoria(categorias[index]),
            ),
          ),
          // Resultados
          Expanded(
            child: productos.isEmpty
                ? const Center(child: Text('No se encontraron artículos'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return ProductoCard(
                        producto: producto,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalleProductoScreen(producto: producto),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
