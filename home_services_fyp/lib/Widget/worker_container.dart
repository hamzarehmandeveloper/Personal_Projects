import 'package:flutter/material.dart';


class workerContainer extends StatelessWidget {
  final String name;
  final String job;
  final String image;
  final double rating;
  final Function() ontap;
  const workerContainer({Key? key, required this.name, required this.job, required this.image, required this.rating, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15.0),
          child: Container(
            height: 300,
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(image,fit: BoxFit.cover,width: 70,height: 70,)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        job,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        rating.toString(),
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

