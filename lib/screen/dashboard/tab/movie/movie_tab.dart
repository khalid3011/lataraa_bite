import 'package:movie_house/export/export.dart';

import 'movie_genre_section.dart';
import 'movie_popular_section.dart';
import 'movie_top_rated_section.dart';
import 'movie_upcoming_section.dart';

class MovieTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        centerTitle: true,
        title: Text("MOVIE"),
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
          Header("Upcomig", titleColor: Colors.white.withOpacity(.5)),
          SizedBox(height: 10),
          MovieUpcomingSection(),
          MovieGenreSection(),
          SizedBox(height: 20),
          Header("Popular", titleColor: Colors.white.withOpacity(.5)),
          SizedBox(height: 10),
          MoviePopularSection(),
          Header("Top Rated", titleColor: Colors.white.withOpacity(.5)),
          SizedBox(height: 10),
          MovieTopRatedSection(),
        ],
      ),
    );
  }
}
