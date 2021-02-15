import 'package:lataraa_bite/export/export.dart';

import 'genre_list.dart';

class MovieByGenreScreen extends StatelessWidget {
  final int selectedIndex;

  const MovieByGenreScreen({
    Key key,
    this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int _length = easyTmdb.genres().movieWithoutFetch().length;
    final genres = easyTmdb.genres().movieWithoutFetch();
    TabController _tabController;

    return Scaffold(
      backgroundColor: ColorPalette.primary,
      body: GenreList(
        length: _length,
        tabController: _tabController,
        genres: genres,
        genreType: GenreType.Movie,
      ),
    );
  }
}
