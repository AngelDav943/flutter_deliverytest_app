import 'dart:math';
import 'package:flutter/material.dart';
import 'all.dart';

class Item extends StatefulWidget {
  const Item({
    super.key,
    this.title = "",
    this.description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
    this.price = 0,
    this.image = "",
    this.restaurantImage = "bob.png"
  });

  final String title;
  final String description;
  final String image;
  final double price;
  final String restaurantImage;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    double total = widget.price * amount;
    return Scaffold(
      backgroundColor: Colors.black,
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
                        Navigator.pop(context,true);
                      },
                    ),
                    ImageButton(
                      image: "cart.png",
                      pressUp: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                "assets/items/${widget.image}",
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(20),
                alignment: AlignmentDirectional.topStart,
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(100))
                          ),
                          child: Image.asset(
                            "assets/restaurants/${widget.restaurantImage}",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Expanded(
                          child: Text(
                              widget.title,
                              style: Theme.of(context).textTheme.displaySmall,
                              overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(widget.description)
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text("\$${widget.price}")
                    )
                  ]
                ),
              ),
            ),
            Container(
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageButton(
                              image: "minus.png",
                              height: 30,
                              pressUp: () {
                                setState(() {
                                  amount = max(1, amount - 1);
                                  total = widget.price * amount;
                                });
                              }
                            ),
                            Text(
                              "$amount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            ImageButton(
                              image: "plus.png",
                              height: 30,
                              pressUp: () {
                                setState(() {
                                  amount = min(999, amount + 1);
                                  total = widget.price * amount;
                                });
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        showDialog(context: context, builder: (builder){
                          return AlertDialog(
                            title: const Text("Are you sure?"),
                            content: Text("Do you want to buy $amount ${widget.title}${amount > 1 ? "s" : ""} for a total of \$$total?"),
                            actions: [
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context, false);
                              }, child: const Text("No")),
                              FilledButton(onPressed: () {
                                insertItem(widget.title, widget.price, amount: amount, image: widget.image);
                                Navigator.pop(context, false);
                                Navigator.pop(context, false);
                              }, child: const Text("Yes")),
                            ],
                          );
                        });
                      },
                      child: Text("Add \$$total")
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
