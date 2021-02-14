import 'package:movie_house/export/export.dart';
import 'package:sliver_fab/sliver_fab.dart';

class PeopleDetailsScreen extends StatelessWidget {
  final int peopleId;

  const PeopleDetailsScreen({
    Key key,
    @required this.peopleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      body: AsyncBuilder<PeopleDetails>(
        future: easyTmdb.people().details(peopleId),
        waiting: (context) => Loading(Get.height),
        error: (context, error, stackTrace) =>
            ErrorShow(error.toString(), Get.height),
        builder: (context, data) => _builder(data),
      ),
    );
  }

  Widget _builder(PeopleDetails people) {
    return Builder(
      builder: (context) => SliverFab(
        floatingWidget: Container(),
        expandedHeight: 200.0,
        slivers: <Widget>[
          //cover title
          _sliverAppBar(people),

          //details
          SliverPadding(
            padding: EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                //details
                Padding(
                  padding: Constant.edgeH,
                  child: Table(
                    children: [
                      //
                      if (people.birthday != null)
                        _row("Birthday", people.birthday),

                      //
                      if (people.placeOfBirth != null)
                        _row("Birth Place", people.placeOfBirth),

                      //
                      if (people.gender != null)
                        _row(
                            "Gender",
                            people.gender == 0
                                ? "Not specified"
                                : people.gender == 1
                                    ? "Female"
                                    : "Male"),

                      //
                      if (people.deathday != null)
                        _row("Deathday", people.deathday),

                      //
                      if (people.imdbId != null) _row("IMDB Id", people.imdbId),

                      //
                      if (people.knownForDepartment != null)
                        _row("Known For", people.knownForDepartment),

                      //
                      if (people.alsoKnownAs != null)
                        _row("Also Known As", people.alsoKnownAs.join(", ")),
                    ],
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                //movie credits
                Padding(
                  padding: Constant.edgeH,
                  child: Text(
                    "MOVIE CREDITS",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ColorPalette.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //movie list
                _movieList(peopleId),

                SizedBox(
                  height: 20,
                ),

                //tv credits
                Padding(
                  padding: Constant.edgeH,
                  child: Text(
                    "TV CREDITS",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ColorPalette.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //movie list
                _tvList(peopleId),

                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _row(String title, String value) => TableRow(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white60,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      );

  Widget _sliverAppBar(PeopleDetails people) => SliverAppBar(
        backgroundColor: ColorPalette.primary,
        expandedHeight: 200.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          //movie title
          title: Text(
            people.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          //movie cover
          background: Stack(
            children: [
              //image
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.amber,
                  ),
                  child: Container(
                    child: ImageLoading(
                      people.profilePath,
                      boxFit: BoxFit.cover,
                    ),
                  )),

              //shadow for title
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.0),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _movieList(int peopleId) {
    final double _sectionHeight = 170.0;

    return AsyncBuilder<PeopleMovieCredits>(
        future: easyTmdb.people().movieCredits(peopleId),
        waiting: (context) => Loading(_sectionHeight),
        error: (context, error, stackTrace) =>
            ErrorShow(error.toString(), _sectionHeight),
        builder: (context, data) {
          final int size = data.cast.length + data.crew.length;

          return Container(
            height: _sectionHeight,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: size,
                itemBuilder: (context, index) {
                  var item;
                  if (index < data.cast.length) {
                    item = data.cast[index];
                  } else {
                    item = data.crew[index - data.cast.length];
                  }

                  return Container(
                    width: 70,
                    margin: Constant.marginLVH(index, size, edge: 12),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          color: ColorPalette.placeHolder,
                          child: ImageLoading(
                            item.posterPath,
                            radius: 8,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //title
                        Text(
                          item.title,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Widget _tvList(int peopleId) {
    final double _sectionHeight = 150.0;

    return AsyncBuilder<PeopleTvCredits>(
        future: easyTmdb.people().tvCredits(peopleId),
        waiting: (context) => Loading(_sectionHeight),
        error: (context, error, stackTrace) =>
            ErrorShow(error.toString(), _sectionHeight),
        builder: (context, data) {
          final int size = data.cast.length;

          return Container(
            height: _sectionHeight,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: size,
                itemBuilder: (context, index) {
                  var item = data.cast[index];

                  return Container(
                    width: 235,
                    margin: Constant.marginLVH(index, size, edge: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          color: ColorPalette.placeHolder,
                          child: ImageLoading(
                            item.posterPath,
                            radius: 8,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //title
                        Text(
                          item.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
