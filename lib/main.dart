import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/router.dart' as router;
import 'config/routing_constants.dart';
import 'util/color_constants.dart';
import 'util/strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.generateRoute,
          initialRoute: LandingPageViewRoute,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: MaterialColor(ColorConstants.primaryBlack.value, ColorConstants.colorMap),
          ),
        ),
      );
    },
  );
}
