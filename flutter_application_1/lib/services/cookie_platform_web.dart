import "dart:html" as html;

String? readCookieValue(String name) {
  final String all = html.document.cookie ?? "";
  if (all.isEmpty) {
    return null;
  }

  final String prefix = "$name=";
  for (final String part in all.split(";")) {
    final String trimmed = part.trim();
    if (trimmed.startsWith(prefix)) {
      return trimmed.substring(prefix.length);
    }
  }
  return null;
}

void writeCookieValue(String name, String value, {int maxAgeDays = 30}) {
  final int maxAgeSeconds = maxAgeDays * 24 * 60 * 60;
  html.document.cookie =
      "$name=$value; path=/; max-age=$maxAgeSeconds; samesite=lax";
}
