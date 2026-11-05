import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'custom_button.dart';
import 'favoritos_provider.dart';
import 'producto_model.dart';
import 'producto_repository.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>();
    final productos = ProductoRepository()
        .obtenerProductos()
        .where((p) => favoritos.esFavorito(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Mis favoritos')),
      body: productos.isEmpty
          ? _vacio(context)
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: productos.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) =>
                  _item(context, productos[index]),
            ),
    );
  }

  Widget _item(BuildContext context, Producto producto) {
    return Card(
      color: AppColors.tarjeta,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.sm),
        onTap: () =>
            Navigator.pushNamed(context, '/detalle', arguments: producto),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 56,
            height: 56,
            child: Image.asset(
              producto.rutaImagen,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => ColoredBox(
                color: AppColors.primarioClaro,
                child: Icon(
                  iconoDeCategoria(producto.categoria),
                  color: AppColors.primario,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          producto.nombre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${producto.estado} · ${producto.zona}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              producto.precioTexto,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.acento,
              ),
            ),
            IconButton(
              tooltip: 'Quitar de favoritos',
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () =>
                  context.read<FavoritosProvider>().alternar(producto.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vacio(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 72,
              color: AppColors.primarioClaro,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Aún no tienes favoritos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Toca el corazón de un artículo para guardarlo aquí.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomButton(
              texto: 'Ver catálogo',
              icono: Icons.storefront_outlined,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}