import 'dart:math';

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

String dateFormatted(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}

String timeFormatted(DateTime date) {
  return '${date.hour}:${date.minute}';
}

String dateTimeFormatted(DateTime date) {
  return '${timeFormatted(date)} • ${dateFormatted(date)}';
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
