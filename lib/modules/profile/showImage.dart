import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  String image;
  ShowImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
        ),
      ),
      body: Center(
        child: Image(
          image: NetworkImage(image),
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
