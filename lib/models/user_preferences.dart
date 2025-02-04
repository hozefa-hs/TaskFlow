import 'package:hive/hive.dart';

part 'user_preferences.g.dart';

@HiveType(typeId: 0)
class UserPreferences {
  @HiveField(0)
  bool isDarkMode;

  @HiveField(1)
  String defaultSortOrder; // Example: 'date' or 'priority'

  UserPreferences({
    required this.isDarkMode,
    required this.defaultSortOrder,
  });
}
