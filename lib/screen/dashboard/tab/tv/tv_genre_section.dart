import 'package:movie_house/export/export.dart';
import 'package:movie_house/screen/by_genre/tv_by_genre_screen.dart';

class TVGenreSection extends StatelessWidget {
  final double _genreHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    final genres = easyTmdb.genres().movieWithoutFetch();
    final int _length = genres.length;
    return Container(
      height: _genreHeight,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Get.to(TvByGenreScreen(selectedIndex: index)),
          child: Wrap(
            children: [
              Container(
                margin: Constant.marginLVH(index, _length),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: ColorPalette.placeHolder,
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    genres[index].name.capitalize,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
