import 'dart:math';
import 'package:intl/intl.dart';


String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

int parseStringToNumber(String input) {
  final numberRegExp = RegExp(r'^\d+$'); // Matches only numbers
  final letterRegExp = RegExp(r'^[a-zA-Z]+$'); // Matches only letters

  if (numberRegExp.hasMatch(input)) {
    return int.parse(input);
  } else if (letterRegExp.hasMatch(input)) {
    return 0;
  } else {
    return 0; // Return -1 if the string contains any other characters
  }
}

String capitalize(String input) {
  return input[0].toUpperCase() + input.substring(1);
}

String dateFormatted(dynamic date) {
  if (date is String) {
    try {
      date = DateTime.parse(date).toLocal();
    } catch (e) {
      return '00-00-0000';
    }
  }
  if (date is DateTime) {
    return '${twoDigits(date.day)}-${twoDigits(date.month)}-${date.year}';
  }
  return '00-00-0000';
}

String timeFormatted(dynamic date) {
  if (date is String) {
    try {
      date = DateTime.parse(date).toLocal();
    } catch (e) {
      return '00:00';
    }
  }
  if (date is DateTime) {
    return '${twoDigits(date.hour)}:${twoDigits(date.minute)}';
  }
  return '00:00';
}

String dateTimeFormatted(dynamic date) {
  if (date is String) {
    try {
      date = DateTime.parse(date).toLocal();
    } catch (e) {
      return '0000-00-00 00:00';
    }
  }
  if (date is DateTime) {
    return '${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)} ${timeFormatted(date)}';
  }
  return '0000-00-00 00:00';
}

String timeAgo(dynamic date) {
  DateTime dateTime;
  if (date is String) {
    try {
      dateTime = DateTime.parse(date).toLocal();
    } catch (e) {
      return 'Invalid date';
    }
  } else if (date is DateTime) {
    dateTime = date.toLocal();
  } else {
    return 'Invalid date';
  }

  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else {
    return dateFormatted(dateTime);
  }
}

String numberFormatted(String number) {
  return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

String formatLargeNumber(String number) {
  double num = double.parse(number);
  if (num >= 1000000000) {
    return '${(num / 1000000000).round()}b';
  } else if (num >= 1000000) {
    return '${(num / 1000000).round()}m';
  } else if (num >= 1000) {
    return '${(num / 1000).round()}k';
  } else {
    return num.toString();
  }
}

String twoDigits(int n) => n.toString().padLeft(2, '0');
