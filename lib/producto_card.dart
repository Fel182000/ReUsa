import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'producto_model.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTap;

  const ProductoCard({super.key, required this.producto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const radio = BorderRadius.all(Radius.circular(20));
    final esFavorito = context.watch<FavoritosProvider>().esFavorito(
      producto.id,
    );

    return Material(
      color: AppColors.tarjeta,
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: const RoundedRectangleBorder(borderRadius: radio),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _foto(),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => context
                          .read<FavoritosProvider>()
                          .alternar(producto.id),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          esFavorito ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: esFavorito
                              ? Colors.red
                              : AppColors.textoSecundario,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    producto.nombre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    producto.estado,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textoSecundario,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    producto.precioTexto,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.acento,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _foto() {
    return Image.asset(
      producto.rutaImagen,
      fit: BoxFit.cover,
      excludeFromSemantics: true,
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: AppColors.primarioClaro,
        child: Center(
          child: Icon(
            iconoDeCategoria(producto.categoria),
            size: 48,
            color: AppColors.primario,
          ),
        ),
      ),
    );
  }
}
