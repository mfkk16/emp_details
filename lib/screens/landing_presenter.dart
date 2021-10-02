import 'package:emp_details/data/database.dart';
import 'package:emp_details/data/rest_datasource.dart';

import 'landing_view.dart';

abstract class LandingPresenter {
  void onViewAttached(LandingView view);

  void onViewDetached();

  void onLocalDbLoad();

  void onDataRequest();

  void onCardClick(item);
}

class BasicLandingPresenter implements LandingPresenter {
  LandingView _view;

  BasicLandingPresenter();

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final RestDatasource _restDatasource = RestDatasource();

  @override
  void onViewAttached(LandingView view) {
    _view = view;
  }

  @override
  void onViewDetached() {
    _view = null;
  }

  @override
  void onDataRequest() async {
    _view?.onSetProgress(true);
    final res = await _restDatasource.getEmployees();
    if (!res["success"]) {
      _view?.onSetProgress(false);
      _view?.onShowMessage(res["message"]);
      return;
    }
    final resDb = await _databaseHelper.setEmpData(res["data"]);
    _view?.onDataLoaded(res["data"]);
    _view?.onSetProgress(false);
  }

  @override
  void onLocalDbLoad() async {
    _view?.onSetProgress(true);
    final res = await _databaseHelper.getEmpData();
    if (res.isEmpty) {
      _view?.onSetProgress(false);
      onDataRequest();
      return;
    }
    _view?.onDataLoaded(res);
    _view?.onSetProgress(false);
  }

  @override
  void onCardClick(item) {
    _view?.onNavigateToEmpDetailsPage(item);
  }
}
