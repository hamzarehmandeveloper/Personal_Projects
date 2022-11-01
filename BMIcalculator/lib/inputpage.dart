import 'package:flutter/material.dart';
import 'container.dart';
import 'IconText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


const activecolor = Color(0xFF1D1E33);
const deactivecolor = Color(0xFF111328);


class inputpage extends StatefulWidget {
  const inputpage({Key? key}) : super(key: key);

  @override
  State<inputpage> createState() => _inputpageState();
}

class _inputpageState extends State<inputpage> {
  Color malecolor=deactivecolor;
  Color femalecolor=deactivecolor;

  void updatecolor(int gender){
    if(gender==1){
      malecolor=activecolor;
      femalecolor=deactivecolor;
    }
    if(gender==2){
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
                    updatecolor(1);
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
                    updatecolor(2);
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



