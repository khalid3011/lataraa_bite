import 'package:movie_house/export/export.dart';

class Loading extends StatelessWidget {
  final double height;

  const Loading(
    this.height, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: ColorPalette.placeHolder,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
