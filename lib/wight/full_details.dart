import 'character.dart';

class FullDetails extends Character {

  final String nickname;
  final String birthday;
  final String occupation;
  final String status;
  final String portrayed;

  FullDetails({
    required super.id,
    required super.name,
  required super.image,
  required this.birthday,
  required this.nickname,
  required this.occupation,
  required this.portrayed,
  required this.status,
});

}