import 'package:get_it/get_it.dart';
import 'package:essert_coffee/features/menu/screens/item_service.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<ItemService>(() => ItemService());
}
