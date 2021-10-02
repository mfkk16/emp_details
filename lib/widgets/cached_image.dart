import 'package:cached_network_image/cached_network_image.dart';
import 'package:emp_details/util/assets_constants.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageURL;
  final String catchDPType;
  final double height;
  final double width;
  final double radius;

  ImageContainer({
    @required this.imageURL,
    this.catchDPType = "p",
    this.width = 50,
    this.height = 50,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    String catchImage = "";
    switch (catchDPType) {
      case "p":
        catchImage = AssetsConstants.profile_holder;
        break;
      default:
        catchImage = AssetsConstants.profile_holder;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageURL ?? "",
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          child: Image.asset(
            catchImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          child: Image.asset(
            catchImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
