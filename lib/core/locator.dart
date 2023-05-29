import 'package:dipterv/services/customer_service.dart';
import 'package:dipterv/services/event_service.dart';
import 'package:dipterv/services/http_service.dart';
import 'package:dipterv/services/login_service.dart';
import 'package:dipterv/services/real_estates_service.dart';
import 'package:dipterv/services/safe_storage_service.dart';
import 'package:dipterv/services/salesman_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HttpService());
  locator.registerLazySingleton(() => LoginService());
  locator.registerLazySingleton(() => SafeStoreService());
  locator.registerLazySingleton(() => RealEstateService());
  locator.registerLazySingleton(() => CustomerService());
  locator.registerLazySingleton(() => SalesmanService());
  locator.registerLazySingleton(() => EventService());
}