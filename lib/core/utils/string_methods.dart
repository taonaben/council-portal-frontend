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
