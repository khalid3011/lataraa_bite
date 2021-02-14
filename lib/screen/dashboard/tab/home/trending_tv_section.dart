import 'package:movie_house/export/export.dart';
import 'package:movie_house/screen/tv_details/tv_details_screen.dart';

class TrendingTvSection extends StatefulWidget {
  @override
  _TrendingTvSectionState createState() => _TrendingTvSectionState();
}

class _TrendingTvSectionState extends State<TrendingTvSection> {
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
          subTitle: "TV",
          actions: _actions(),
        ),

        AsyncBuilder<TrendingTv>(
          future: _selectDay
              ? easyTmdb.trending().tvDay()
              : easyTmdb.trending().tvWeek(),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString().toString(), _sectionHeight),
          builder: (context, data) => _viewResult(data),
        ),
      ],
    );
  }

  Widget _viewResult(TrendingTv data) {
    //copy data in new list because of shuffle
    List<TrendingTvResults> tempData = data.results;

    //shuffle data
    if (tempData.isNotEmpty) tempData.shuffle();

    //total number of slide DEFAULT 10
    int _totalItem = tempData.length;

    //if no data found
    if (tempData.length == 0) {
      return ErrorShow("No Tv Series found", _sectionHeight);
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
              onTap: () => Get.to(TvDetailsScreen(tvId: tempData[index].id)),
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
