import 'dart:math';

import 'package:base32/base32.dart';

class Utills {
  static bool isAdult(String text) {
    List wordList = ["xxxx, porn, lesbian, gay"];
    text = text.toLowerCase();

    for (int i = 0; i < wordList.length; i++) {
      if (text.contains(wordList[i])) {
        return true;
      }
    }
    return false;
  }

  static encode(String value) {
    var a = "@latara" +
        base32.encodeHexString(value) +
        _getRandomString(5) +
        "bite#";

    return base32.encodeHexString(a);
  }

  static decode(String value) {
    String a = base32.decode(value).toString();
    a = a.substring(7, a.length - 10);
    return base32.decode(a).toString();
  }

  static String _getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }
}
