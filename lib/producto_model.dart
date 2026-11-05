import 'package:flutter/material.dart';

class Producto {
  final int id;
  final String nombre;
  final double precio;
  final String categoria;
  final String estado; // 'Como nuevo', 'Buen estado' o 'Usado'
  final String descripcion;
  final String zona; // zona de Tolcayuca para el contacto
  final String contacto; // telefono de 10 digitos o correo
  final String rutaImagen;

  const Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.categoria,
    required this.estado,
    required this.descripcion,
    required this.zona,
    required this.contacto,
    required this.rutaImagen,
  });

  String get precioTexto => '\$${precio.toStringAsFixed(2)}';
}

/// Categorias permitidas. 'Todas' no es una categoria real: muestra todo.
const List<String> categorias = [
  'Todas',
  'Ropa',
  'Muebles',
  'Decoración',
  'Hogar',
];

/// Estados permitidos del articulo.
const List<String> estados = ['Como nuevo', 'Buen estado', 'Usado'];

/// Icono de respaldo cuando la imagen del producto no carga.
IconData iconoDeCategoria(String categoria) {
  switch (categoria) {
    case 'Ropa':
      return Icons.checkroom;
    case 'Muebles':
      return Icons.chair_alt;
    case 'Decoración':
      return Icons.palette_outlined;
    case 'Hogar':
      return Icons.kitchen_outlined;
    default:
      return Icons.recycling;
  }
}
