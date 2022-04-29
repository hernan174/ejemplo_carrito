import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String climaModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  int? idProducto;
  String nombre;
  String precio;
  String categoria;
  String pathImagen;

  ProductoModel({
    this.idProducto,
    this.nombre = '',
    this.precio = '',
    this.categoria = '',
    this.pathImagen = '',
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["IdProducto"] ?? 0,
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
