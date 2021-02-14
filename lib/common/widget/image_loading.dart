import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_house/export/export.dart';

class ImageLoading extends StatelessWidget {
  final String url;
  final double radius;
  final BoxFit boxFit;
  final BoxShape boxShape;
  final ColorFilter colorFilter;

  const ImageLoading(
    this.url, {
    Key key,
    this.radius = 0,
    this.boxFit,
    this.boxShape,
    this.colorFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        imageBuilder: (context, imageProvider) => Container(
          decoration: boxShape == null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: _image(imageProvider),
                )
              : BoxDecoration(
                  shape: boxShape ?? BoxShape.rectangle,
                  image: _image(imageProvider),
                ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  DecorationImage _image(ImageProvider<Object> imageProvider) =>
      DecorationImage(
        image: imageProvider,
        fit: boxFit ?? BoxFit.cover,
        colorFilter: colorFilter,
      );
}
