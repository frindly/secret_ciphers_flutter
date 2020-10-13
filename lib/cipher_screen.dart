import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:math';

class CipherScreen extends StatefulWidget {
  CipherScreen(this.cipherKey, {Key key}) : super(key: key);

  final int cipherKey;

  @override
  _CipherScreenState createState() => _CipherScreenState(cipherKey);
}

class _CipherScreenState extends State<CipherScreen> {
  _CipherScreenState(this.cipherKey) : super();
  final int cipherKey;
  String cipheredText = "";
  bool cipherSet = false;
  Random random = new Random(24587);
  bool encoding = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: new AssetImage('assets/images/mountain.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your phrase to be ciphered",
                    hintStyle: TextStyle(color: Color(0xffddffdd)),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: _updateCipherText,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Switch(
                          value: encoding,
                          onChanged: (val) => { _setEncoding(val)},
                        ),
                        Text(encoding ? "encoding" : "decoding")
                      ],
                    )),
                Divider(
                  height: 24,
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: (cipheredText.isNotEmpty)
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.5625,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: new AssetImage('assets/images/scroll.png'), fit: BoxFit.contain)),
                            child: Center(
                                child: Text(cipheredText, style: TextStyle(fontFamily: "Archaic", fontSize: 24))))
                        : SizedBox())
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        tooltip: 'Change Cipher Key',
        child: Icon(Icons.arrow_back),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();
    _updateCipherFromKey();
  }

  void _setEncoding(bool newEncoding) {
    setState(() {
      encoding = newEncoding;
    });
  }

  void _updateCipherText(String clearText) {
    setState(() {
      cipheredText = doCipher(clearText);
    });
  }

  var cipher = {"": ""};
  var decipher = {"": ""};
  final cipherSource = {
    "A": "Z",
    "B": "Y",
    "C": "X",
    "D": "W",
    "E": "V",
    "F": "U",
    "G": "T",
    "H": "S",
    "I": "R",
    "J": "Q",
    "K": "P",
    "L": "O",
    "M": "N",
    "N": "M",
    "O": "L",
    "P": "K",
    "Q": "J",
    "R": "I",
    "S": "H",
    "T": "G",
    "U": "F",
    "V": "E",
    "W": "D",
    "X": "C",
    "Y": "B",
    "Z": "A"
  };

  String doCipher(String clearText) {
    var ciphered = "";
    random = new Random(24587);
    var cipherToUse = encoding ? cipher : decipher;
    if (!encoding) {
      clearText = clearText.toUpperCase().replaceAll("PZBOM", "PZBORM");
    }
    for (var char in clearText.characters) {
      if (cipher.containsKey(char.toString().toUpperCase())) {
        ciphered += cipherToUse[char.toString().toUpperCase()];
      } else {
        ciphered += char.toString();
      }
    }
    if (encoding) {
      ciphered = ciphered.replaceAll("PZBORM", "PZBOM");
    }
    return ciphered;
  }

  void _updateCipherFromKey() {
    cipher = HashMap.from(cipherSource);
    if (cipherKey != 24587) {
      for (int i = 0; i < 23; i++) {
        _swapCiphers(random.nextInt(cipherSource.length), random.nextInt(cipherSource.length));
      }
      for (int i = 0; i < cipherKey % 7367; i++) {
        _swapCiphers(random.nextInt(cipherSource.length), random.nextInt(cipherSource.length));
      }
    }
    decipher.clear();
    for (var key in cipher.keys) {
      decipher[cipher[key]] = key;
    }
  }

  void _swapCiphers(int a, int b) {
    var key1 = cipher.keys.elementAt(a % cipher.keys.length);
    var key2 = cipher.keys.elementAt(b % cipher.keys.length);
    var temp = cipher[key1];
    cipher[key1] = cipher[key2];
    cipher[key2] = temp;
  }
}
