import 'package:lataraa_bite/export/export.dart';

import 'user_favorite_section.dart';
import 'user_rated_section.dart';
import 'user_watchlist_section.dart';

class UserAllList extends StatelessWidget {
  final CreateSessionResponse auth;
  final UserDetails userDetails;

  const UserAllList({
    Key key,
    @required this.auth,
    @required this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserFavoriteSection(session: auth.sessionId),
        UserWatchListSection(session: auth.sessionId),
        UserRatedSection(session: auth.sessionId),
      ],
    );
  }
}
