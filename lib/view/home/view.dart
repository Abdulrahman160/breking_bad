import 'package:breking_bad/login/view.dart';
import 'package:breking_bad/wight/controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../characters__card/view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;
  CharacterController characterController = CharacterController();

  @override
  void initState() {
    characterController.getAllCharacter().then(((value) {
      isLoading = false;
      setState(() {});
    }));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.remove('token');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ),
              );
            },
            icon: Icon(Icons.login),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: characterController.error != null
            ? Center(
                child: Text(characterController.error!),
              )
            : isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemCount: characterController.characters.length,
                    itemBuilder: (context, index) => CharacterCard(
                      character: characterController.characters[index],
                    ),
                  ),
      ),
    );
  }
}
