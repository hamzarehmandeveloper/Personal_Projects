import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class recordContainer extends StatelessWidget {
  final String name;
  final String? city;
  final String job;
  final String image;
  final String rating;
  final Function() ontap;
  final bool isWorker;
  const recordContainer({Key? key, required this.name, this.city,required this.job, required this.image, required this.rating, required this.ontap, required this.isWorker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15.0),
          child: Container(
            height: 300,
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
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
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                      placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/demo.png',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      isWorker?Text(
                        job,
                        style: const TextStyle(fontSize: 15),
                      ):Text(
                        city!,
                        style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  const Spacer(),
                  isWorker? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        rating,
                        style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      )
                    ],
                  ):SizedBox()
                ]),
          ),
        ),
      ),
    );
  }
}

