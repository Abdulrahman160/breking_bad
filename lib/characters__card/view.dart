import 'package:breking_bad/characters_details/view.dart';
import 'package:breking_bad/wight/character.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character,})
      : super(key: key);
final Character character;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CharacterDetailes(characId: character.id),));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
              ),
            ]),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    12,
                  ),
                ),
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Text(
              character.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
