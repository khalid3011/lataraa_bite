import 'package:lataraa_bite/export/export.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:lataraa_bite/common/utills.dart';

class Slide extends StatelessWidget {
  //total number of slide (+-) after filter
  final int _numOfSlide = 10;

  //slider height
  final double _sectionHeight = 220.0;

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<MovieNowPlaying>(
      future: easyTmdb.movie().nowPlaying(),
      waiting: (context) => Loading(_sectionHeight),
      error: (context, error, stackTrace) => ErrorShow(error.toString(), _sectionHeight),
      builder: (context, data) => _slide(data),
    );
  }

  Widget _slide(MovieNowPlaying data) {
    //copy data in new list because of suffle
    List<MovieNowPlayingResults> tempData = data.results;

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

    //total number of slide DEFALUT 10
    int _totalItem =
        tempData.length < _numOfSlide ? tempData.length : _numOfSlide;

    //if no data found
    if (tempData.length == 0) {
      return ErrorShow("No Movie found", _sectionHeight);
    }

    //show slide
    else
      return Container(
        height: _sectionHeight,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          padding: EdgeInsets.all(5.0),
          indicatorColor: ColorPalette.title,
          indicatorSelectorColor: ColorPalette.secondary,
          shape: IndicatorShape.circle(size: 5.0),
          length: _totalItem,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _totalItem,
            itemBuilder: (context, index) => Stack(
              children: [
                //image
                Container(
                  width: Get.width,
                  height: _sectionHeight,
                  child: ImageLoading(data.results[index].posterPath),
                ),

                //bottom shadow
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          ColorPalette.primary.withOpacity(1.0),
                          ColorPalette.primary.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.0,
                          0.9,
                        ]),
                  ),
                ),

                //play button
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Icon(
                    FontAwesomeIcons.playCircle,
                    color: ColorPalette.secondary.withOpacity(0.7),
                    size: 40.0,
                  ),
                ),

                //title
                Positioned(
                  bottom: 30.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          data.results[index].title,
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
