import 'package:flutter/material.dart';
import 'container.dart';
import 'IconText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


const activecolor = Color(0xFF1D1E33);
const deactivecolor = Color(0xFF111328);

enum gender{
  male,
  female
}

class inputpage extends StatefulWidget {
  const inputpage({Key? key}) : super(key: key);

  @override
  State<inputpage> createState() => _inputpageState();
}

class _inputpageState extends State<inputpage> {
  Color malecolor=deactivecolor;
  Color femalecolor=deactivecolor;

  void updatecolor(gender gendertype){
    if(gendertype==gender.male){
      malecolor=activecolor;
      femalecolor=deactivecolor;
    }
    if(gendertype==gender.female){
      femalecolor=activecolor;
      malecolor=deactivecolor;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: GestureDetector(
                onTap: (){
                  setState(() {
                    updatecolor(gender.male);
                  });
                },
                child: Repeatcontainercode(
                  colors: malecolor,
                  cardWidget: ReapeatTIwidget(
                    icondata: FontAwesomeIcons.male,
                    label: 'Male',
                  ),
                ),
              ),),
              Expanded(child: GestureDetector(
                onTap: (){
                  setState(() {
                    updatecolor(gender.female);
                  });
                },
                child: Repeatcontainercode(
                  colors: femalecolor,
                  cardWidget: ReapeatTIwidget(
                    icondata: FontAwesomeIcons.female,
                    label: 'Female',
                  ),
                ),
              ),),
            ],
          )),
          Expanded(child: Repeatcontainercode(
            colors: Color(0xFF1D1E33),
          ),),

          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
              ),),
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
              ),),
            ],
          )),

        ],
      ),
    );
  }
}



