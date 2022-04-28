import 'dart:convert';

DetalleCarritoModel productoModelFromJson(String str) =>
    DetalleCarritoModel.fromJson(json.decode(str));

String climaModelToJson(DetalleCarritoModel data) => json.encode(data.toJson());

class DetalleCarritoModel {
  final int idDetalleCarrito;
  final int idCarrito;
  final int idProducto;
  final int cantidad;

  DetalleCarritoModel(
      {this.idDetalleCarrito = 0,
      this.idCarrito = 0,
      this.idProducto = 0,
      this.cantidad = 0});

  factory DetalleCarritoModel.fromJson(Map<String, dynamic> json) =>
      DetalleCarritoModel(
        idDetalleCarrito: json["IdDetalleCarrito"],
        idCarrito: json["IdCarrito"],
        idProducto: json["IdProducto"],
        cantidad: json["Cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "IdDetalleCarrito": idDetalleCarrito,
        "IdCarrito": idCarrito,
        "IdProducto": idProducto,
        "Cantidad": cantidad,
      };
}
