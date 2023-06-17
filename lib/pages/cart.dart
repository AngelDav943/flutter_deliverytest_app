import 'package:flutter/material.dart';
import 'widgets/inputs.dart';

class CartItem {
  String name;
  double price;
  int amount;
  String image;

  CartItem({this.name = "", this.price = 0, this.amount = 1, this.image = "bob.png"});
}

List<CartItem> cartlist = [];

void insertItem(String name, double price, {int amount = 1, image}) {
  CartItem newItem = CartItem(name: name, price: price, amount: amount, image: image);

  bool hasDuplicate = false;
  for (var element in cartlist) {
    if (newItem.name == element.name) {
      element.amount += amount;
      hasDuplicate = true;
    }
  }

  if (!hasDuplicate) cartlist.add(newItem);
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total = 0;

  List<Widget> getElements()
  {
    List<Widget> listings = [];
    for (var element in cartlist) {
      listings.add(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/items/${element.image}",
                height: 50,
                width: 50,
              ),
              Text(
                "(${element.amount}) ${element.name}${element.amount > 1 ? "s" : ""}",
                textAlign: TextAlign.left,
              ),
              ImageButton(
                pressDown: () {
                  setState(() {
                    cartlist.removeWhere((item) => item == element);
                  });
                },
                image: "minus.png",
                color: Colors.red,
              )
            ],
          ),
        )
      );
    }
    return listings;
  }

  void calculateTotal() {
    total = 0;
    for (var element in cartlist) {
      total += element.price * element.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    calculateTotal();
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 40, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageButton(
                              image: "back.png",
                              pressUp: () {
                                Navigator.pop(context, true);
                                Navigator.pop(context, true);
                              },
                            ),
                            Text(
                              "( ${cartlist.length} item${cartlist.length == 1 ? "" : "s"} )",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: getElements(),
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Your total is \$$total",
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text("Buy")
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}