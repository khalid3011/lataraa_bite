import 'package:flutter/cupertino.dart';
import 'package:movie_house/export/export.dart';

class GenreTvList extends StatelessWidget {
  final int genreId;

  const GenreTvList({
    Key key,
    this.genreId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      easyTmdb.tvKeys().withGenres: genreId.toString(),
    };

    return Container(
      height: Get.height,
      child: PagewiseGridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.56,
          pageSize: 20,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 16.0,
          padding: Constant.edgeH / 2,
          loadingBuilder: (context) {
            return Container(
              height: Get.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          noItemsFoundBuilder: (context) {
            return Text(
              'No Items Found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            );
          },
          retryBuilder: (context, callback) {
            return RaisedButton(
                child: Text('Retry'), onPressed: () => callback());
          },
          itemBuilder: (context, DiscoverTvResults tv, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                //image
                Container(
                  height: 250,
                  child: ImageLoading(
                    tv.posterPath,
                    radius: 8.0,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //title
                Text(
                  tv.name,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
              ],
            );
          },
          pageFuture: (pageIndex) async {
            print(pageIndex);
            return await easyTmdb
                .discover()
                .tv(data, page: pageIndex + 1)
                .then((value) {
              return value.results;
            });
          }),
    );
  }
}
