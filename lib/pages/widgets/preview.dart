import 'package:flutter/material.dart';
import '../all.dart';

class PreviewBase extends StatelessWidget {
  const PreviewBase({
    super.key,
    this.image = "",
    this.onTap,
    this.text = "",
    this.startColor = const Color.fromRGBO(233, 255, 246, 1),
    this.endColor = const Color.fromRGBO(184, 255, 224, 1)
  });

  final String text;
  final String image;
  final dynamic onTap;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:(details) {
        if (onTap != null) onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            startColor,
            endColor
            ]
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        margin: const EdgeInsets.all(5),
        alignment: AlignmentDirectional.centerStart,
        width: 100,
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/$image",
                height: 100,
                width: 90,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantPreview extends StatelessWidget {
  const RestaurantPreview({super.key, required this.restaurantid, this.image = "", this.text = ""});

  final String restaurantid;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return PreviewBase(
      image: "restaurants/$image",
      text: text,
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Restaurant(restaurantid: restaurantid, image: image, title: text);
        }));
      },
      startColor: const Color.fromRGBO(233, 246, 255, 1),
      endColor: const Color.fromRGBO(184, 222, 255, 1)

    );
  }
}

class ItemPreview extends StatelessWidget {
  const ItemPreview({super.key, this.image = "", this.text = "", this.price = 0, this.restaurantImage = "bob.png"});

  final String image;
  final String text;
  final String restaurantImage;
  final num price;

  @override
  Widget build(BuildContext context) {
    return PreviewBase(
      image: "items/$image",
      text: text,
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Item(
            image: image,
            title: text,
            price: price.toDouble(),
            restaurantImage: restaurantImage,
          );
        }));
      },
    );
  }
}