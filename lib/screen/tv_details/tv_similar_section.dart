import 'package:lataraa_bite/export/export.dart';

class TvSimilarSection extends StatelessWidget {
  final int tvId;

  final _sectionHeight = 160.0;

  const TvSimilarSection({
    Key key,
    @required this.tvId,
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
            "SIMILAR TV SERIES",
            style: TextStyle(
              color: ColorPalette.title,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),

        AsyncBuilder<TvSimilar>(
          future: easyTmdb.tv().similar(tvId),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), _sectionHeight),
          builder: (context, data) => _viewResult(data),
        ),
      ],
    );
  }

  Widget _viewResult(TvSimilar data) {
    //copy data in new list because of shuffle
    List<TvSimilarResults> tempData = data.results;

    //shuffle data
    if (tempData.isNotEmpty) tempData.shuffle();

    //total number
    int _totalItem = tempData.length;

    //if no data found
    if (tempData.length == 0) {
      return ErrorShow("No Similar Tv Series Found", _sectionHeight);
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
                      tempData[index].name,
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
