import 'dart:math';

import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Import Images
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky= AssetImage('images/sadFace.png');

  //Get an array
  List<String> itemArray;
  int luckyNumber;
  int count = 1;
  int attempt = 5;
  String message = "";

  //init array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
    setState(() {
      this.message = "You have only 5 attempts";
    });
  }

  void generateRandomNumber(){
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //define a getImage method
  AssetImage getImage(int index){
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

//GameOver Method
  gameOver(){
    showAll();
    setState(() {
      this.message = "Sorry!!! Game Over";
    });
  }


  //playGame Method
  playGame(int index){
    
      if(luckyNumber == index){
        setState(() {
          itemArray[index] = "lucky";
          this.message = "Yup, You Won!!!!!";
        }
        );
        this.showAll();
      }else{
        attempt --;
        setState(() {
          itemArray[index] = "unlucky";
          this.message = "You have only $attempt attempts";
        });
        count++;
      }

      if(count == 6){
        gameOver();
      }
  }

  //ShowAll method
  void showAll(){
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //ResetAll method
  void resetAll(){
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      count = 0;
      attempt = 5;
    });
    this.message = "You have only 5 attempts";
    generateRandomNumber();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
                ),
              itemCount: itemArray.length, 
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){
                    this.playGame(i);
                  },
                  child: Image(image: this.getImage(i)),
                  ),
              ),  
            ), 
            ),
            Container(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                this.message,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: (){
                  this.showAll();
                },
                child: Text("Show All", style: TextStyle(color: Colors.white, fontSize: 20.0,),),
                color: Colors.pink,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: RaisedButton(
                onPressed: (){
                  this.resetAll();
                },
                child: Text("Reset Button", style: TextStyle(color: Colors.white, fontSize: 20.0,),),
                color: Colors.pink,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
            ),
            Container(
              child: RaisedButton(
                onPressed: (){
                  this.resetAll();
                },
                child: Text("LearnCodeonline.in", style: TextStyle(color: Colors.white, fontSize: 16.0,),),
                color: Colors.black,
                padding: EdgeInsets.all(20.0),
                ),
            ),
        ],
      ),
    );
  }
}