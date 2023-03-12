class Varifier {
  List<String> numChar = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> uAlphaChar = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  List<String> lAlphaChar = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ];
  List<String> sChar = [
    "~",
    "!",
    "@",
    "#",
    "%",
    "^",
    "&",
    "*",
    "(",
    ")",
    "_",
    "-",
    "=",
    "+",
    "[",
    "]",
    "{",
    "}",
    "|",
    ":",
    ";",
    "'",
    ",",
    "<",
    ".",
    ">",
    "?"
  ];

  bool checkPassword(String value) {
    int iCharCount = 0;
    int uCharCount = 0;
    int lCharCount = 0;
    int sCharCount = 0;
    for (int i = 0; i < value.length; i++) {
      if (numChar.contains(value[i])) {
        iCharCount++;
        continue;
      }
      if (uAlphaChar.contains(value[i])) {
        uCharCount++;
        continue;
      }
      if (lAlphaChar.contains(value[i])) {
        lCharCount++;
        continue;
      }
      if (sChar.contains(value[i])) {
        sCharCount++;
        continue;
      }
    }
    if (iCharCount == 2 &&
        uCharCount == 2 &&
        lCharCount == 2 &&
        sCharCount == 2) {
      return true;
    } else {
      return false;
    }
  }

}