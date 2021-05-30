import 'package:domain/domain_module.dart';

extension CopyWithTask on Task {
  Task copyWithCheck(bool isChecked) => Task(this.id, this.description, isChecked);
}
