import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_services_fyp/models/proposal_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../models/workRequestModel.dart';

class WorkStatusScreen extends StatefulWidget {
  final int index;

  WorkStatusScreen({required this.index});

  @override
  State<WorkStatusScreen> createState() => _WorkStatusScreenState();
}

class _WorkStatusScreenState extends State<WorkStatusScreen> {
  final List<String> milestones = [
    'Start the task',
    'Gather materials',
    'Work in progress',
    'Finalize the task',
  ];
  double _professionalismRating = 0;
  double _qualityOfWorkRating = 0;
  double _punctualityRating = 0;

  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Leave a review',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Professionalism',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(width: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _professionalismRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quality of Work',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _qualityOfWorkRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Punctuality',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _punctualityRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Leave a review:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: reviewController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      hintText: 'Type your message ',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: Text('Submit'),
                      onPressed: () {
                        print(reviewController.text);
                        print(_professionalismRating);
                        print(_punctualityRating);
                        print(_qualityOfWorkRating);
                        reviewController.clear();
                        setState(() {
                          _punctualityRating = 0;
                          _qualityOfWorkRating = 0;
                          _professionalismRating = 0;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Rating submitted successfully!')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Work Status',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0, 6),
                      blurRadius: 10.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proposals[widget.index].title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Rate : ${(proposals[widget.index].rate.toString())} Rs',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Estimated Time : ${(proposals[widget.index].estimatedTime)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Material : ${(proposals[widget.index].material)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        proposals[widget.index].location,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: requestModel[widget.index]
                            .images
                            .map((imageAddress) {
                          return Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(imageAddress),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              workTimeLine(showReviewDialog),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

Widget workTimeLine(Function() ontap) {
  return Center(
    child: ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild: _RightChild(
            asset: 'assets/images/demo.png',
            title: 'Start the task',
            message: 'Worker is reached to destination to start work',
            ontap: () {},
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF2B619C),
            padding: EdgeInsets.all(6),
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 30),
            child: _RightChild(
              asset: 'assets/images/demo.png',
              title: 'Gather materials',
              message: 'Worker is gathering materials for the task',
              ontap: () {},
            ),
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
          afterLineStyle: const LineStyle(
            color: Color(0xFF054FB0),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF000000),
            padding: EdgeInsets.all(6),
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 30),
            child: _RightChild(
              asset: 'assets/images/demo.png',
              title: 'Work in progress',
              message: 'Worker is working on the task',
              ontap: () {},
            ),
          ),
          beforeLineStyle: const LineStyle(
              color: Color(0xFF2B619C),
          ),
          afterLineStyle: const LineStyle(
            color: Color(0xFF000000),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isLast: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFFFF004A),
            padding: EdgeInsets.all(6),
          ),
          endChild: _RightChild(
            asset: 'assets/images/demo.png',
            title: 'Finalize the task',
            message: 'Your work is completed',
            button: true,
            ontap: ontap,
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF000000),
          ),
        ),
      ],
    ),
  );
}

class _RightChild extends StatefulWidget {
  const _RightChild({
    Key? key,
    required this.asset,
    required this.title,
    required this.message,
    this.disabled = false,
    this.button = false,
    required this.ontap,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;
  final bool button;
  final void Function() ontap;

  @override
  State<_RightChild> createState() => _RightChildState();
}

class _RightChildState extends State<_RightChild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(widget.asset, height: 50),
            opacity: widget.disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.disabled ? const Color(0xFFBABABA) : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 210,
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.disabled ? const Color(0xFFD5D5D5) : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              widget.button
                  ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    widget.disabled ? const Color(0xFFBABABA) : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  onPressed: widget.disabled ? null : widget.ontap,
                  child: Text('Rate Work'))
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
