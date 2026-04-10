import "dart:convert";

import "package:flutter_application_1/models/bin_entry.dart";
import "package:flutter_application_1/services/cookie_platform_stub.dart"
    if (dart.library.html) "package:flutter_application_1/services/cookie_platform_web.dart";

class BinCookieService {
  static const String _cookieName = "recycle_bin_items";

  static List<BinEntry> loadEntries() {
    final String? raw = readCookieValue(_cookieName);
    if (raw == null || raw.isEmpty) {
      return const <BinEntry>[];
    }

    try {
      final String decoded = Uri.decodeComponent(raw);
      final List<dynamic> parsed = jsonDecode(decoded) as List<dynamic>;
      return parsed
          .whereType<Map<String, dynamic>>()
          .map(BinEntry.fromJson)
          .toList();
    } catch (_) {
      return const <BinEntry>[];
    }
  }

  static void saveEntries(List<BinEntry> entries) {
    final String payload = jsonEncode(entries.map((e) => e.toJson()).toList());
    final String encoded = Uri.encodeComponent(payload);
    writeCookieValue(_cookieName, encoded);
  }

  static void clearEntries() {
    writeCookieValue(_cookieName, Uri.encodeComponent("[]"), maxAgeDays: 0);
  }
}
