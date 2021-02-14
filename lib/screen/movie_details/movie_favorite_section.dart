import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_house/export/export.dart';

class MovieFavoriteSection extends StatefulWidget {
  final MovieDetails movie;

  MovieFavoriteSection({
    Key key,
    @required this.movie,
  }) : super(key: key);

  @override
  _MovieFavoriteSectionState createState() => _MovieFavoriteSectionState();
}

class _MovieFavoriteSectionState extends State<MovieFavoriteSection> {
  double rate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Constant.edge.copyWith(top: 0),
      child: Row(
        children: [
          //mark as favorite
          item(
            "Mark as Favorite",
            () async {
              await easyTmdb
                  .user()
                  .markAsFavorite(
                    DatabaseHelper.readSeassion(),
                    MediaType.Movie,
                    widget.movie.id,
                    true,
                  )
                  .then((value) {
                print(value);
              });
            },
          ),

          //add to watchlist
          item(
            "Add to watchlist",
            () async {
              await easyTmdb
                  .user()
                  .addToWatchlist(
                    DatabaseHelper.readSeassion(),
                    MediaType.Movie,
                    widget.movie.id,
                    true,
                  )
                  .then((value) {
                print(value);
              });
            },
          ),

          //give rating
          GestureDetector(
            onTap: () {
              _showRatingModal();
            },
            child: Row(
              children: [
                Text(
                  "0.0",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingModal() {
    Get.bottomSheet(
      Container(
        height: Get.height * .4,
        padding: Constant.edge,
        decoration: BoxDecoration(
          color: ColorPalette.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            // SizedBox(height: 20),
            _rating(),

            // SizedBox(height: 20),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(
                //   rate.toString(),
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 25.0,
                //   ),
                // ),

                //
                RaisedButton(
                  onPressed: () async {
                    await easyTmdb
                        .movie()
                        .rate(
                          DatabaseHelper.readSeassion(),
                          widget.movie.id,
                          rate,
                        )
                        .then((value) {
                      print(value);
                    });
                  },
                  color: ColorPalette.secondary,
                  child: Text("Rate"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  RatingBar _rating() {
    return RatingBar(
      itemSize: 30.0,
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 10,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      onRatingUpdate: (double value) {
        print(value);
        rate = value;
        setState(() {});
      },
      ratingWidget: RatingWidget(
        full: Icon(
          EvaIcons.star,
          color: ColorPalette.secondary,
        ),
        half: Icon(
          EvaIcons.star,
          color: ColorPalette.secondary.withOpacity(.5),
        ),
        empty: Icon(
          EvaIcons.star,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget item(String title, Function ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        margin: EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: ColorPalette.placeHolder,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
