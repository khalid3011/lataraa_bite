import 'package:movie_house/export/export.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'movie_favorite_section.dart';
import 'movie_info.dart';
import 'movie_rating.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieDetails movieDetails;
  final int movieId;

  MovieDetailsScreen({
    Key key,
    this.movieDetails,
    @required this.movieId,
  }) : super(key: key);

  final double _sectionHeight = Get.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      body: movieDetails != null
          ? _builder(movieDetails)
          : AsyncBuilder<MovieDetails>(
              future: easyTmdb.movie().details(movieId),
              waiting: (context) => Loading(_sectionHeight),
              error: (context, error, stackTrace) =>
                  ErrorShow(error.toString(), _sectionHeight),
              builder: (context, data) => _builder(data),
            ),
    );
  }

  Widget _builder(MovieDetails movie) {
    return Builder(
      builder: (context) => SliverFab(
        floatingPosition: FloatingPosition(right: 20.0),
        //get video
        floatingWidget: AsyncBuilder<Video>(
          future: easyTmdb.movie().video(movieId),
          waiting: (context) => Loading(70),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), 70),
          builder: (context, data) {
            return _video(data);
          },
        ),
        expandedHeight: 200.0,
        slivers: <Widget>[
          //cover title, playbutton
          _sliverAppBar(movie),

          //details
          SliverPadding(
            padding: EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                //rating
                MovieRating(
                  rating:
                      movie.popularity > 100 ? 10.0 : movie.popularity / 10.0,
                ),

                MovieFavoriteSection(
                  movie: movie,
                ),

                //overview title
                Padding(
                  padding: Constant.edgeH,
                  child: Text(
                    "OVERVIEW",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ColorPalette.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //overview
                Padding(
                  padding: Constant.edgeH,
                  child: Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),

                //info
                MovieInfo(movie: movie),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _video(Video data) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: ColorPalette.secondary,
      child: Icon(Icons.play_arrow),
    );
  }

  Widget _sliverAppBar(MovieDetails movie) => SliverAppBar(
        backgroundColor: ColorPalette.primary,
        expandedHeight: 200.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          //movie title
          title: Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          //movie cover
          background: Stack(
            children: [
              //image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.amber,
                ),
                child: Container(
                  child: ImageLoading(
                    movie.posterPath,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),

              //shadow for title
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.0),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
}
