import 'package:movie_house/export/export.dart';

class TvFullInfo extends StatelessWidget {
  final TvDetails tvDetails;

  const TvFullInfo({
    Key key,
    @required this.tvDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constant.edge,
      child: Column(
        children: [
          Table(
            children: [
              //
              if (tvDetails.firstAirDate != null)
                _row("First Air Date", tvDetails.firstAirDate),

              //
              if (tvDetails.lastAirDate != null)
                _row("Last Air Date", tvDetails.lastAirDate),

              //
              if (tvDetails.nextEpisodeToAir != null)
                _row("Next Episode To Air", tvDetails.nextEpisodeToAir.airDate),

              //
              if (tvDetails.originalLanguage != null)
                _row("Original Language", tvDetails.originalLanguage),

              //
              if (tvDetails.originalName != null)
                _row("Priginal Name", tvDetails.originalName),

              //
              if (tvDetails.status != null) _row("Status", tvDetails.status),

              //
              if (tvDetails.type != null) _row("Type", tvDetails.type),
              //
              if (tvDetails.numberOfEpisodes != null)
                _row("Number Of Episodes",
                    tvDetails.numberOfEpisodes.toString()),

              //
              if (tvDetails.numberOfSeasons != null)
                _row("Number Of Seasons", tvDetails.numberOfSeasons.toString()),

              //
              if (tvDetails.episodeRunTime != null)
                _row("Episode Run Time", tvDetails.episodeRunTime.join(",")),

              //
              if (tvDetails.languages != null)
                _row("Languages", tvDetails.languages.join(",")),

              //
              if (tvDetails.originCountry != null)
                _row("Origin Country", tvDetails.originCountry.join(",")),
            ],
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
}
