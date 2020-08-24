import 'dart:math';

class RandomTextGenerator {
  static var randomQuotes = [
    'I have always believed that each man makes his own happiness and is responsible for his own problems.',
    'When we have respect for ourselves and others, we gravitate towards connections that encourage that.',
    'Anger is the ultimate destroyer of your own peace of mind',
    'If more of us valued food and cheer and song above hoarded gold, it would be a merrier world.',
    'A man can fail many times, but he isn\'t a failure until he begins to blame somebody else.',
    'There\'s an important difference between giving up and letting go.'
  ];

  static randomizeQuote() {
    if (randomQuotes == null) return null;
    Random quote = Random();
    int quoteslength = randomQuotes.length - 1;
    int newQuote = quote.nextInt(quoteslength);

    return randomQuotes[newQuote];
  }
}

class RandomToastText {
  static var randomToastText = [
    'Just saved your font buddehh',
    'Mada mada dane. - Echizon Ryoma',
    'This app has been made by Defigners',
    'Wauwzers I just saved another font',
    'Cat\'s in the back *bag',
    'Got \'em',
    'Oehh, shiny',
    'Yeah, Niels(from Defigners) didn\'t make this font',
    'One font to rule them all!',
    'Jochem(from Defigners) loves his "Takenbord"'
  ];

  static randomizeToastText() {
    if (randomToastText == null) return null;
    Random text = Random();
    int textLength = randomToastText.length - 1;
    int newText = text.nextInt(textLength);

    return randomToastText[newText];
  }
}
