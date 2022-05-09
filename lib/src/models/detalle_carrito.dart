import 'dart:convert';

import 'package:app_pedidos/src/models/producto.dart';

DetalleCarritoModel productoModelFromJson(String str) =>
    DetalleCarritoModel.fromJson(json.decode(str));

String climaModelToJson(DetalleCarritoModel data) => json.encode(data.toJson());

class DetalleCarritoModel {
  int? idDetalleCarrito;
  int idCarrito;
  int idProducto;
  int cantidad;

  ProductoModel? producto;

  DetalleCarritoModel(
      {this.idDetalleCarrito,
      this.idCarrito = 0,
      this.idProducto = 0,
      this.cantidad = 0,
      this.producto,});

  factory DetalleCarritoModel.fromJson(Map<String, dynamic> json) =>
      DetalleCarritoModel(
        idDetalleCarrito: json["IdDetalleCarrito"] ?? '',
        idCarrito: json["IdCarrito"],
        idProducto: json["IdProducto"],
        cantidad: json["Cantidad"],
        producto: json["Producto"],
      );

  Map<String, dynamic> toJson() => {
        "IdDetalleCarrito": idDetalleCarrito,
        "IdCarrito": idCarrito,
        "IdProducto": idProducto,
        "Cantidad": cantidad,
        "Producto": producto,
      };
}
