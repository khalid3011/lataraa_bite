import 'package:movie_house/export/export.dart';

class Constant {
  static const double _edge = 16.0;
  static const edge = EdgeInsets.all(_edge);
  static const edgeH = EdgeInsets.symmetric(horizontal: _edge);
  static const edgeV = EdgeInsets.symmetric(vertical: _edge);

  static marginLVH(int index, int total, {double edge = _edge / 2}) =>
      index == total - 1
          ? EdgeInsets.only(right: _edge, left: edge)
          : index == 0
              ? EdgeInsets.only(left: _edge)
              : EdgeInsets.only(left: edge);
}
