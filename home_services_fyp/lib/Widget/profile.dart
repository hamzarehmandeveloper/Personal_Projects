import 'package:flutter/material.dart';


class ProfileWidget extends StatefulWidget {
  String? imagePath;
  bool? isEdit;
  VoidCallback? onClicked;
  String? email;

  ProfileWidget({
    Key? key,
    this.imagePath,
    this.isEdit = false,
    this.onClicked,
    this.email,

  }) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          widget.email != null ? Align(alignment: Alignment.bottomCenter ,child: Center(child: Text(widget.email!),)):const SizedBox(),
        ],
      ),
    );
  }

  Widget buildImage() {
    //const image = File(widget.imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Image.asset(
          widget.imagePath.toString(),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

/*  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.onClicked();
        // Update the imagePath with the new image file path
        // This will trigger the rebuild and update the displayed image
        widget.imagePath = pickedFile.path;
      });
    }
  }*/

  Widget buildEditIcon() => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        widget.isEdit! ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      InkWell(
        onTap: widget.onClicked,
        child: ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: color,
            child: child,
          ),
        ),
      );
}

