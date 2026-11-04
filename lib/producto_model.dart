import 'package:flutter/material.dart';

class Producto {
  final int id;
  final String nombre;
  final double precio;
  final String categoria;
  final String estado; // 'Como nuevo', 'Buen estado' o 'Usado'
  final String descripcion;
  final String zona; // zona de Tolcayuca para el contacto
  final String rutaImagen;

  const Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.categoria,
    required this.estado,
    required this.descripcion,
    required this.zona,
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

const List<Producto> listaProductos = [
  Producto(
    id: 1,
    nombre: 'Chamarra de mezclilla',
    precio: 180,
    categoria: 'Ropa',
    estado: 'Buen estado',
    descripcion: 'Chamarra unisex talla M, sin roturas y con todos sus botones.',
    zona: 'Centro',
    rutaImagen: 'img/productos/chamarra.jpg',
  ),
  Producto(
    id: 2,
    nombre: 'Vestido floral',
    precio: 120,
    categoria: 'Ropa',
    estado: 'Como nuevo',
    descripcion: 'Vestido talla CH usado un par de veces. Tela ligera.',
    zona: 'San Antonio',
    rutaImagen: 'img/productos/vestido.jpg',
  ),
  Producto(
    id: 3,
    nombre: 'Silla de madera',
    precio: 250,
    categoria: 'Muebles',
    estado: 'Usado',
    descripcion: 'Silla firme de madera maciza. Ideal para restaurar o barnizar.',
    zona: 'Centro',
    rutaImagen: 'img/productos/silla.jpg',
  ),
  Producto(
    id: 4,
    nombre: 'Mesa de centro',
    precio: 400,
    categoria: 'Muebles',
    estado: 'Buen estado',
    descripcion: 'Mesa de centro de 90 x 50 cm con un pequeño detalle en una esquina.',
    zona: 'La Loma',
    rutaImagen: 'img/productos/mesa.jpg',
  ),
  Producto(
    id: 5,
    nombre: 'Espejo con marco',
    precio: 150,
    categoria: 'Decoración',
    estado: 'Como nuevo',
    descripcion: 'Espejo redondo con marco dorado, listo para colgar.',
    zona: 'Centro',
    rutaImagen: 'img/productos/espejo.jpg',
  ),
  Producto(
    id: 6,
    nombre: 'Maceta de barro',
    precio: 60,
    categoria: 'Decoración',
    estado: 'Usado',
    descripcion: 'Maceta grande de barro, perfecta para plantas de exterior.',
    zona: 'San Antonio',
    rutaImagen: 'img/productos/maceta.jpg',
  ),
  Producto(
    id: 7,
    nombre: 'Juego de vasos',
    precio: 90,
    categoria: 'Hogar',
    estado: 'Buen estado',
    descripcion: 'Seis vasos de vidrio sin despostillar.',
    zona: 'La Loma',
    rutaImagen: 'img/productos/vasos.jpg',
  ),
  Producto(
    id: 8,
    nombre: 'Licuadora',
    precio: 200,
    categoria: 'Hogar',
    estado: 'Usado',
    descripcion: 'Licuadora de 10 velocidades que funciona correctamente.',
    zona: 'Centro',
    rutaImagen: 'img/productos/licuadora.jpg',
  ),
];
