import 'package:flutter/material.dart';

class Producto {
  final int id;
  final String nombre;
  final double precio;
  final String categoria;
  final String estado;
  final String descripcion;
  final String zona;
  final String contacto;
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

const List<String> categorias = [
  'Todas',
  'Ropa',
  'Muebles',
  'Decoración',
  'Hogar',
];

const List<String> estados = ['Como nuevo', 'Buen estado', 'Usado'];

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
