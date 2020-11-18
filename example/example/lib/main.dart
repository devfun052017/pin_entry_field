import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_field/pin_entry_field.dart';
import 'package:pin_entry_field/pin_entry_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PinEntryField(
              fieldCount: 4,
              fieldWidth: 50,
              height: 60,
              fieldStyle: PinEntryStyle(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                  fieldBackgroundColor: Colors.orangeAccent,
                  fieldBorder: Border.all(
                    color: Colors.pink,
                    width: 2,
                  ),
                fieldBorderRadius: BorderRadius.circular(10),
                fieldPadding: 20
              ),
            )
          ],
        ),
      ),
    );
  }
}
