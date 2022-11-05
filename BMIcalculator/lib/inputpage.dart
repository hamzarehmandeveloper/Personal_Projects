import 'package:flutter/material.dart';
import 'container.dart';
import 'IconText.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




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

  int height = 180;
  int weight = 50;
  int age = 20;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            cardWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Height" ,style: Klabelstyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      height.toString(),
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "cm",
                      style: Klabelstyle,
                    ),
                  ],
                ),
                Slider(
                  activeColor: Color(0xFFEB1555),
                  inactiveColor: Color(0xFF8D8E98),
                  value: height.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      height = newValue.round();
                    });
                  },
                  min: 120,
                  max: 220,
                )
              ],
            ),

          ),),
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
                cardWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                  "Weight",
                  style: Klabelstyle,
                ),
                Text(
                  weight.toString(),
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundIconButton(
                      icon: FontAwesomeIcons.plus,
                      onPressed: () {
                        setState(() {
                          weight++;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RoundIconButton(
                      icon: FontAwesomeIcons.minus,
                      onPressed: () {
                        setState(() {
                          weight--;
                        });
                      },
                    ),
                  ],
                ),
                ],
              ),
              ),
    ),
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
                cardWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Age",
                      style: Klabelstyle,
                    ),
                    Text(
                      age.toString(),
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: () {
                            setState(() {
                              age++;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: () {
                            setState(() {
                              age--;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ),
            ],
          )
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(bottom: 20.0),
              width: double.infinity,
              height: 70.0,
              color: Color(0xFFEB1555),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, required this.onPressed});
  final IconData? icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon),
      elevation: 6.0,
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      constraints: BoxConstraints.tightFor(width: 45.0, height: 45.0),
    );
  }
}


