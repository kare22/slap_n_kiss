import 'package:flutter/material.dart';

Map<String, Map> optionsMap = {
  'Vanilla': {
    'options': [
      'Kiss and caress neck',
      'Hug and cuddle',
      'Hold hands and gaze into each other\'s eyes',
      'Massage and stroke back',
      'Share a sensual shower or bath',
      'Give a gentle massage and whisper sweet nothings'
    ],
    'color': Colors.purple,
    'background': 'background_1.jpg',
  },
  'Sensual': {
    'options': [
      'Kiss and lick lips',
      'Nibble and suck on earlobes',
      'Caress and fondle thighs',
      'Lick and suck nipples',
      'Stroke and tease genitals',
      'Playfully bite and spank butt',
    ],
    'color': Colors.deepPurple,
    'background': 'background_2.jpg',
  },
  'Playful': {
    'options': [
      'Blow and nibble on neck',
      'Tickle and tickle each other\'s sides',
      'Pinch and pull on nipples',
      'Give a lap dance and strip tease',
      'Take turns being dominant and submissive',
      'Play a round of truth or dare',
    ],
    'color': Colors.pink,
    'background': 'background_3.jpg',
  },
};

class Options {
  static List<String> getOptions() {
    return optionsMap.keys.toList();
  }

  static MaterialColor getOptionColor(String key) {
    optionsMap[key] ??= {};
    return optionsMap[key]!['color']!;
  }

  static List<String> getOptionData(String key) {
    optionsMap[key] ??= {};
    return optionsMap[key]!['options']!;
  }

  static String getOptionBackground(String key) {
    optionsMap[key] ??= {};
    return 'assets/' + optionsMap[key]!['background']!;
  }
}
