class MonedaGenerica {
  final String fecha;
  final String compra;
  final String venta;

  MonedaGenerica({
    this.fecha,
    this.compra,
    this.venta,
  });

  MonedaGenerica.fromJson(Map json)
      : fecha = json["fecha"],
        compra = json["compra"],
        venta = json["venta"];
}
