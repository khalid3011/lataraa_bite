import 'package:movie_house/export/export.dart';
import 'package:movie_house/screen/people_details/people_details_screen.dart';

class PeopleSection extends StatelessWidget {
  final _sectionHeight = 116.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //heading
        Header(
          "",
          subTitle: "POPULAR PERSON",
        ),

        AsyncBuilder<PeoplePopular>(
          future: easyTmdb.people().popular(),
          waiting: (context) => Loading(_sectionHeight),
          error: (context, error, stackTrace) =>
              ErrorShow(error.toString(), _sectionHeight),
          builder: (context, data) => _people(data),
        ),
      ],
    );
  }

  Widget _people(PeoplePopular data) {
    final int _length = data.results.length;
    return Container(
      height: _sectionHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.to(PeopleDetailsScreen(
                peopleId: data.results[index].id,
              )),
              child: Container(
                width: 80,
                margin: Constant.marginLVH(index, _length, edge: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.placeHolder,
                      ),
                      child: data.results[index].profilePath == null
                          ? Icon(
                              FontAwesomeIcons.userAlt,
                              color: ColorPalette.secondary,
                            )
                          : ImageLoading(
                              easyTmdb.urlBuilder().build(
                                    data.results[index].profilePath,
                                    size:
                                        easyTmdb.imageSize().profileSize().w185,
                                  ),
                              boxShape: BoxShape.circle,
                            ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //name
                    Text(
                      data.results[index].name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),

                    SizedBox(
                      height: 3,
                    ),

                    //known
                    Text(
                      "Known for " + data.results[index].knownForDepartment,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                        color: ColorPalette.title,
                        fontWeight: FontWeight.w400,
                        fontSize: 9.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
