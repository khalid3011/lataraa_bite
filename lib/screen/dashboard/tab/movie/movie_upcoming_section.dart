import 'package:lataraa_bite/export/export.dart';

class MovieUpcomingSection extends StatelessWidget {
  final double _upcomingSectionHeight = 260.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _upcomingSectionHeight,
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
          itemBuilder: (context, MovieUpcomingResults movie, index) {
            return Container(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    height: 220,
                    child: ImageLoading(
                      movie.posterPath,
                      radius: 8.0,
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //title
                  // Padding(
                  //   padding: EdgeInsets.only(left: 16.0),
                  //   child: Text(
                  //     movie.title,
                  //     textAlign: TextAlign.start,
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
          pageFuture: (pageIndex) async {
            print(pageIndex);
            return await easyTmdb
                .movie()
                .upcoming(page: pageIndex + 1)
                .then((value) {
              return value.results;
            });
          }),
    );
  }
}
