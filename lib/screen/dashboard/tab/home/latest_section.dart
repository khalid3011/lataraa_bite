import 'package:lataraa_bite/export/export.dart';

class LatestSection extends StatefulWidget {
  @override
  _LatestSectionState createState() => _LatestSectionState();
}

class _LatestSectionState extends State<LatestSection> {
  bool _selectMovie = true;
  bool _selectTv = false;

  //TODO filter adult and animation
  List<MovieDetails> _latestMovie;
  List<TvDetails> _latestTv;

  final _sectionHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //heading
        Header(
          "Latest",
          subTitle: "",
          actions: _actions(),
        ),

        //fetch latest movie only once
        if (_selectMovie && _latestMovie == null)
          AsyncBuilder<List<MovieDetails>>(
            future:
                easyTmdb.movie().latestWithMore(validImagePath: true, items: 1),
            waiting: (context) => Loading(_sectionHeight),
            error: (context, error, stackTrace) =>
                ErrorShow(error.toString(), _sectionHeight),
            builder: (context, data) {
              this._latestMovie = data;
              return _viewLatestMovie();
            },
          ),

        //fetch latest tv only once
        if (_selectTv && _latestTv == null)
          AsyncBuilder<List<TvDetails>>(
            future:
                easyTmdb.tv().latestWithMore(validImagePath: true, items: 1),
            waiting: (context) => Loading(_sectionHeight),
            error: (context, error, stackTrace) =>
                ErrorShow(error.toString(), _sectionHeight),
            builder: (context, data) {
              this._latestTv = data;
              return _viewLatestTv();
            },
          ),

        if (_latestMovie != null && _latestTv != null)
          _selectMovie ? _viewLatestMovie() : _viewLatestTv(),
      ],
    );
  }

  Widget _viewLatestMovie() {
    //if no data found
    if (_latestMovie.length == 0) {
      return ErrorShow("No Latest Movie", _sectionHeight);
    } else
      return Container(
        height: _sectionHeight,
        margin: Constant.edgeH,
        child: ImageLoading(
          _latestMovie[0].posterPath,
          radius: 10,
        ),
      );
  }

  Widget _viewLatestTv() {
//if no data found
    if (_latestTv.length == 0) {
      return ErrorShow("No Latest Tv Series", _sectionHeight);
    } else
      return Container(
        height: _sectionHeight,
        margin: Constant.edgeH,
        child: ImageLoading(
          _latestTv[0].posterPath,
          radius: 10,
        ),
      );
  }

  Widget _actions() => Row(
        children: [
          //action 1
          GestureDetector(
            onTap: () {
              if (_selectMovie) {
                _selectMovie = false;
                _selectTv = true;
              } else {
                _selectMovie = true;
                _selectTv = false;
              }
              setState(() {});
            },
            child: Text(
              _selectMovie ? "MOVIE" : "Movie",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          //divider
          Text(
            " / ",
            style: TextStyle(
              color: Colors.white,
            ),
          ),

          //action 2
          GestureDetector(
            onTap: () {
              if (_selectTv) {
                _selectMovie = true;
                _selectTv = false;
              } else {
                _selectMovie = false;
                _selectTv = true;
              }
              setState(() {});
            },
            child: Text(
              _selectTv ? "TV" : "Tv",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
