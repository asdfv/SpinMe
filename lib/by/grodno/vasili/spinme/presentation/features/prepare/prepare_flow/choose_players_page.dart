import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/preferences/game_preferences.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

const routeChoosePlayers = "choosePlayers";

class ChoosePlayersPage extends StatelessWidget {
  const ChoosePlayersPage({
    Key? key,
    required this.onPlayersChosen,
  }) : super(key: key);

  final Function(List<String>) onPlayersChosen;

  @override
  Widget build(BuildContext context) {
    return ChooseNamesForm(onPlayersChosen: onPlayersChosen);
  }
}

class ChooseNamesForm extends StatefulWidget {
  const ChooseNamesForm({Key? key, required this.onPlayersChosen}) : super(key: key);

  final Function(List<String>) onPlayersChosen;

  @override
  ChooseNamesFormState createState() => ChooseNamesFormState();
}

class ChooseNamesFormState extends State<ChooseNamesForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _names = [];
  var _nameFields = <TextFormField>[];

  @override
  void initState() {
    _nameFields.add(_createNameField());
    _nameFields.add(_createNameField());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _nameFields.length,
              itemBuilder: (context, index) => _nameFields[index],
            ),
          ),
          _createPlusButton(context),
          _createSubmitButton(context)
        ],
      ),
    );
  }

  Widget _createPlusButton(BuildContext context) {
    final Function()? action = _nameFields.length >= GamePreferences.maxNumberOfPlayers
        ? null
        : () {
            if (_nameFields.hasNonFilledField()) {
              context.snack("You have non-filled fields");
            } else {
              _addNameField();
            }
          };
    return ElevatedButton(
      onPressed: action,
      child: Text('+'),
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

  void _submitForm() {
    final areDuplicates = _names.length != _names.toSet().length;
    if (areDuplicates) {
      context.snack("All names should be different");
      _names.clear();
    } else {
      widget.onPlayersChosen(_names);
    }
  }

  void _addNameField() {
    setState(() {
      _nameFields.add(_createNameField());
    });
  }

  TextFormField _createNameField() {
    return TextFormField(
      onTap: () {
        setState(() {});
      },
      controller: TextEditingController(),
      onSaved: (value) {
        _names.add(value!);
      },
      decoration: const InputDecoration(
        hintText: 'Enter player name',
        labelText: 'Name',
      ),
      keyboardType: TextInputType.text,
      validator: _validator,
    );
  }

  String? _validator(value) =>
      value.length < GamePreferences.minCharactersInPlayerName ? 'Please enter name longer than 3 symbols' : null;
}

extension TextFormFieldHasEmptyField on List<TextFormField> {
  bool hasNonFilledField() =>
      this.any((field) => field.controller!.value.text.length < GamePreferences.minCharactersInPlayerName);
}