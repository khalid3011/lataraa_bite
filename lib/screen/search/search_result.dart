import 'package:movie_house/export/export.dart';

enum MediaType { Movie, Tv, Person }

// ignore: must_be_immutable
class SearchResult extends StatelessWidget {
  final int section;
  final String query;

  SearchResult({
    Key key,
    @required this.section,
    @required this.query,
  }) : super(key: key);

  PagewiseLoadController _pageLoadController;
  int pageIndex;

  @override
  Widget build(BuildContext context) {
    _pageLoadController = PagewiseLoadController(
      pageSize: 20,
      pageFuture: (pageIndex) async {
        return await fetchResult(pageIndex);
      },
    );

    return Container(
      height: Get.height,
      child: query == null || query.isEmpty
          ? Center(
              child: Text(
                "Search here...",
                style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontSize: 25.0,
                ),
              ),
            )
          : section == 5
              ? AsyncBuilder<SearchKeyword>(
                  future: easyTmdb.search().keyword(query),
                  waiting: (context) => Loading(Get.height),
                  error: (context, error, stackTrace) =>
                      ErrorShow(error.toString(), Get.height),
                  builder: (context, data) => keywords(data.results),
                )
              : PagewiseGridView.count(
                  pageLoadController: _pageLoadController,
                  crossAxisCount: 3,
                  childAspectRatio: 0.48,
                  // pageSize: 20,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 8.0,
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
                    return Center(
                      child: RaisedButton(
                        child: Text('Retry'),
                        onPressed: () => fetchResult(pageIndex),
                      ),
                    );
                  },
                  itemBuilder: (context, dynamic data, index) {
                    String title, image;

                    if (section == 0 || section == 1) {
                      title = data.title;
                      image = data.posterPath;
                    } else if (section == 2) {
                      title = data.name;
                      image = data.posterPath;
                    } else if (section == 3) {
                      title = data.name;
                      image = data.profilePath;
                    } else if (section == 4) {
                      title = data.name;
                      image = data.logoPath;
                    } else if (section == 5) {
                      return keywords(data);
                    } else if (section == 6) {
                      title = data.name;
                      image = data.posterPath;
                    }

                    return item(image, title);
                  },
                ),
    );
  }

  Widget item(
    String poster,
    String title, {
    double imageheight = 180,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        //image
        Container(
          height: imageheight,
          child: ImageLoading(
            poster,
            radius: 8.0,
          ),
        ),

        SizedBox(
          height: 10,
        ),

        //title
        Text(
          title,
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
  }

  Future<dynamic> fetchResult(int pageIndex) async {
    this.pageIndex = pageIndex;

    switch (section) {
      case 0:
        return await easyTmdb
            .search()
            .multi(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;

      case 1:
        return await easyTmdb
            .search()
            .movie(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;

      case 2:
        return await easyTmdb
            .search()
            .tv(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;

      case 3:
        return await easyTmdb
            .search()
            .people(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;

      case 4:
        return await easyTmdb
            .search()
            .company(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;

      case 5:
        return await easyTmdb
            .search()
            .keyword(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;

      case 6:
        return await easyTmdb
            .search()
            .collection(query, page: pageIndex + 1)
            .then((value) {
          this._pageLoadController.reset();
          return value.results;
        });
        break;
    }
  }

  Widget keywords(List<SearchKeywordResults> data) {
    return Wrap(
      children: [
        ...List.generate(
          data.length,
          (index) => Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: ColorPalette.placeHolder,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              data[index].name.capitalize,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
