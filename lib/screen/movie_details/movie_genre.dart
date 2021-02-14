import 'package:movie_house/export/export.dart';

class MovieGenre extends StatelessWidget {
  final List<GenreDetails> genres;

  const MovieGenre({
    Key key,
    @required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Text(
          "GENRES",
          style: TextStyle(
            color: ColorPalette.title,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),

        SizedBox(
          height: 12.0,
        ),

        //genre list
        Container(
          height: 30.0,
          child: ListView.builder(
            itemCount: genres.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Text(
                  genres[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
