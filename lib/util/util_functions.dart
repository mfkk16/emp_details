import 'package:url_launcher/url_launcher.dart';

class UtilFunctions {
  UtilFunctions._();

  static launchURL(url) async {
    final String _url = url;
    try {
      await launch(_url, forceSafariVC: false, forceWebView: false);
    } catch (e) {}
  }
}
