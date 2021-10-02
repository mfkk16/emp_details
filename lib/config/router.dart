import 'package:emp_details/screens/employee/page.dart';
import 'package:emp_details/screens/landing_page.dart';
import 'package:emp_details/widgets/undefined_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingPageViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage(), settings: settings);

    case EmployeeDetailsViewRoute:
      return MaterialPageRoute(builder: (context) => EmployeeDetailsPage(settings.arguments), settings: settings);

    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name), settings: settings);
  }
}
