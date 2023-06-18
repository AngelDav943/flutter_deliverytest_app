import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'all.dart';
import 'widgets/preview.dart';
import 'widgets/inputs.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.name});

  final String name;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Map _restaurants = {};
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _restaurants = data["restaurants"];
      _items = data["items"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  List<Widget> getRestaurants() {
    List<Widget> instances = [];
    _restaurants.forEach((key, value) {
      var restaurant = value;
      // ignore: avoid_print
      print(key.toString());
      instances.add(RestaurantPreview(
        restaurantid: key,
        image: restaurant["icon"],
        text: restaurant["display"],
      ));
    });
    return instances;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 34, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageButton(
                        image: "menu.png",
                        pressUp: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      const ImageButton(
                        image: "account.png",
                      ),
                    ],
                  ),
                ),
                Text(
                  "Hello ${widget.name}",
                  style: Theme.of(context).textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Field(
                  margin: const EdgeInsets.only(top: 15, bottom: 20),
                  controller: TextEditingController(),
                  hintText: "What do you want today?",
                ),
                Text(
                  "Personal selections",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      var item = _items[index];
                      return ItemPreview(
                        image: item["image"],
                        text: item["name"],
                        price: item["price"],
                        restaurantImage: _restaurants[item["restaurantid"]]
                            ["icon"],
                      );
                    },
                  ),
                ),
                Text(
                  "Restaurants",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: getRestaurants(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                DrawerHeader(
                    child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/account.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
                ListTile(
                  leading: Image.asset("assets/cart.png"),
                  textColor: const Color.fromRGBO(93, 93, 93, 1),
                  title: const Text("Cart",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Cart();
                    }));
                  },
                ),
              ]),
              ListTile(
                textColor: Colors.white,
                tileColor: Colors.red,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                leading: Image.asset(
                  "assets/logoff.png",
                  color: Colors.white,
                ),
                title: const Text(
                  "Log off",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                },
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                title: const Text("Warning!"),
                content: const Text("Do you really want to exit?"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("No")),
                  FilledButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text("Yes")),
                ],
              );
            });
        return false;
      },
    );
  }
}
