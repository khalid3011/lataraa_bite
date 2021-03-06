import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lataraa_bite/export/export.dart';

class MovieRating extends StatelessWidget {
  final double rating;

  const MovieRating({
    Key key,
    @required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constant.edge,
      child: Row(
        children: [
          //rating
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            width: 10,
          ),

          //rating start
          RatingBar(
            ignoreGestures: true,
            itemSize: 10.0,
            initialRating: rating / 2,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            onRatingUpdate: (double value) {
              print(value);
            },
            ratingWidget: RatingWidget(
              full: Icon(
                EvaIcons.star,
                color: ColorPalette.secondary,
              ),
              half: Icon(
                EvaIcons.star,
                color: Colors.amber,
              ),
              empty: Icon(
                EvaIcons.star,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
