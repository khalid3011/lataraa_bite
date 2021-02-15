import 'package:lataraa_bite/export/export.dart';

class TvAiringTodaySection extends StatelessWidget {
  final double _upcomingSectionHeight = 110.0;

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
          itemBuilder: (context, TvAiringTodayResults tv, index) {
            return Container(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    height: 100,
                    child: ImageLoading(
                      tv.posterPath,
                      radius: 8.0,
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
          pageFuture: (pageIndex) async {
            print(pageIndex);
            return await easyTmdb
                .tv()
                .airingToday(page: pageIndex + 1)
                .then((value) {
              return value.results;
            });
          }),
    );
  }
}
