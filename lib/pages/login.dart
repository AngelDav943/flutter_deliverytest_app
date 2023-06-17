import 'package:delivery_test/pages/home.dart';
import 'package:flutter/material.dart';
import 'all.dart';
import 'widgets/inputs.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final nameController = TextEditingController();
  String nombre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Delivery',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Text(
                      'LogIn',
                      style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    children: [
                      Field(
                        margin: const EdgeInsets.all(8),
                        controller: nameController,
                        hintText: 'Nombre',
                      ),
                      Field(
                        margin: const EdgeInsets.all(8),
                        controller: TextEditingController(),
                        hintText: 'Contraseña',
                      ),
                      FilledButton(
                        onPressed: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Home(name: nameController.text);
                          }));
                        },
                        child: const Text(
                          "Login"
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
