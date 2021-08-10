import 'package:domain/domain_module.dart';
import 'package:hive/hive.dart';

part 'member_entity.g.dart';

/// Player model for data layer.
@HiveType(typeId: 2)
class MemberEntity {
  MemberEntity(this.locale);

  MemberEntity.fromDomainModel(Member member) : this.locale = member.locale;

  @HiveField(0)
  String locale;
}

extension MemberEntityConverter on MemberEntity {
  Member toDomainModel() => Member(this.locale);
}
