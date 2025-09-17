String getFormattedDate(DateTime dateTime) {
  
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  
  
  final localDateTime = dateTime.toLocal();
  final noteDate = DateTime(localDateTime.year, localDateTime.month, localDateTime.day);

  
  final diffDays = today.difference(noteDate).inDays;
  
  
  final timeStr = _formatTime(localDateTime);

  
  if (diffDays == 0) {
    return "Today, $timeStr";
  } else if (diffDays == 1) {
    return "Yesterday, $timeStr";
  } else if (diffDays > 1 && diffDays < 7) {
    return "${_getWeekday(localDateTime.weekday)}, $timeStr";
  } else {
    return "${_twoDigits(noteDate.day)}/${_twoDigits(noteDate.month)}/${_twoDigits(noteDate.year % 100)}";
  }
}

String _formatTime(DateTime dt) {
  final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
  final ampm = dt.hour < 12 ? 'AM' : 'PM';
  return '${_twoDigits(hour)}:${_twoDigits(dt.minute)} $ampm';
}

String _getWeekday(int weekday) {
  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  return days[weekday];
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');