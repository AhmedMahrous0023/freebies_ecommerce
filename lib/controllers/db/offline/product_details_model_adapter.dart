import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class HiveAdapterProductStore extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  HiveAdapterProductStore({required this.id, required this.name});
}
