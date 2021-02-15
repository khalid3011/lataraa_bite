import 'package:lataraa_bite/export/export.dart';

class MovieSimilarSection extends StatelessWidget {
  final int movieId;

  final _sectionHeight = 160.0;

  const MovieSimilarSection({
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
            "SIMILAR MOVIE",
            style: TextStyle(
              color: ColorPalette.title,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),

        AsyncBuilder<MovieSimilar>(
          future: easyTmdb.movie().similar(movieId),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), _sectionHeight),
          builder: (context, data) => _viewResult(data),
        ),
      ],
    );
  }

  Widget _viewResult(MovieSimilar data) {
    //copy data in new list because of shuffle
    List<MovieSimilarResults> tempData = data.results;

    //filter adult
    for (int i = tempData.length - 1; i >= 0; i--) {
      if (tempData[i].adult ||
          Utills.isAdult(tempData[i].originalTitle) ||
          Utills.isAdult(tempData[i].title)) {
        tempData.removeAt(i);
      }
    }

    //shuffle data
    if (tempData.isNotEmpty) tempData.shuffle();

    //total number
    int _totalItem = tempData.length;

    //if no data found
    if (tempData.length == 0) {
      return ErrorShow("No Similar Movie found", _sectionHeight);
    }

    //show result
    else
      return Container(
        height: _sectionHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _totalItem,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => null,
              child: Container(
                width: 110,
                margin: Constant.marginLVH(
                  index,
                  _totalItem,
                  edge: 14,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110,
                      child: ImageLoading(
                        tempData[index].posterPath,
                        radius: 8,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //name
                    Text(
                      tempData[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
