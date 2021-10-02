import 'package:dio/dio.dart';

class RestDatasource {
  static final RestDatasource _restDatasource = RestDatasource._internal();
  Dio _dio;
  CancelToken _cancelToken;

  factory RestDatasource() {
    return _restDatasource;
  }

  RestDatasource._internal();

  static final baseURL = "http://www.mocky.io";

  Future<Dio> get dio async {
    if (_dio == null) {
      _dio = await _initRestAPI();
    }
    return _dio;
  }

  _initRestAPI() async {
    var theDio = Dio(BaseOptions(baseUrl: baseURL));
    _cancelToken = CancelToken();
    return theDio;
  }

  cancelAllNetworkCalls() async {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
  }

  String _handleError(DioError e) {
    String errorMessage = "";
    switch (e.type) {
      case DioErrorType.sendTimeout:
        errorMessage = "Something went wrong.";
        break;
      case DioErrorType.cancel:
        errorMessage = "";
        break;
      case DioErrorType.response:
        errorMessage = "Something went wrong.";
        break;
      default:
        errorMessage = "Something went wrong.";
        break;
    }
    return errorMessage;
  }

  Future<dynamic> getEmployees() async {
    try {
      var restClient = await dio;
      final Response<List> response = await restClient.get("/v2/5d565297300000680030a986", cancelToken: _cancelToken);
      return {"success": true, "message": "Successfully Loaded", "data": response.data};
    } on DioError catch (e) {
      return {"success": false, "message": _handleError(e)};
    }
  }
}
