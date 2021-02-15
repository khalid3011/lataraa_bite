import 'package:lataraa_bite/export/export.dart';

import 'movie_cast.dart';
import 'movie_genre.dart';
import 'movie_similar_section.dart';
import 'movie_trailer.dart';

class MovieInfo extends StatelessWidget {
  final MovieDetails movie;

  const MovieInfo({
    Key key,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),

        Padding(
          padding: Constant.edge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item("BUDGET", movie.budget.toString() + "\$"),
              _item("DURATION", movie.runtime.toString()),
              _item("RELEASE DATE", movie.releaseDate),
            ],
          ),
        ),

        SizedBox(
          height: 10,
        ),

        //genre
        Padding(
          padding: Constant.edge,
          child: MovieGenre(genres: movie.genres),
        ),

        SizedBox(
          height: 10,
        ),

        //cast
        MovieCast(movieId: movie.id),

        SizedBox(
          height: 10,
        ),

        //similar movie
        MovieSimilarSection(movieId: movie.id),

        SizedBox(
          height: 10,
        ),

        //movie trailer
        MovieTrailer(movieId: movie.id),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _item(String title, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //title
          Text(
            title,
            style: TextStyle(
              color: ColorPalette.title,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),

          //space
          SizedBox(
            height: 10,
          ),

          //value
          Text(
            value,
            style: TextStyle(
              color: ColorPalette.secondary,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
