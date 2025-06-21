import 'package:essert_coffee/layer%20data/branch_data.dart';
import 'package:get_it/get_it.dart';

/// Sets up dependency injection using GetIt.
void setup() async {
  GetIt.I.registerLazySingleton<BranchData>(() => BranchData());
}
