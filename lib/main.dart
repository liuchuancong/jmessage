import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter D546Home Page'),
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
  static final openJmessage = const MethodChannel('chat/jmessage');
  final Stream<String> stream = new Stream.empty();
  var message;
  Future openLogin() async {
    message = await openJmessage.invokeMethod('openJmessage');
    setState(() {
      this.message = message;
      print(message);
    });
  }
  Future<String> initJmessage () async{
   return await openJmessage.invokeMethod('initJmessage');
  }
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      Stream<String> stream = new Stream.fromFuture(initJmessage());
      stream.listen((value){
        if(value == "success"){
          openLogin();
        }
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(builder: (BuildContext context,snopshot){
        if(snopshot.hasData){
          return Container();
        }else{
          return Center(
            child: new CircularProgressIndicator(),
          );
        }
      }
      )
    );
  }
}
