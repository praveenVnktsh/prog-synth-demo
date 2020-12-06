import 'dart:convert';

// import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progsynth/constants.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';
import 'widgets/navbar.dart';
import 'utils/responsiveLayout.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: 'Flutter Landing Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.grey),
          )),
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFF8FBFF),
        Color(0xFFFCFDFD),
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[NavBar(), Body()],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(),
      smallScreen: SmallChild(),
    );
  }
}

class LargeChild extends StatefulWidget {
  LargeChild({Key key}) : super(key: key);

  @override
  _LargeChildState createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild> {
  var _exampleCode =
      "num = 7\r\nfactorial = 1\r\nif num < 0:\r\n   print(\"Sorry, factorial does not exist for negative numbers\")\r\nelif num == 0:\r\n   print(\"The factorial of 0 is 1\")\r\nelse:\r\n   for i in range(1,num + 1):\r\n       factorial = factorial*i\r\n   print(\"The factorial of\",num,\"is\",factorial)";
  var buttons = [false, true, false];
  var loading = false;
  final textcontroller = TextEditingController();
  var active = 1;
  var forward = false;

  void request() async {
    loading = !loading;
    setState(() {});
    var response = await http
        .post(pingUrl, body: {'src': descriptions[active], 'id': active});

    _exampleCode = json.decode(response.body)['form']['name'];
    loading = !loading;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    return SizedBox(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: .45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            RaisedButton(
                              onPressed: () {
                                active = 1;
                                textcontroller.clear();
                                setState(() {});
                              },
                              textColor: Colors.white,
                              color:
                                  active == 1 ? primaryColor : secondaryColor,
                              padding: const EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                                child: Text(
                                  "NAPS",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            RaisedButton(
                              onPressed: () {
                                active = 2;
                                textcontroller.clear();
                                setState(() {});
                              },
                              textColor: Colors.white,
                              color:
                                  active == 2 ? primaryColor : secondaryColor,
                              padding: const EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                                child: Text(
                                  "Algolisp",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // CustomSwitch(
                            //   activeColor: primaryColor,
                            //   value: forward,
                            //   onChanged: (value) {
                            //     print("VALUE : $value");
                            //     setState(() {
                            //       // status = value;
                            //       forward = value;
                            //     });
                            //   },
                            // ),
                          ]),
                    ),
                    Container(
                      height: 100,
                      width: 700,
                      child: TextField(
                        controller: textcontroller,
                        minLines: 4,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(color: Colors.black87),
                        onChanged: (content) {
                          descriptions[active] = content;
                        },
                        onEditingComplete: () {
                          request();
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 1.0),
                            ),
                            hintText: descriptions[active]),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: 40,
                      child: Transform.rotate(
                        angle: -90 * 3.14 / 180,
                        child: loading == true
                            ? CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    primaryColor),
                                backgroundColor: secondaryColor,
                              )
                            : IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () async {
                                  request();
                                },
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        // height: 300,
                        width: 700,
                        constraints: BoxConstraints(
                          minHeight: 200,
                        ),
                        color: Colors.grey.withAlpha(25),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                            child: SelectableText(_exampleCode))),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        Clipboard.setData(
                            new ClipboardData(text: _exampleCode));
                      },
                      textColor: Colors.white,
                      color: secondaryColor,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                        child: Text(
                          "Copy to Clipboard",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: .55,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                      text: "AutoCoder Pro Max",
                      style: GoogleFonts.montserrat(
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "A Novel Feedback Based Training System for Deep Code Generation",
                        style: GoogleFonts.montserrat(
                            // textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black87
                            // fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Text(
                          "Harsh Patel • Praveen Venkatesh • Shivam Sahni • Varun Jain",
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SmallChild extends StatelessWidget {
  // smaller window
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
