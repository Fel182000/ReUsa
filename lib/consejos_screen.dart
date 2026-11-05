import 'package:flutter/material.dart';

import 'core_theme.dart';

class _Consejo {
  final IconData icono;
  final String titulo;
  final String texto;

  const _Consejo(this.icono, this.titulo, this.texto);
}

const List<_Consejo> _reutilizar = [
  _Consejo(
    Icons.checkroom,
    'Dale otra vida a la ropa',
    'Ropa que ya no usas puede regalarse, intercambiarse o convertirse en trapos, bolsas o fundas.',
  ),
  _Consejo(
    Icons.chair_alt,
    'Restaura muebles',
    'Una lijada y una capa de barniz o pintura pueden dejar una silla o mesa como nueva.',
  ),
  _Consejo(
    Icons.local_florist_outlined,
    'Frascos y latas como macetas',
    'Envases de vidrio o lata, bien lavados, sirven para plantas, lápices o especias.',
  ),
  _Consejo(
    Icons.shopping_bag_outlined,
    'Lleva tu propia bolsa',
    'Reutilizar bolsas de tela o de plástico resistente reduce mucho los residuos.',
  ),
];

const List<_Consejo> _reciclar = [
  _Consejo(
    Icons.delete_outline,
    'Separa tus residuos',
    'Divide en orgánicos, reciclables (papel, cartón, vidrio, metal, plástico) y no reciclables.',
  ),
  _Consejo(
    Icons.water_drop_outlined,
    'Enjuaga los envases',
    'Los envases limpios y secos se pueden reciclar; los sucios contaminan el resto.',
  ),
  _Consejo(
    Icons.menu_book_outlined,
    'Papel y cartón secos',
    'Guárdalos sin grasa ni humedad. Aplana las cajas para que ocupen menos espacio.',
  ),
  _Consejo(
    Icons.battery_alert_outlined,
    'Pilas y electrónicos aparte',
    'No los tires a la basura común: llévalos a un centro de acopio.',
  ),
];

/// Pantalla estatica con consejos para reutilizar y reciclar.
class ConsejosScreen extends StatelessWidget {
  const ConsejosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reutiliza y recicla')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _encabezado(context, '♻ Reutiliza'),
          ..._reutilizar.map(_tarjeta),
          const SizedBox(height: AppSpacing.md),
          _encabezado(context, '🌎 Recicla'),
          ..._reciclar.map(_tarjeta),
        ],
      ),
    );
  }

  Widget _encabezado(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(texto, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  Widget _tarjeta(_Consejo c) {
    return Card(
      color: AppColors.tarjeta,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: CircleAvatar(
          backgroundColor: AppColors.primarioClaro,
          child: Icon(c.icono, color: AppColors.primario),
        ),
        title: Text(
          c.titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textoPrincipal,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: Text(c.texto),
        ),
      ),
    );
  }
}