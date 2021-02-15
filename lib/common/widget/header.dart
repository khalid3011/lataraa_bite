import 'package:lataraa_bite/export/export.dart';

class Header extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget actions;
  final Color titleColor;

  const Header(
    this.title, {
    Key key,
    this.subTitle,
    this.actions,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constant.edge,
      // color: Colors.amber,
      child: Row(
        children: [
          //title
          Text(
            title,
            style: TextStyle(
              color: titleColor ?? Colors.white,
              fontSize: 20.0,
            ),
          ),

          //subtitle
          if (subTitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "  $subTitle",
                style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontSize: 14.0,
                ),
              ),
            ),

          Spacer(),

          if (actions != null) actions,
        ],
      ),
    );
  }
}
