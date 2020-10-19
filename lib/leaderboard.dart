import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';





class Leaderboard extends StatefulWidget {

  @override
  _LeaderboardState createState() => _LeaderboardState();

  Leaderboard({this.jsonResponse});
  List<dynamic> jsonResponse;
}

class _LeaderboardState extends State<Leaderboard> {

  List<Widget> _x(jsonResponse){

    List<Widget> a = [];
    List b = [];

    for(int i=0;i<jsonResponse.length-1;i++){
      b.add([jsonResponse[i]["Email"],jsonResponse[i]["Total"]]);
    }



    for(int i=0;i<b.length-1;i++){
      a.add(Players(name: b[i][0], noOfQuests: b[i][1]>1?(b[i][1] - 1).toString():"0", playerIcon: Icons.add,position: i+1,));
    }


    return a;
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: Hero(tag: "LOGO",child: Image(image: AssetImage("images/logo.png"))),
      title: Text("30 Days Of Google Cloud Leaderboard",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("Pos",textAlign:TextAlign.center,style: TextStyle(fontSize: MediaQuery.of(context).size.width/40,color: Colors.black,fontWeight: FontWeight.w600),)),
      )],
      backgroundColor: Colors.white,
    ),
    backgroundColor: Colors.white60,
    body: ListView(
      children: _x(widget.jsonResponse),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed:(){
        String day = DateFormat('d/M/y').format(DateTime.now());
        final birthday = DateTime(2020, 11, 5);
        final date2 = DateTime.now();
        int difference = birthday.difference(date2).inDays;
        print(difference);

        Alert(context: context, title: "$difference Days Left!!!", desc: "Complete atleast 1 track before 5th November!").show();
      },
      tooltip: 'Time Left',
      child: Icon(Icons.timer),
    ),
  );
  }
}

class Players extends StatelessWidget {
  const Players({
    Key key,
    @required this.name,
    @required this.noOfQuests,
    @required this.playerIcon,
    @required this.position
  }) : super(key: key);
  final IconData playerIcon;
  final String name;
  final String noOfQuests;
  final int position;


  double Size(multiplier,context){
    if(MediaQuery.of(context).size.width < MediaQuery.of(context).size.height){

      return MediaQuery.of(context).size.width/multiplier;
    }else if(MediaQuery.of(context).size.width > MediaQuery.of(context).size.height){
      return MediaQuery.of(context).size.height/multiplier;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events,color: position<51?Colors.amber:Colors.grey, ),
          ],
        ),
        title: Text(name,style: TextStyle(fontSize: Size(17,context)),),
        subtitle: Text("No of Quests Completed "+noOfQuests,style: TextStyle(fontSize: Size(25,context),)),
        trailing: Text(position.toString(),style: TextStyle(fontSize: Size(25,context),fontWeight: FontWeight.bold),),
      ),
    );
  }
}
