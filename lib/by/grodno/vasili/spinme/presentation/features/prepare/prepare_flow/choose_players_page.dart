import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';

const routeChoosePlayers = "choosePlayers";

class ChoosePlayersPage extends StatelessWidget {
  const ChoosePlayersPage({
    Key? key,
    required this.onPlayersChosen,
  }) : super(key: key);

  final Function(List<String>) onPlayersChosen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseNamesForm(onPlayersChosen: onPlayersChosen),
    );
  }
}

class ChooseNamesForm extends StatefulWidget {
  const ChooseNamesForm({Key? key, required this.onPlayersChosen}) : super(key: key);

  final Function(List<String>) onPlayersChosen;

  @override
  ChooseNamesFormState createState() {
    return ChooseNamesFormState();
  }
}

class ChooseNamesFormState extends State<ChooseNamesForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> names = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createNameField(),
          _createNameField(),
          _createSubmitButton(context),
        ],
      ),
    );
  }

  Widget _createSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _submitForm();
          } else {
            context.snack("Your form is invalid!");
          }
        },
        child: Text('Next'),
      ),
    );
  }

  Widget _createNameField() => TextFormField(
        onSaved: (value) {
          names.add(value!);
        },
        decoration: const InputDecoration(
          hintText: 'Enter player name',
          labelText: 'Name',
        ),
        keyboardType: TextInputType.text,
        validator: _validator,
      );

  String? _validator(value) => value.length < 3 ? 'Please enter name longer than 3 symbols' : null;

  void _submitForm() {
    final areDuplicates = names.length != names.toSet().length;
    if (areDuplicates) {
      context.snack("All names should be different");
    } else {
      widget.onPlayersChosen(names);
    }
    names.clear();
  }
}
