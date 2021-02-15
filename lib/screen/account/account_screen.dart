import 'package:lataraa_bite/export/export.dart';

import 'user_all_details.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primary,
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
      ),
      //request for tocken
      body: AsyncBuilder<CreateSessionResponse>(
          future: easyTmdb.auth().signIn("KhalidHassan", "latarabite"),
          waiting: (context) => Loading(Get.height),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), Get.height),
          builder: (context, data) {
            print("Session: " + data.sessionId);
            DatabaseHelper.writeSeassion(data.sessionId);
            return !data.success
                ? Center(
                    child: Text(
                      "Login Failed. please try again",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : AsyncBuilder<UserDetails>(
                    future: easyTmdb.user().userDetails(data.sessionId),
                    waiting: (context) => Loading(Get.height),
                    error: (context, error, stackTrace) =>
                        ErrorShow(error.toString(), Get.height),
                    builder: (context, udata) {
                      print("account: " + udata.id.toString());
                      return UserAllList(
                        auth: data,
                        userDetails: udata,
                      );
                    });
          }),
    );
  }
}
