import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/preferences/game_preferences.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/key_generator.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

class NamesFormWidget extends StatefulWidget {
  const NamesFormWidget({
    Key? key,
    required this.onPlayersChosen,
    this.initialPlayers = const [],
  }) : super(key: key);

  final Function(List<String>) onPlayersChosen;
  final List<Player> initialPlayers;

  @override
  NamesFormWidgetState createState() => NamesFormWidgetState();
}

class NamesFormWidgetState extends State<NamesFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _names = [];
  Map<String, Widget> _nameFields = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initFields();
  }

  void _initFields() {
    var initialPlayers = widget.initialPlayers;
    if (initialPlayers.length > GamePreferences.maxNumberOfPlayers) {
      initialPlayers = initialPlayers.sublist(0, GamePreferences.maxNumberOfPlayers - 1);
    }
    final numberToAdd = GamePreferences.minNumberOfPlayers - initialPlayers.length;
    widget.initialPlayers.forEach((element) {
      _addNameField(initText: element.name);
    });
    for (var index = 0; index < numberToAdd; index++) {
      _addNameField();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _nameFields.values.length,
              itemBuilder: (context, index) => _nameFields.values.toList()[index],
            ),
          ),
          _createPlusButton(),
          _createSubmitButton(context)
        ],
      ),
    );
  }

  Widget _createPlusButton() {
    final Function()? action = _nameFields.length >= GamePreferences.maxNumberOfPlayers ? null : _addNameField;
    return ElevatedButton(
      key: ValueKey("names_widget_add_name_button"),
      onPressed: action,
      child: const Icon(Icons.add),
    );
  }

  Widget _createSubmitButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          key: ValueKey("names_widget_next_button"),
          onPressed: () {
            _formKey.currentState!.save();
            final errorMessage = _validate(_names);
            if (errorMessage == null) {
              widget.onPlayersChosen(List.from(_names));
            } else {
              context.info(errorMessage);
            }
            _names.clear();
          },
          child: Text(context.getLocalizedString("app_next")),
        ),
      );

  String? _validate(List<String> names) {
    if (names._containsShortNames()) {
      return context.getLocalizedString(
          "prepare_players_short_name_or_non_filled_message", GamePreferences.minCharactersInPlayerName);
    } else if (names.length < GamePreferences.minNumberOfPlayers || names.length > GamePreferences.maxNumberOfPlayers) {
      return context.getLocalizedString("prepare_players_not_enough_players", GamePreferences.minNumberOfPlayers);
    } else if (names._containsDuplicates()) {
      return context.getLocalizedString("prepare_players_names_should_be_different");
    } else {
      return null;
    }
  }

  final keyGenerator = getIt<KeyGenerator>();

  void _addNameField({String initText = ""}) {
    final key = keyGenerator.generate("names_widget_name_field_");
    setState(() {
      _nameFields[key] = Row(
        children: [
          Expanded(
            child: TextFormField(
              key: ValueKey(key),
              autofocus: true,
              controller: TextEditingController(text: initText),
              onSaved: (value) {
                _names.add(value!);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 20),
                hintText: context.getLocalizedString("prepare_players_enter_name"),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _nameFields.remove(key);
              });
            },
            child: const Icon(Icons.delete, color: Colors.red),
          )
        ],
      );
    });
  }
}

extension _ContainsShortNames on Iterable<String> {
  bool _containsShortNames() => this.any((name) => name.trim().length < GamePreferences.minCharactersInPlayerName);
}

extension _ContainsDuplicates on Iterable<String> {
  bool _containsDuplicates() => this.length != this.toSet().length;
}
