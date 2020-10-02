import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rsa_calculator/components/box.dart';
import 'package:rsa_calculator/components/button.dart';
import 'package:rsa_calculator/components/custom-text.dart';
import 'package:rsa_calculator/models/rsa.dart';

import 'constants.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // validate form inputs
  final _primeformKey = GlobalKey<FormState>();
  final _valueformKey = GlobalKey<FormState>();

  //all variables
  List<BigInt> eList;
  Rsa rsa;
  BigInt p, pTmp, q, qTmp, n, phiN, eTmp, d, e;
  String messageTmp, encodedMessage, cypherTmp, originalMessage;

  // checks if P and Q are prime
  bool isPrime(BigInt x) {
    if (x <= BigInt.one) return false;
    for (var i = BigInt.two; i * i <= x; i += BigInt.one)
      if (x % i == BigInt.zero) return false;
    return true;
  }

// The UI section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      backgroundColor: bgcolor,
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "© Monayam Reshad, ID # 16701080, dept. of CSE, CU",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Box(
                title: "Enter two prime numbers, P and Q (P * Q > 127)",
                childWidgets: Form(
                  key: _primeformKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 6.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) => pTmp = BigInt.parse(val),
                          validator: (val) => !isPrime(BigInt.parse(val))
                              ? "pleas enter a prime number."
                              : null,
                          decoration: inputDecoration.copyWith(
                            labelText: "Enter a value for P",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 6.0),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) => qTmp = BigInt.tryParse(val),
                            validator: (val) => !isPrime(BigInt.parse(val))
                                ? "pleas enter a prime number."
                                : null,
                            decoration: inputDecoration.copyWith(
                                labelText: "Enter a value of Q")),
                      ),
                      Button(onPressed: () {
                        if (_primeformKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            rsa = Rsa();
                            p = pTmp;
                            q = qTmp;
                            rsa = Rsa(p: p, q: q);
                            n = rsa.getN;
                            phiN = rsa.getPhiN;

                            // phi_n = (p - BigInt.one) * (q - BigInt.one);
                            eList = rsa.generateEList();
                          });
                        }
                      }),
                    ],
                  ),
                ),
              ),
              CustomText(
                  first: "Calculated value of N = P * Q",
                  second: n == null ? 0 : n),
              CustomText(
                first: "Calculated value of φ(N) = (P - 1) * (Q - 1)",
                second: phiN == null ? 0 : phiN,
              ),
              CustomText(
                  first: "Selectable values of e",
                  second: eList == null ? 0 : "$eList"),
              Box(
                title: "Select a value of e",
                childWidgets: Form(
                  key: _valueformKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 6.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) => eTmp = BigInt.parse(val),
                          validator: (val) => !eList.contains(BigInt.parse(val))
                              ? 'please check if the value is in the list'
                              : null,
                          decoration: inputDecoration.copyWith(
                            labelText: "Enter a value of e",
                          ),
                        ),
                      ),
                      Button(
                        onPressed: () {
                          if (_valueformKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();
                            setState(
                              () {
                                rsa.e = eTmp;
                                e = rsa.e;
                                d = rsa.getD;
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomText(
                first:
                    "Calculated value of e\n(1 < e < φ(N) and e is co-prime with N, φ(N))",
                second: e == null ? 0 : e,
              ),
              CustomText(
                first: "Calculated value of d\n1 / e * (mod φ(N))",
                second: d == null ? 0 : d,
              ),
              CustomText(
                first: "Public key (e, n)",
                second: e == null ? 0 : "($e, $n)",
              ),
              CustomText(
                first: "Private key (d, n)",
                second: d == null ? 0 : "($d, $n)",
              ),
              Box(
                title: "Encryption",
                childWidgets: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) => messageTmp = value,
                        decoration: inputDecoration.copyWith(
                            labelText: "Enter your message"),
                      ),
                    ),
                    Button(onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(
                        () {
                          rsa.message = messageTmp;
                          encodedMessage = rsa.getEncodedMessage();
                          rsa.encodedMessage = encodedMessage;
                        },
                      );
                    }),
                  ],
                ),
              ),
              CustomText(
                first: "Generated cypher",
                second: encodedMessage == null ? 0 : encodedMessage,
              ),
              Box(
                title: "Decryption",
                childWidgets: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) => cypherTmp = value,
                        decoration: inputDecoration.copyWith(
                          labelText: "Enter your cypher code",
                        ),
                      ),
                    ),
                    Button(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(
                          () {
                            rsa.encodedMessage = cypherTmp;
                            originalMessage = rsa.getOriginalMessage();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomText(
                first: "Original Code",
                second: originalMessage == null ? 0 : originalMessage,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
