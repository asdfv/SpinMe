import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'language_picker_widget.dart';

const routeWelcome = "/";

/// The very first page with an invitation to play.
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
              context.getLocalizedString('welcome_title'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            LanguagePickerWidget(),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, routePreparePageFirstPage);
                },
                child: const Text("Let's go!")),
          ],
        ),
      ),
    );
  }
}
