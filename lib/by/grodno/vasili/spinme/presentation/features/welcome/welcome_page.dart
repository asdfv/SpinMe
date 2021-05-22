import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_page.dart';

const welcomeRoute = "/";

class WelcomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to SpinMe! Turn the wheel and do the task!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, preparePageRoute);
                },
                child: const Text("Let's go!")),
          ],
        ),
      ),
    );
  }
}
