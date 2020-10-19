import 'package:flutter/material.dart';
import 'leaderboard.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  List<dynamic> jsonResponse = [];
  double _width = 0;
  double _height = 0;
  bool flag = false;
  int count = 0;

  Timer x;
  change(){
    if(count == 6){
      x.cancel();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Leaderboard(jsonResponse: jsonResponse,)));
    }
    setState(() {
      _width = flag?MediaQuery.of(context).size.width/4:0;
      _height = flag?MediaQuery.of(context).size.height/4:0;
      flag = flag?false:true;
      count = count+1;
    });

  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    x = Timer.periodic( Duration(seconds: 2),(timer) {
      change();
      print(count);
    });
    parse();

  }

  parse() async{
    String jsonString = await rootBundle.loadString("assets/Report.json");
    setState(() {
      jsonResponse = jsonDecode(jsonString);
    });
    //print(jsonResponse);
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "LOGO",

          child: AnimatedContainer(

            curve: Curves.ease,
            width: _width,
            height: _height,
            decoration: BoxDecoration(



//          borderRadius: Border,
                image: DecorationImage(image: AssetImage("images/logo.png"))
            ),
            duration: Duration(seconds: 2),
          ),
          ),
        ),
      );
  }
}

