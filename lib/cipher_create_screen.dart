import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'cipher_screen.dart';

class CipherCreateScreen extends StatelessWidget {
  CipherCreateScreen({Key key}) : super(key: key);

  final TextEditingController _cipherTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Center(
                child: Container(
      constraints: BoxConstraints.expand(),
      decoration:
          BoxDecoration(image: DecorationImage(image: new AssetImage('assets/images/sky.jpg'), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            child: new TextField(
              decoration: InputDecoration(
                  hintText: "Enter your cipher key",
                  fillColor: Colors.purpleAccent,
                  filled: true,
                  border: InputBorder.none),
              controller: _cipherTextController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          SizedBox(height: 100),
          new InkWell(
            onTap: () => _gotoCipher(context),
            child: new Container(
              width: 300,
              height: 50.0,
              decoration: new BoxDecoration(
                color: Colors.purpleAccent,
                border: new Border.all(color: Colors.white, width: 2.0),
                borderRadius: new BorderRadius.circular(20.0),
              ),
              child: new Center(
                child: new Text(
                  'Create my Cipher',
                  style: new TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }

  _gotoCipher(BuildContext context) {
    if (_cipherTextController.text.isEmpty) {
      FocusScope.of(context).nextFocus();
    } else {
      Navigator.push(context, PageTransition(child: CipherScreen(int.tryParse(_cipherTextController.text) ?? 31337), type: PageTransitionType.leftToRight));
    }
  }
}
