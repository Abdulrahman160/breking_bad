import 'package:breking_bad/wight/full_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CharacterDetailes extends StatefulWidget {
  const CharacterDetailes({Key? key, required this.characId}) : super(key: key);
  final int? characId;
  @override
  State<CharacterDetailes> createState() => _CharacterDetailesState();
}

class _CharacterDetailesState extends State<CharacterDetailes> {
  bool isLoading = true;
FullDetails? fullDetails;
  @override
  void initState()  {
    getCharacters();

    super.initState();
  }

  void getCharacters() async {
    final response = await Dio().get(
      'https://www.breakingbadapi.com/api/characters/${widget.characId}',
    );
    print(widget.characId);
    print(response.data);
    fullDetails=FullDetails(
      birthday: response.data[0]['birthday'],
      id: response.data[0]['char_id'],
      image: response.data[0]['img'],
      nickname: response.data[0]['nickname'],
      name: response.data[0]['name'],
      occupation: response.data[0]['occupation'].toString(),
      portrayed: response.data[0]['portrayed'],
      status: response.data[0]['status'],
    );
    isLoading=false;
    setState(() {});
  }

  Widget build(BuildContext context) {
    print('characId : ${widget.characId}');
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: [
            Image.network(fullDetails!.image),
             const Text(
              'Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(fullDetails!.name),
            const Text('Nickname:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
             Text(fullDetails!.nickname),
            const Text('Birthday:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
             Text(fullDetails!.birthday),
            const Text('Occupation:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
             Text(fullDetails!.occupation),
            const Text('Status:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
             Text(fullDetails!.status),
            const Text('Portrayed:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
             Text(fullDetails!.portrayed),
          ],
        ),
      ),
    );
  }
}
