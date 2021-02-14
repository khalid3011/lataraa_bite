import 'package:movie_house/export/export.dart';

class TvProductionCompany extends StatelessWidget {
  final List<ProductionCompanies> productionCompanies;

  final double _sectionHeight = 100;

  const TvProductionCompany(
    this.productionCompanies, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(productionCompanies.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Padding(
          padding: Constant.edge,
          child: Text(
            "PRODUCTION COMPANY",
            style: TextStyle(
              color: ColorPalette.title,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),

        Container(
          height: _sectionHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productionCompanies.length,
            itemBuilder: (context, index) => Container(
              margin: productionCompanies.length == 1
                  ? EdgeInsets.only(left: 16.0)
                  : Constant.marginLVH(index, productionCompanies.length,
                      edge: 12),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: ColorPalette.placeHolder,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 50,
                      color: ColorPalette.placeHolder,
                      child: ImageLoading(
                        productionCompanies[index].logoPath,
                        radius: 8,
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    //title
                    Text(
                      productionCompanies[index].name,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
