import 'producto_model.dart';

class ProductoRepository {
  static final List<Producto> _productos = [
    const Producto(
      id: 1,
      nombre: 'Chamarra de mezclilla',
      precio: 180,
      categoria: 'Ropa',
      estado: 'Buen estado',
      descripcion:
          'Chamarra unisex talla M, sin roturas y con todos sus botones.',
      zona: 'Centro',
      contacto: '7791234501',
      rutaImagen: 'img/productos/chamarra.jpg',
    ),
    const Producto(
      id: 2,
      nombre: 'Vestido floral',
      precio: 120,
      categoria: 'Ropa',
      estado: 'Como nuevo',
      descripcion: 'Vestido talla CH usado un par de veces. Tela ligera.',
      zona: 'San Antonio',
      contacto: '7791234502',
      rutaImagen: 'img/productos/vestido.jpg',
    ),
    const Producto(
      id: 3,
      nombre: 'Silla de madera',
      precio: 250,
      categoria: 'Muebles',
      estado: 'Usado',
      descripcion:
          'Silla firme de madera maciza. Ideal para restaurar o barnizar.',
      zona: 'Centro',
      contacto: '7791234503',
      rutaImagen: 'img/productos/silla.jpg',
    ),
    const Producto(
      id: 4,
      nombre: 'Mesa de centro',
      precio: 400,
      categoria: 'Muebles',
      estado: 'Buen estado',
      descripcion:
          'Mesa de centro de 90 x 50 cm con un pequeño detalle en una esquina.',
      zona: 'La Loma',
      contacto: '7791234504',
      rutaImagen: 'img/productos/mesa.jpg',
    ),
    const Producto(
      id: 5,
      nombre: 'Espejo con marco',
      precio: 150,
      categoria: 'Decoración',
      estado: 'Como nuevo',
      descripcion: 'Espejo redondo con marco dorado, listo para colgar.',
      zona: 'Centro',
      contacto: '7791234505',
      rutaImagen: 'img/productos/espejo.jpg',
    ),
    const Producto(
      id: 6,
      nombre: 'Maceta de barro',
      precio: 60,
      categoria: 'Decoración',
      estado: 'Usado',
      descripcion: 'Maceta grande de barro, perfecta para plantas de exterior.',
      zona: 'San Antonio',
      contacto: '7791234506',
      rutaImagen: 'img/productos/maceta.jpg',
    ),
    const Producto(
      id: 7,
      nombre: 'Juego de vasos',
      precio: 90,
      categoria: 'Hogar',
      estado: 'Buen estado',
      descripcion: 'Seis vasos de vidrio sin despostillar.',
      zona: 'La Loma',
      contacto: '7791234507',
      rutaImagen: 'img/productos/vasos.jpg',
    ),
    const Producto(
      id: 8,
      nombre: 'Licuadora',
      precio: 200,
      categoria: 'Hogar',
      estado: 'Usado',
      descripcion: 'Licuadora de 10 velocidades que funciona correctamente.',
      zona: 'Centro',
      contacto: '7791234508',
      rutaImagen: 'img/productos/licuadora.jpg',
    ),
  ];

  List<Producto> obtenerProductos() {
    return _productos;
  }

  int siguienteId() {
    if (_productos.isEmpty) return 1;
    return _productos.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  void agregar(Producto producto) {
    _productos.insert(0, producto);
  }
}
