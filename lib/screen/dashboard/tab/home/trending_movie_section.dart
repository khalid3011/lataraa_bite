import 'package:movie_house/export/export.dart';
import 'package:movie_house/screen/movie_details/movie_details_screen.dart';

class TrendingMovieSection extends StatefulWidget {
  @override
  _TrendingMovieSectionState createState() => _TrendingMovieSectionState();
}

class _TrendingMovieSectionState extends State<TrendingMovieSection> {
  bool _selectDay = true;
  bool _selectWeek = false;

  final _sectionHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //heading
        Header(
          "Trending",
          subTitle: "MOVIE",
          actions: _actions(),
        ),

        AsyncBuilder<TrendingMovie>(
          future: _selectDay
              ? easyTmdb.trending().movieDay()
              : easyTmdb.trending().movieWeek(),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), _sectionHeight),
          builder: (context, data) => _viewResult(data),
        ),
      ],
    );
  }

  Widget _viewResult(TrendingMovie data) {
    //copy data in new list because of shuffle
    List<TrendingMovieResults> tempData = data.results;

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

    //total number of slide DEFAULT 10
    int _totalItem = tempData.length;

    //if no data found
    if (tempData.length == 0) {
      return ErrorShow("No Movie found", _sectionHeight);
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
              onTap: () => Get.to(
                MovieDetailsScreen(
                  movieId: tempData[index].id,
                ),
              ),
              child: Container(
                margin: Constant.marginLVH(index, _totalItem, edge: 8),
                height: 110,
                width: 90,
                color: ColorPalette.placeHolder,
                child: ImageLoading(tempData[index].posterPath),
              ),
            );
          },
        ),
      );
  }

  Widget _actions() => Row(
        children: [
          //action 1
          GestureDetector(
            onTap: () {
              if (_selectDay) {
                _selectDay = false;
                _selectWeek = true;
              } else {
                _selectDay = true;
                _selectWeek = false;
              }
              setState(() {});
            },
            child: Text(
              _selectDay ? "DAY" : "Day",
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
              if (_selectWeek) {
                _selectDay = true;
                _selectWeek = false;
              } else {
                _selectDay = false;
                _selectWeek = true;
              }
              setState(() {});
            },
            child: Text(
              _selectWeek ? "WEEK" : "Week",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
