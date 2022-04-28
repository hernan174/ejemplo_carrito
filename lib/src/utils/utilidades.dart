import 'dart:io';

class Utilidades {
  static bool existeAchivo(String fullpath) {
    if (fullpath.isEmpty || fullpath == 'NOK') {
      return false;
    }
    final file = File(fullpath);
    if (file.existsSync()) {
      return true;
    } else {
      return false;
    }
  }
}
