import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    this.image = "",
    this.pressDown, this.pressUp,
    this.height = 50, this.width = 50,
    this.color = const Color.fromRGBO(128, 128, 128, 1)
  });

  final String image;
  final dynamic pressDown;
  final dynamic pressUp;
  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:(details){
        if (pressDown != null) pressDown();
      },
      onTapUp: (details) {
        if (pressUp != null) pressUp();
      },
      onTapCancel: () {
        if (pressUp != null) pressUp();
      },
      child: Image.asset(
        "assets/$image",
        color: color,
        height: height,
        width: width,
      ),
    );
  }
}

class Field extends StatelessWidget {
  const Field({super.key, this.hintText = "", this.margin, required this.controller});

  final String hintText;
  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        key: key,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only( left: 15, right: 15 ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(66, 66, 66, 0.5)
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          hintText: hintText
        ),
      ),
    );
  }
}