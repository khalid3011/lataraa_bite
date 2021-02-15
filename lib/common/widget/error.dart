import 'package:lataraa_bite/export/export.dart';

class ErrorShow extends StatelessWidget {
  final String error;
  final double height;

  const ErrorShow(
    this.error,
    this.height, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: Constant.edgeH,
      decoration: BoxDecoration(
        color: ColorPalette.placeHolder,
      ),
      child: Center(
        child: Text(
          error,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
