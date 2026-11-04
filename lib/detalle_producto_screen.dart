import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'producto_model.dart';

/// Pantalla de detalle de un articulo: imagen, datos y boton de favoritos.
class DetalleProductoScreen extends StatelessWidget {
  final Producto producto;

  const DetalleProductoScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final esFavorito = context.watch<FavoritosProvider>().esFavorito(
      producto.id,
    );

    return Scaffold(
      appBar: AppBar(title: Text(producto.nombre)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    producto.rutaImagen,
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      width: 220,
                      height: 220,
                      child: ColoredBox(
                        color: AppColors.primarioClaro,
                        child: Center(
                          child: Icon(
                            iconoDeCategoria(producto.categoria),
                            size: 72,
                            color: AppColors.primario,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                producto.nombre,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                producto.precioTexto,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.acento,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.sm,
                children: [
                  Chip(label: Text(producto.categoria)),
                  Chip(label: Text(producto.estado)),
                  Chip(
                    avatar: const Icon(Icons.place_outlined, size: 18),
                    label: Text(producto.zona),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                producto.descripcion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<FavoritosProvider>().alternar(producto.id);
                  _aviso(
                    context,
                    esFavorito
                        ? '${producto.nombre} quitado de favoritos'
                        : '${producto.nombre} guardado en favoritos',
                  );
                },
                icon: Icon(esFavorito ? Icons.favorite : Icons.favorite_border),
                label: Text(esFavorito ? 'En favoritos' : 'Guardar en favoritos'),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al catálogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _aviso(BuildContext context, String mensaje) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
