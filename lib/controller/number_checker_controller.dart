import 'dart:math';

class NumberController {
  bool isPrime(int number) {
    number = number.abs();  
    if (number < 2) return false;
    for (int i = 2; i <= sqrt(number).toInt(); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  bool isComposite(int number) {
    number = number.abs();  
    return number > 1 && !isPrime(number);
  }

  bool isPerfectSquare(int number) {
    number = number.abs();  
    int root = sqrt(number).toInt();
    return root * root == number;
  }

  bool isPerfectCube(int number) {
    final int root = pow(number.abs(), 1 / 3).round();
    return root * root * root == number.abs();
  }

  bool isFibonacci(int number) {
    number = number.abs();  
    int a = 5 * number * number;
    return isPerfectSquare(a + 4) || isPerfectSquare(a - 4);
  }

  bool isPalindrome(int number) {
    String str = number.toString();
    return str == str.split('').reversed.join();
  }

  bool isArmstrong(int number) {
    int sum = 0, temp = number.abs();
    int digits = number.abs().toString().length;
    while (temp > 0) {
      int digit = temp % 10;
      sum += pow(digit, digits).toInt();
      temp ~/= 10;
    }
    return sum == number.abs(); 
  }

  bool isSquareFree(int number) {
    number = number.abs();
    if (number == 0) return false;
    for (int i = 2; i * i <= number; i++) {
      if (number % (i * i) == 0) return false;
    }
    return true;
  }

  bool isHarshad(int number) {
    number = number.abs();
    int sum = number.toString().split('').map(int.parse).reduce((a, b) => a + b);
    if (sum == 0) return false;
    return number % sum == 0;
  }

  String toRoman(int number) {
    if (number <= 0 || number > 3999) return "Invalid";

    final Map<int, String> romanMap = {
      1000: 'M', 900: 'CM', 500: 'D', 400: 'CD',
      100: 'C', 90: 'XC', 50: 'L', 40: 'XL',
      10: 'X', 9: 'IX', 5: 'V', 4: 'IV', 1: 'I',
    };

    String result = '';
    romanMap.forEach((value, symbol) {
      while (number >= value) {
        result += symbol;
        number -= value;
      }
    });

    return result;
  }

  String numberToWords(int number) {
    if (number == 0) return "Zero";
    if (number < 0) return "Minus ${numberToWords(-number)}";

    final originalNumber = number;

    final List<String> units = [
      "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"
    ];
    final List<String> teens = [
      "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen",
      "Sixteen", "Seventeen", "Eighteen", "Nineteen"
    ];
    final List<String> tens = [
      "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    ];
    final List<String> thousands = [
      "",
      "Thousand",
      "Million",
      "Billion",
      "Trillion",
      "Quadrillion",
      "Quintillion",
    ];

    String convertLessThan1000(int n) {
      String str = '';
      if (n >= 100) {
        str += '${units[n ~/ 100]} Hundred ';
        n %= 100;
      }
      if (n >= 20) {
        str += '${tens[n ~/ 10]} ';
        n %= 10;
      } else if (n >= 10) {
        str += '${teens[n - 10]} ';
        n = 0;
      }
      if (n > 0) str += '${units[n]} ';
      return str.trim();
    }

    int chunkCount = 0;
    String result = '';
    while (number > 0) {
      int chunk = number % 1000;
      if (chunk != 0) {
        String chunkWords = convertLessThan1000(chunk);
        if (chunkCount >= thousands.length) {
          return originalNumber.toString();
        }

        if (thousands[chunkCount].isNotEmpty) {
          chunkWords += ' ${thousands[chunkCount]}';
        }
        result = '$chunkWords $result';
      }
      number ~/= 1000;
      chunkCount++;
    }

    return result.trim();
  }

  List<int> getFactors(int number) {
    number = number.abs();
    if (number == 0) return [];
    List<int> factors = [];
    for (int i = 1; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        factors.add(i);
      }
    }
    factors.add(number);
    return factors;
  }

  String getSpecialFact(int number) {
    final Map<int, String> specialFacts = {
      0: "Zero is the only number that is neither positive nor negative.",
      1: "One is the start of everything and symbolizes unity.",
      2: "2 is the only even prime number.",
      3: "Three is often seen as a number of harmony, wisdom, and understanding.",
      4: "In some Asian cultures, 4 is considered unlucky because it sounds like 'death'.",
      7: "Seven is often called a lucky number and appears in many mythologies.",
      8: "In Chinese culture, 8 is considered the luckiest number.",
      9: "Nine is associated with magic and completion in many traditions.",
      10: "Ten symbolizes completeness, as in a perfect score or 10 fingers.",
      11: "11:11 is considered a magical or 'angel' number in numerology.",
      13: "Thirteen is seen as unlucky in Western cultures, especially on Fridays.",
      17: "In Italy, 17 is considered unlucky due to Roman numeral associations.",
      18: "In Judaism, 18 symbolizes 'chai' or life.",
      23: "Michael Jordan famously wore the number 23 jersey.",
      27: "27 Club refers to famous musicians who died at age 27.",
      33: "33 is regarded as a Master Number in numerology.",
      36: "36 is twice the 'chai' (18) in Jewish tradition, representing double life.",
      42: "According to The Hitchhiker's Guide to the Galaxy, it's the answer to life, the universe, and everything.",
      69: "69 is known for its symmetrical shape and is popular in internet culture.",
      88: "In Chinese culture, 88 symbolizes double fortune.",
      99: "Wayne Gretzky wore 99; it's retired league-wide in the NHL.",
      100: "100 is often used to symbolize perfection or a full score.",
      108: "108 is sacred in Hinduism and Buddhism (e.g., beads in a mala).",
      420: "420 is a symbol for cannabis culture and is celebrated on April 20.",
      520: "In Chinese, '520' sounds like 'I love you'.",
      666: "666 is known as the 'number of the beast' in Christianity.",
      786: "In Islam, 786 is often used to represent the phrase 'Bismillah'.",
      911: "911 is the emergency number in the US and symbolic of the 9/11 attacks.",
      1000: "A thousand often represents a huge or complete quantity.",
      1001: "The number of tales told in *One Thousand and One Nights* (Arabian Nights).",
    };

    return specialFacts[number] ?? "No special fact available for this number.";
  }

  Map<String, String> getNumberInfo(int number) {
    final isEven = number % 2 == 0;
    final primeStatus = isPrime(number) ? "Prime" : "Not Prime";
    final compositeStatus = isComposite(number) ? "Composite" : "Not Composite";
    final absValue = number.abs();
    final sqrtValue = number < 0 ? "NaN" : sqrt(number).toStringAsFixed(4);
    final wordForm = numberToWords(number);
    final roman = toRoman(number);
    final binary = number.toRadixString(2);
    final octal = number.toRadixString(8);
    final hex = number.toRadixString(16).toUpperCase();
    final factors = number == 0 ? "All integers" : getFactors(number).join(", ");
    final fact = getSpecialFact(number);
    final isFib = isFibonacci(number) ? "Yes" : "No";
    final isPalin = isPalindrome(number) ? "Yes" : "No";
    final isArm = isArmstrong(number) ? "Yes" : "No";
    final isSq = isPerfectSquare(number) ? "Yes" : "No";
    final isCb = isPerfectCube(number) ? "Yes" : "No";
    final isHarshadNum = isHarshad(number) ? "Yes" : "No";
    final digitCount = number.abs().toString().length;
    final sumOfDigits = number.abs().toString().split('').map(int.parse).reduce((a, b) => a + b);
    final productOfDigits = number.abs().toString().split('').map(int.parse).reduce((a, b) => a * b);
    final reverse = number.toString().split('').reversed.join();
    final sign = number == 0 ? "Zero" : (number > 0 ? "Positive" : "Negative");
    final expForm = number.toStringAsExponential();
    final squareFree = isSquareFree(number.abs()) ? "Yes" : "No";
    final ascii = number >= 0 && number <= 127 ? String.fromCharCode(number) : "Not a valid ASCII code";

    return {
      "Number": number.toString(),
      "Sign": sign,
      "In Words": wordForm,
      "Roman Numeral": roman,
      "Odd/Even": isEven ? "Even" : "Odd",
      "Prime": primeStatus,
      "Composite": compositeStatus,
      "Absolute Value": absValue.toString(),
      "Square": (number * number).toString(),
      "Cube": (number * number * number).toString(),
      "Square Root": sqrtValue,
      "Perfect Square": isSq,
      "Perfect Cube": isCb,
      "Fibonacci Number": isFib,
      "Palindrome": isPalin,
      "Armstrong Number": isArm,
      "Harshad Number": isHarshadNum,
      "Square-Free": squareFree,
      "Binary": binary,
      "Octal": octal,
      "Hexadecimal": hex,
      "Digit Count": digitCount.toString(),
      "Sum of Digits": sumOfDigits.toString(),
      "Product of Digits": productOfDigits.toString(),
      "Reverse": reverse,
      "Exponential Notation": expForm,
      "ASCII Character": ascii,
      "Factors": factors,
      "Fun Fact": fact,
    };
  }
}
