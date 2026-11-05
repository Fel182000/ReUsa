import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reusa/custom_button.dart';
import 'package:reusa/favoritos_provider.dart';

void main() {
  test('FavoritosProvider agrega y quita favoritos', () {
    final provider = FavoritosProvider();
    expect(provider.cantidad, 0);

    provider.alternar(1);
    expect(provider.esFavorito(1), true);
    expect(provider.cantidad, 1);

    provider.alternar(1);
    expect(provider.esFavorito(1), false);
    expect(provider.cantidad, 0);
  });

  testWidgets('CustomButton responde al toque', (tester) async {
    var toques = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            texto: 'Guardar',
            icono: Icons.favorite,
            onPressed: () => toques++,
          ),
        ),
      ),
    );

    expect(find.text('Guardar'), findsOneWidget);

    await tester.tap(find.text('Guardar'));
    expect(toques, 1);
  });
}