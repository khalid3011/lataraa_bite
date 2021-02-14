import 'package:movie_house/export/export.dart';

class UserFavoriteSection extends StatefulWidget {
  final String session;

  const UserFavoriteSection({
    Key key,
    @required this.session,
  }) : super(key: key);

  @override
  _UserFavoriteSectionState createState() => _UserFavoriteSectionState();
}

class _UserFavoriteSectionState extends State<UserFavoriteSection> {
  bool _selectMovie = true;
  bool _selectTv = false;

  UserFavoriteMovie _movie;
  UserFavoriteTv _tv;

  final _sectionHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //heading
        Header(
          "Favorite",
          subTitle: "",
          actions: _actions(),
        ),

        //stream favorite movies
        if (_selectMovie)
          AsyncBuilder<UserFavoriteMovie>(
            future: easyTmdb.user().userFavoriteMovie(widget.session),
            waiting: (context) => Loading(_sectionHeight),
            error: (context, error, stackTrace) =>
                ErrorShow(error.toString(), _sectionHeight),
            builder: (context, data) {
              this._movie = data;
              return _showItems();
            },
          ),

        //stream favorite movies
        if (_selectTv)
          AsyncBuilder<UserFavoriteTv>(
            future: easyTmdb.user().userFavoriteTv(widget.session),
            waiting: (context) => Loading(_sectionHeight),
            error: (context, error, stackTrace) =>
                ErrorShow(error.toString(), _sectionHeight),
            builder: (context, data) {
              this._tv = data;
              return _showItems();
            },
          ),
      ],
    );
  }

  Widget _showItems() {
    final _length = _selectMovie ? _movie.results.length : _tv.results.length;

    if ((_selectMovie && _movie.results.length > 1) ||
        (_selectTv && _tv.results.length > 1))
      return Container(
        height: _sectionHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _length,
          itemBuilder: (BuildContext context, int index) {
            String path = _selectMovie
                ? _movie.results[index].posterPath
                : _tv.results[index].posterPath;
            return GestureDetector(
              onTap: () => null,
              child: Container(
                margin: Constant.marginLVH(index, _length, edge: 8),
                height: 110,
                width: 90,
                color: ColorPalette.placeHolder,
                child: ImageLoading(path),
              ),
            );
          },
        ),
      );
    else
      return _showOnlyOneItem(_length);
  }

  Widget _showOnlyOneItem(int length) {
    String img;

    if (length > 0) {
      img = _selectMovie
          ? _movie.results[0].posterPath
          : _tv.results[0].posterPath;
    }

    //if no data found
    if (length == 0) {
      return ErrorShow("Nothing Found", _sectionHeight);
    } else
      return Container(
        height: _sectionHeight,
        margin: Constant.edgeH,
        child: ImageLoading(
          img,
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
