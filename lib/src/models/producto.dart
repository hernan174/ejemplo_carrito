import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String climaModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  final int idProducto;
  final String nombre;
  final String precio;
  final String categoria;
  final String pathImagen;

  ProductoModel({
    this.idProducto = 0,
    this.nombre = '',
    this.precio = '',
    this.categoria = '',
    this.pathImagen = '',
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["IdProducto"],
        nombre: json["Nombre"],
        precio: json["Precio"],
        categoria: json["Categoria"],
        pathImagen: json["PathImagen"],
      );

  Map<String, dynamic> toJson() => {
        "IdProducto": idProducto,
        "Nombre": nombre,
        "Precio": precio,
        "Categoria": categoria,
        "PathImagen": pathImagen,
      };
}
