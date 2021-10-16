import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/spin_me_app.dart';

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = SpinMeApp.of(context);
    final currentLanguage = app?.getLanguage();
    final Function()? enOnPressed = currentLanguage == Language.ru
        ? () {
            app?.setLanguage(Language.en);
          }
        : null;
    final Function()? ruOnPressed = currentLanguage == Language.en
        ? () {
            app?.setLanguage(Language.ru);
          }
        : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: enOnPressed, child: Text("English")),
        ElevatedButton(onPressed: ruOnPressed, child: Text("Русский")),
      ],
    );
  }
}
