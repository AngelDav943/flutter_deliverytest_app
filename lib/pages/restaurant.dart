import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'all.dart';
import 'widgets/preview.dart';
import 'widgets/inputs.dart';

class Restaurant extends StatefulWidget {
  const Restaurant(
      {super.key,
      this.title = "",
      this.image = "",
      required this.restaurantid});

  final String title;
  final String image;
  final String restaurantid;

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  List _items = [];
  Map _restaurants = {};

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
      _restaurants = data["restaurants"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  List<Widget> getItems() {
    List<Widget> elements = [];
    for (var item in _items) {
      if (item["restaurantid"] == widget.restaurantid) {
        elements.add(ItemPreview(
            image: item["image"],
            text: item["name"],
            price: item["price"],
            restaurantImage: _restaurants[item["restaurantid"]]["icon"]));
      }
    }
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(233, 246, 255, 1),
              Color.fromRGBO(184, 222, 255, 1)
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  margin: const EdgeInsets.only(top: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageButton(
                        image: "back.png",
                        pressUp: () {
                          Navigator.pop(context, true);
                        },
                      ),
                      ImageButton(
                        image: "cart.png",
                        pressUp: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Cart();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(
                  "assets/restaurants/${widget.image}",
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: AlignmentDirectional.topStart,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  child: Column(children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      children: getItems(),
                    ))
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
