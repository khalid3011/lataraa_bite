import 'package:movie_house/export/export.dart';

class MovieTrailer extends StatelessWidget {
  final int movieId;

  final _sectionHeight = 116.0;

  const MovieTrailer({
    Key key,
    @required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Padding(
          padding: Constant.edge,
          child: Text(
            "MOVIE TRAILER",
            style: TextStyle(
              color: ColorPalette.title,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),

        //fetch video from tmdb
        AsyncBuilder<Video>(
          future: easyTmdb.movie().video(movieId),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), _sectionHeight),
          builder: (context, data) {
            return _video(data);
          },
        )
      ],
    );
  }

  Widget _video(Video data) {
    final int _size = data.results.length;

    //if no data found
    if (_size == 0) {
      return ErrorShow("No Trailer Found", _sectionHeight);
    }

    //show result
    else
      return Container(
        height: _sectionHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _size,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => null,
              child: Container(
                margin: Constant.marginLVH(index, _size, edge: 8),
                height: 110,
                width: 250,
                color: ColorPalette.placeHolder,
                // child: ImageLoading(tempData[index].posterPath),
              ),
            );
          },
        ),
      );
  }
}
