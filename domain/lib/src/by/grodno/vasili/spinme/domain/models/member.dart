import 'package:equatable/equatable.dart';

/// Member domain model.
class Member extends Equatable {
  const Member(this.locale);

  final String locale;

  @override
  List<Object?> get props => [locale];
}
