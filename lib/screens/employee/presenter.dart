import 'package:emp_details/util/util_functions.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'view.dart';

abstract class EmployeeDetailsPresenter {
  void onViewAttached(EmployeeDetailsView view);

  void onViewDetached();

  void onLocationClick(item);

  void onContactClick(type, data);
}

class BasicEmployeeDetailsPresenter implements EmployeeDetailsPresenter {
  EmployeeDetailsView _view;

  BasicEmployeeDetailsPresenter();

  @override
  void onViewAttached(EmployeeDetailsView view) {
    _view = view;
  }

  @override
  void onViewDetached() {
    _view = null;
  }

  @override
  onLocationClick(item) {
    MapsLauncher.launchCoordinates(double.parse(item["lat"]), double.parse(item["lng"]));
  }

  @override
  void onContactClick(type, data) {
    if (type == "mail")
      UtilFunctions.launchURL("mailto:" + data);
    else if (type == "call")
      UtilFunctions.launchURL("tel::" + data);
    else if (type == "web") UtilFunctions.launchURL(data);
  }
}
