Duration? parseOffset(String? offset) {
  if (offset == null) {
    return null;
  }

  final regex = RegExp(r'([+-])(\d{2}):(\d{2})');
  final match = regex.firstMatch(offset);

  if (match != null) {
    final sign = match.group(1);
    final hours = int.parse(match.group(2)!);
    final minutes = int.parse(match.group(3)!);

    int totalMinutes = hours * 60 + minutes;

    if (sign == '-') {
      totalMinutes = -totalMinutes;
    }

    return Duration(minutes: totalMinutes);
  }
  return null;
}
