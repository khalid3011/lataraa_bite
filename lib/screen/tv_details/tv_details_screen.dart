import 'package:movie_house/export/export.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'tv_cast.dart';
import 'tv_full_info.dart';
import 'tv_genre.dart';
import 'tv_production_company.dart';
import 'tv_rating.dart';
import 'tv_similar_section.dart';

class TvDetailsScreen extends StatelessWidget {
  final TvDetails tvDetails;
  final int tvId;

  TvDetailsScreen({
    Key key,
    this.tvDetails,
    @required this.tvId,
  }) : super(key: key);

  final double _sectionHeight = Get.height;

  @override
  Widget build(BuildContext context) {
    print(tvId);
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      body: tvDetails != null
          ? _builder(tvDetails)
          : AsyncBuilder<TvDetails>(
              future: easyTmdb.tv().details(tvId),
              waiting: (context) => Loading(_sectionHeight),
              error: (context, error, stackTrace) =>
                  ErrorShow(error.toString(), _sectionHeight),
              builder: (context, data) => _builder(data),
            ),
    );
  }

  Widget _builder(TvDetails tv) {
    return Builder(
      builder: (context) => SliverFab(
        floatingPosition: FloatingPosition(right: 20.0),
        //get video
        floatingWidget: AsyncBuilder<Video>(
          future: easyTmdb.tv().video(tvId),
          waiting: (context) => Loading(70),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), 70),
          builder: (context, data) {
            return _video(data);
          },
        ),
        expandedHeight: 200.0,
        slivers: <Widget>[
          //cover title, play button
          _sliverAppBar(tv),

          //details
          SliverPadding(
            padding: EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                //rating
                TvRating(
                  rating: tv.popularity > 100 ? 10.0 : tv.popularity / 10.0,
                ),

                SizedBox(
                  height: 10,
                ),

                //overview title
                Padding(
                  padding: Constant.edgeH,
                  child: Text(
                    "OVERVIEW",
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

                //overview
                Padding(
                  padding: Constant.edgeH,
                  child: Text(
                    tv.overview,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),

                //genres
                Padding(
                  padding: Constant.edge,
                  child: TvGenre(genres: tv.genres),
                ),

                //cast
                TvCast(tvId: tv.id),

                //full info
                TvFullInfo(tvDetails: tv),

                //simillar
                TvSimilarSection(tvId: tv.id),

                //production company
                TvProductionCompany(tv.productionCompanies),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _video(Video data) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: ColorPalette.secondary,
      child: Icon(Icons.play_arrow),
    );
  }

  Widget _sliverAppBar(TvDetails tv) => SliverAppBar(
        backgroundColor: ColorPalette.primary,
        expandedHeight: 200.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          //tv title
          title: Text(
            tv.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          //tv cover
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
                    tv.posterPath,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),

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
}
