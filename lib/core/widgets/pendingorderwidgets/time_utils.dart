class TimeUtils {
  static DateTime _parseTimeString(String timeStr) {
    final List<String> parts = timeStr.split(' ');
    final List<String> timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    
    // Adjust for PM
    if (parts.length > 1 && parts[1] == 'PM' && hour < 12) {
      hour += 12;
    }
    // Adjust for AM
    if (parts.length > 1 && parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }
    
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  // Helper method to compare time strings
  static bool isLaterTime(String time1, String time2) {
    final DateTime t1 = _parseTimeString(time1);
    final DateTime t2 = _parseTimeString(time2);
    return t1.isAfter(t2);
  }
}