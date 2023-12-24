import 'package:get_it/get_it.dart';

import '../database/database.dart';

final GetIt locator = GetIt.instance;

configureDependencies() {
  locator.registerLazySingleton<NoteDatabase>(() => NoteDatabaseImpl());
}
