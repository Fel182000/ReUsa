import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'producto_card.dart';
import 'producto_model.dart';
import 'producto_repository.dart';

/// Pantalla principal: catalogo con busqueda por nombre y filtro por categoria.
class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final ProductoRepository _repo = ProductoRepository();
  String _busqueda = '';
  String _categoria = 'Todas';

  List<Producto> get _productosFiltrados {
    return _repo
        .obtenerProductos()
        .where(
          (p) =>
              p.nombre.toLowerCase().contains(_busqueda.toLowerCase().trim()),
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

  // Abre el formulario y, al volver, refresca la lista para ver el nuevo
  Future<void> _abrirFormulario() async {
    await Navigator.pushNamed(context, '/nuevo');
    if (!mounted) return;
    setState(() {});
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
          IconButton(
            tooltip: 'Consejos',
            icon: const Icon(Icons.eco_outlined),
            onPressed: () => Navigator.pushNamed(context, '/consejos'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Badge(
              isLabelVisible: favoritos > 0,
              label: Text('$favoritos'),
              child: IconButton(
                tooltip: 'Favoritos',
                icon: const Icon(Icons.favorite_border),
                onPressed: () => Navigator.pushNamed(context, '/favoritos'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormulario,
        backgroundColor: AppColors.acento,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Publicar'),
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
              itemBuilder: (context, index) =>
                  _chipCategoria(categorias[index]),
            ),
          ),
          // Resultados
          Expanded(
            child: productos.isEmpty
                ? const Center(child: Text('No se encontraron artículos'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
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
                          // Se manda el producto como argumento de la ruta
                          Navigator.pushNamed(
                            context,
                            '/detalle',
                            arguments: producto,
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