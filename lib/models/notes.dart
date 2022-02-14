import 'package:hive/hive.dart';
part 'notes.g.dart';

@HiveType(typeId: 1)
class Notes {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String body;
  @HiveField(2)
  late int color;

  Notes({required this.title, required this.body});
}
