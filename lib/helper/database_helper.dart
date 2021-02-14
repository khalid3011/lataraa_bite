import 'package:get_storage/get_storage.dart';
import 'package:movie_house/common/keys.dart';
import 'package:movie_house/export/export.dart';

class DatabaseHelper {
  static void write(
    String key,
    String value, {
    bool encode = false,
  }) {
    GetStorage().write(key, encode ? Utills.encode(value) : value);
    print("write successfully");
  }

  static String read(
    String key, {
    bool decode = false,
  }) {
    var result = GetStorage().read(key);

    return decode ? Utills.decode(result) : result;
  }

  static void writeUserName(String name) {
    write(Keys.userName, name, encode: true);
  }

  static String readUserName() {
    return read(Keys.password, decode: true);
  }

  static void writeSeassion(String season) {
    write(Keys.sessionId, season);
  }

  static String readSeassion() {
    return read(Keys.sessionId);
  }
}
