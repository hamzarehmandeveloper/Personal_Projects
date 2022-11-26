import 'package:flutter/material.dart';
import 'package:tasbeehapp/main.dart';
import 'constant.dart';

class saved extends StatelessWidget {
  const saved({Key?key}) : super(key: key);




  @override
  void initState() {
    getSavedT();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('saved Tasbeeh'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: tnameclass.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>mainpage(

                )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Row(
                  children: [
                  Expanded(child: Container(
                    height: 100,
                    child: Center(child: Text(tnameclass[index].name,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),)),
                  ),),

                    Expanded(child: Container(
                      height: 100,
                      child: Center(child: Text(tnameclass[index].count.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),)),
                    ))
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

