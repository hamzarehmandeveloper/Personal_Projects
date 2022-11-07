import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


void main() {
  runApp(Xylophone());
}

//layout ya interface Stateless
class Xylophone extends StatelessWidget {
  //const Xylophone({Key? key}) : super(key: key);
  //AudioPlayer audioPlugin = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body:Xylo(),
      ),
    );
  }
}

//like dice app variables values store state maintain statfull
class Xylo extends StatefulWidget {
  const Xylo({Key? key}) : super(key: key);

  @override
  State<Xylo> createState() => _XyloState();
}
class _XyloState extends State<Xylo> {
  void SoundPlay(int num){
    AssetsAudioPlayer.newPlayer().open(
      Audio("Assests/note$num.wav"),
    );
  }
  Expanded  myButton(int num, Color color){
    return Expanded(
      child: TextButton(
        child: Text("",),
        onPressed: (){
          SoundPlay(num);
        },
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
      ),);
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        myButton(1,Colors.red),
        myButton(2,Colors.green),
        myButton(3,Colors.blue),
        myButton(4,Colors.orange),
        myButton(5,Colors.deepPurple),
        myButton(6,Colors.pinkAccent),
        myButton(7,Colors.yellow),
      ],
    );
  }
}




