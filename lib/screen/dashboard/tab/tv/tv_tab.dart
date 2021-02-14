import 'package:movie_house/export/export.dart';

import 'tv_airing_today.dart';
import 'tv_genre_section.dart';
import 'tv_on_the_air_section.dart';
import 'tv_popular_section.dart';
import 'tv_top_rated_section.dart';

class TvTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        centerTitle: true,
        title: Text("TV"),
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
            onPressed: null,
          ),
        ],
      ),
      body: ListView(
        children: [
          Header("Airing Today", titleColor: Colors.white.withOpacity(.5)),
          TvAiringTodaySection(),
          SizedBox(height: 10),
          TVGenreSection(),
          SizedBox(height: 20),
          Header("On The Air", titleColor: Colors.white.withOpacity(.5)),
          SizedBox(height: 10),
          TvOnTheAirSection(),
          Header("Popular", titleColor: Colors.white.withOpacity(.5)),
          SizedBox(height: 10),
          TvPopularSection(),
          Header("Top Rated", titleColor: Colors.white.withOpacity(.5)),
          SizedBox(height: 10),
          TvTopRatedSection(),
        ],
      ),
    );
  }
}
