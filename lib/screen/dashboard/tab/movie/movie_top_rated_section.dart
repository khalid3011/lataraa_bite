import 'package:movie_house/export/export.dart';

class MovieTopRatedSection extends StatelessWidget {
  final double _topRatedSectionHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _topRatedSectionHeight,
      child: PagewiseListView(
          pageSize: 20,
          scrollDirection: Axis.horizontal,
          loadingBuilder: (context) {
            return Text('Loading...');
          },
          noItemsFoundBuilder: (context) {
            return Text('No Items Found');
          },
          retryBuilder: (context, callback) {
            return RaisedButton(
                child: Text('Retry'), onPressed: () => callback());
          },
          itemBuilder: (context, MovieTopRatedResults movie, index) {
            return Align(
              child: Container(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    Container(
                      margin: EdgeInsets.only(left: 16.0),
                      height: 130,
                      child: ImageLoading(
                        movie.posterPath,
                        radius: 8.0,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //title
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          pageFuture: (pageIndex) async {
            print(pageIndex);
            return await easyTmdb
                .movie()
                .topRated(page: pageIndex + 1)
                .then((value) {
              return value.results;
            });
          }),
    );
  }
}
