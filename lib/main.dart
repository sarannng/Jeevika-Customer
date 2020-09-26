import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prakrati_datacollection/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeevika',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _number= TextEditingController();
  final _name= TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

final FirebaseMessaging _messaging= FirebaseMessaging();
  @override
  void initState() { 
    super.initState();
   _messaging.getToken().then((value) => print(value)); 
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomPadding: false,
       
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color:  Color.fromRGBO(115, 101, 101,  1),
                    // gradient: LinearGradient(
                    //     colors: [Colors.orange[200], Colors.orange[100]]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      // bottomLeft: Radius.circular(60),
                      // bottomRight: Radius.circular(60)
                    )),
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Login here!',
                        style: GoogleFonts.raleway(textStyle: TextStyle(
                            fontFamily: 'lato',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 74, 173, 0.7)),)
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(225, 97, 27, 0.3),
                              blurRadius: 5,
                              offset: Offset(10, 10),
                            )
                          ],
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                //padding: EdgeInsets.all(4),

                                child: TextField(
                                  controller: _number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter email or phone',
                                    border: InputBorder.none,
                                    filled: true,
                                    // fillColor: Color.fromRGBO(199, 193, 193, 1),
                                    fillColor:
                                        Color.fromRGBO(255, 199, 115, 0.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(225, 97, 27, 0.3),
                                offset: Offset(10, 10),
                                blurRadius: 5)
                          ],
                        ),
                        child: Container(
                          //padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: _name,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromRGBO(255, 199, 115, 0.2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Text(
                      //     'Forgot Password',
                      //     style: TextStyle(
                      //       color: Colors.black38,
                      //     ),
                      //     textAlign: TextAlign.right,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            child: RaisedButton(
                              onPressed: () async {

                if(_name != null && _number != null){
                                    Firestore.instance.collection('loginInfo').document('${Timestamp.now()}').setData({
                                  'number/email': _number.text,
                                  'name': _name.text,
                                  'time': '${Timestamp.now().toDate()}'

                                 });
                }

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Home()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.orange[900],
                                        Colors.orange[800],
                                        Colors.orange[400],
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 150.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(63, 125, 59, 1),
                     gradient: LinearGradient(
            colors: [
              Colors.orange[900],
              Colors.orange[800],
              Colors.orange[400],

            ],

          ),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(500))),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/logo3.png',
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.height / 3,
                              ),
                              // Text(
                              //   'प्रकृति',
                              //   // style: GoogleFonts.lato(
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize:
                              //           MediaQuery.of(context).size.height / 19,
                              //       fontWeight: FontWeight.bold),
                              // )
                            ],
                          ),
                        ],
                      ))),
            ),
          ],
        )));
  }
}
