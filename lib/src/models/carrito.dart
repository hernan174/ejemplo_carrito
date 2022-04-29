import 'package:app_pedidos/src/models/detalle_carrito.dart';

import 'dart:convert';

CarritoModel productoModelFromJson(String str) =>
    CarritoModel.fromJson(json.decode(str));

String climaModelToJson(CarritoModel data) => json.encode(data.toJson());

class CarritoModel {
  int idCarrito;
  int cantItems;
  int total;
  List<DetalleCarritoModel> detalleCarrito;

  CarritoModel(
      {this.idCarrito = 0,
      this.cantItems = 0,
      this.total = 0,
      List<DetalleCarritoModel>? detalleCarrito})
      : detalleCarrito = detalleCarrito ?? [];

  factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        idCarrito: json["IdCarrito"],
        cantItems: json["CantItems"],
        total: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        "IdCarrito": idCarrito,
        "CantItems": cantItems,
        "Total": total,
      };
}
