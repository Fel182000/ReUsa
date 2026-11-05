import 'package:flutter/material.dart';

import 'core_theme.dart';
import 'producto_model.dart';
import 'producto_repository.dart';

class FormularioProductoScreen extends StatefulWidget {
  const FormularioProductoScreen({super.key});

  @override
  State<FormularioProductoScreen> createState() =>
      _FormularioProductoScreenState();
}

class _FormularioProductoScreenState extends State<FormularioProductoScreen> {
  final ProductoRepository _repo = ProductoRepository();
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _precioCtrl = TextEditingController();
  final TextEditingController _descripcionCtrl = TextEditingController();
  final TextEditingController _zonaCtrl = TextEditingController();
  final TextEditingController _contactoCtrl = TextEditingController();

  String? _categoria;
  String? _estado;
  String? error;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _precioCtrl.dispose();
    _descripcionCtrl.dispose();
    _zonaCtrl.dispose();
    _contactoCtrl.dispose();
    super.dispose();
  }

  // Revisa los campos. Regresa el mensaje de error o null si todo esta bien
  String? _validar() {
    final nombre = _nombreCtrl.text.trim();
    final descripcion = _descripcionCtrl.text.trim();
    final zona = _zonaCtrl.text.trim();
    final contacto = _contactoCtrl.text.trim();

    // Campos obligatorios
    if (nombre.isEmpty || descripcion.isEmpty || zona.isEmpty) {
      return 'Escribe nombre, descripción y zona';
    }

    // El precio debe ser un numero mayor que 0
    final precio = double.tryParse(_precioCtrl.text.trim());
    if (precio == null) {
      return 'El precio debe ser un número';
    }
    if (precio <= 0) {
      return 'El precio debe ser mayor que 0';
    }

    // Categoria y estado elegidos
    if (_categoria == null) {
      return 'Elige una categoría';
    }
    if (_estado == null) {
      return 'Elige el estado del artículo';
    }

    // Contacto: telefono de 10 digitos o correo valido
    final esTelefono = RegExp(r'^\d{10}$').hasMatch(contacto);
    final esCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(contacto);
    if (!esTelefono && !esCorreo) {
      return 'Usa un teléfono de 10 dígitos o un correo válido';
    }

    return null;
  }

  void _guardar() {
    final mensaje = _validar();
    if (mensaje != null) {
      setState(() => error = mensaje);
      return;
    }

    final producto = Producto(
      id: _repo.siguienteId(),
      nombre: _nombreCtrl.text.trim(),
      precio: double.parse(_precioCtrl.text.trim()),
      categoria: _categoria!,
      estado: _estado!,
      descripcion: _descripcionCtrl.text.trim(),
      zona: _zonaCtrl.text.trim(),
      contacto: _contactoCtrl.text.trim(),
      // Sin foto por ahora: se muestra el icono de la categoria
      rutaImagen: '',
    );
    _repo.agregar(producto);

    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${producto.nombre} registrado')));
    Navigator.pop(context);
  }

  // Chip para elegir una opcion (se usa en categoria y estado)
  Widget _chipOpcion(
    String texto,
    String? elegida,
    void Function(String) alElegir,
  ) {
    final seleccionado = elegida == texto;
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
      onSelected: (_) => setState(() {
        alElegir(texto);
        error = null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 'Todas' no es una categoria real, por eso se quita
    final categoriasReales = categorias.where((c) => c != 'Todas').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar artículo')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _precioCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  prefixText: '\$ ',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Categoría',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: categoriasReales
                    .map(
                      (c) => _chipOpcion(c, _categoria, (v) => _categoria = v),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Estado',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: estados
                    .map((e) => _chipOpcion(e, _estado, (v) => _estado = v))
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _descripcionCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _zonaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Zona de Tolcayuca',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _contactoCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Contacto (teléfono o correo)',
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.save),
                label: const Text('Guardar artículo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
