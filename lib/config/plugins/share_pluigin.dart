import 'package:flutter_share/flutter_share.dart';

class SharePlugin {
  static Future<void> shareLink({required String link, required String subject}) async {
    await FlutterShare.share(title: subject, linkUrl: link);
  }
}
