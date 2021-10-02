import 'package:emp_details/util/color_constants.dart';
import 'package:emp_details/util/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircleProgress extends StatelessWidget {
  final String text;
  final double size;

  const CircleProgress({Key key, this.text, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: text == null
          ? <Widget>[
              Semantics(
                label: "Loading",
                child: SpinKitCircle(
                    size: size, color: ColorConstants.primaryBlack),
              ),
            ]
          : <Widget>[
              SpinKitCircle(size: size, color: ColorConstants.primaryBlack),
              SizedBox(height: 4.0),
              Text(text, textAlign: TextAlign.center, style: FontConstants.black14),
            ],
    );
  }
}
