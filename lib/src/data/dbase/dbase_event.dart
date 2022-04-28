abstract class DbaseEvent<T> {
  /// [guardar] Funcion que detarmina si se Actualiza el Registro o se Agrega uno Nuevo
  /// Paramentros [where] se utiliza para determinar los valores que determinar el Id
  /// de cada registro por ej: [Id = ?] se debe especificar el nombre del campo y el
  /// operador [= ?], Otro paramentro es [whereArgs] que corresponde a la lista de Objetos
  /// que van a reemplazar los [?] del parametro where, [data] corresponde al mapa
  ///  que se va a Guardar/Actualizar y por ultimo [origen] si el valor que se
  /// va a gurdad se trae el Servidor o se dio de alta en el dispositivo valores
  /// admitidos (D/S) Dispostivo/Server
  Future<Map<String, dynamic>> guardar(
      {required String where,
      required List<dynamic> whereArgs,
      required T data,
      required String origen});
  Future<Map<String, dynamic>> agrega({required T data});
  Future<Map<String, dynamic>> leerById(
      {required String where, required List<dynamic> whereArgs});
  Future<Map<String, dynamic>> eliminar(
      {required String where, required List<dynamic> whereArgs});
}
