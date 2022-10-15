import 'package:dio/dio.dart';

import 'character.dart';

class CharacterController {
  List<Character> characters = [];
  String? error;
  Future<void> getAllCharacter() async {
    final response =
        await Dio().get('https://www.breakingbadapi.com/api/characters');
    print(response.data);
    try {
      for (var i in response.data) {
        characters.add(Character(
            name: i['name'],
            image: i['img'],
            id: i['char_id'],
          ),
        );
      }
      print(response.data);
    } catch (e) {
      error = 'Something went wrong';
      print(e);
    }
  }
}


