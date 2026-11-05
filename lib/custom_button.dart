import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback? onPressed;
  final bool secundario;

  const CustomButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icono,
    this.secundario = false,
  });

  @override
  Widget build(BuildContext context) {
    final etiqueta = Text(texto);

    if (secundario) {
      return icono == null
          ? OutlinedButton(onPressed: onPressed, child: etiqueta)
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icono),
              label: etiqueta,
            );
    }

    return icono == null
        ? ElevatedButton(onPressed: onPressed, child: etiqueta)
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icono),
            label: etiqueta,
          );
  }
}