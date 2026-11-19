import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a web address in the phone's browser.
@lazySingleton
class LinkService {
  Future<bool> open(Uri uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);
}
