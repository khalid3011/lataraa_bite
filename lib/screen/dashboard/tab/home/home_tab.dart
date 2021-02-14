import 'package:movie_house/export/export.dart';
import 'package:movie_house/screen/search/search_screen.dart';
import 'latest_section.dart';
import 'people_section.dart';
import 'slide.dart';
import 'trending_movie_section.dart';
import 'trending_tv_section.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        centerTitle: true,
        title: Text(""),
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () => Get.to(SearchScreen()),
          ),
        ],
      ),
      body: ListView(
        children: [
          Slide(),
          LatestSection(),
          TrendingMovieSection(),
          TrendingTvSection(),
          PeopleSection(),
        ],
      ),
    );
  }
}
