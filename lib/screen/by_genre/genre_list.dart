import 'package:movie_house/export/export.dart';

import 'movie_list.dart';
import 'tv_list.dart';

enum GenreType {
  Movie,
  Tv,
}

class GenreList extends StatelessWidget {
  final int _length;
  final TabController _tabController;
  final List<GenreDetails> genres;
  final GenreType genreType;

  const GenreList({
    Key key,
    @required int length,
    @required TabController tabController,
    @required this.genres,
    @required this.genreType,
  })  : _length = length,
        _tabController = tabController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _length,
      child: Scaffold(
        backgroundColor: ColorPalette.primary,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: ColorPalette.primary,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: ColorPalette.secondary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              unselectedLabelColor: ColorPalette.title,
              labelColor: Colors.white,
              isScrollable: true,
              tabs: genres.map((GenreDetails genre) {
                return Container(
                  padding: EdgeInsets.only(
                    bottom: 15.0,
                    top: 10.0,
                  ),
                  child: Text(
                    genre.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: genres.map((GenreDetails genre) {
            return genreType == GenreType.Movie
                ? GenreMovieList(genreId: genre.id)
                : GenreTvList(genreId: genre.id);
          }).toList(),
        ),
      ),
    );
  }
}
