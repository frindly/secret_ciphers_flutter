import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'cipher_create_screen.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: new AssetImage('assets/images/beach.jpg'), fit: BoxFit.cover)),
                    child: Center(
                      child: new InkWell(
                        onTap: () => _gotoCipherCreate(context),
                        child: new Container(
                          width: 200,
                          height: 200.0,
                          decoration: new BoxDecoration(
                            color: Colors.purpleAccent,
                            border: new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(200.0),
                          ),
                          child: new Center(
                            child: new Text(
                              'Start your Cipher',
                              style: new TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )))));
  }

  _gotoCipherCreate(BuildContext context) {
   Navigator.push(
    context,
    PageTransition(child: CipherCreateScreen(), type: PageTransitionType.fade)    
  );
  }
}
