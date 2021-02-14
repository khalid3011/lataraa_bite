import 'package:movie_house/export/export.dart';

class MovieCast extends StatelessWidget {
  final int movieId;

  final _sectionHeight = 130.0;

  const MovieCast({
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
            "CAST & CREW",
            style: TextStyle(
              color: ColorPalette.title,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),

        AsyncBuilder<MovieCredits>(
          future: easyTmdb.movie().credits(movieId),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), _sectionHeight),
          builder: (context, data) => _people(data),
        ),
      ],
    );
  }

  Widget _people(MovieCredits data) {
    final int _length = data.cast.length + data.crew.length;

    return Container(
      height: _sectionHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _length,
          itemBuilder: (context, index) {
            var item;
            if (index < data.cast.length) {
              item = data.cast[index];
            } else {
              item = data.crew[index - data.cast.length];
            }
            return Container(
              width: 100,
              margin: Constant.marginLVH(index, _length),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //image
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.placeHolder,
                    ),
                    child: item.profilePath == null
                        ? Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white,
                          )
                        : ImageLoading(
                            easyTmdb.urlBuilder().build(
                                  item.profilePath,
                                  size: easyTmdb.imageSize().profileSize().w45,
                                ),
                            boxShape: BoxShape.circle,
                          ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //name
                  Text(
                    item.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  //known
                  Text(
                    index >= data.cast.length
                        ? item.department ?? ""
                        : item.character ?? "",
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.4,
                      color: ColorPalette.title,
                      fontWeight: FontWeight.w400,
                      fontSize: 9.0,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
