
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh_flow_task/commons/network/network_info.dart';
import 'package:fresh_flow_task/layers/data/datasources/auth_local_data_source.dart';
import 'package:fresh_flow_task/layers/data/datasources/auth_remote_data_source.dart';
import 'package:fresh_flow_task/layers/data/datasources/item_local_datasource.dart';
import 'package:fresh_flow_task/layers/data/datasources/item_remote_datasource.dart';
import 'package:fresh_flow_task/layers/data/repositories/auth_repository_impl.dart';
import 'package:fresh_flow_task/layers/data/repositories/item_repository_impl.dart';
import 'package:fresh_flow_task/layers/domain/repositories/auth_repository.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';
import 'package:fresh_flow_task/layers/domain/usecases/get_all_items.dart';
import 'package:fresh_flow_task/layers/domain/usecases/get_cache_user.dart';
import 'package:fresh_flow_task/layers/domain/usecases/login_usecase.dart';
import 'package:fresh_flow_task/layers/domain/usecases/logout_usecase.dart';
import 'package:fresh_flow_task/layers/local/datasources/auth_local_datasource_impl.dart';
import 'package:fresh_flow_task/layers/local/datasources/item_local_datasource_impl.dart';
import 'package:fresh_flow_task/layers/network/datasources/auth_remote_datasource_impl.dart';
import 'package:fresh_flow_task/layers/network/datasources/item_remote_datasource_impl.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/item_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/auth_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    print('here');
    debugPrint(value.options.androidClientId);
  });

  sl.registerFactory(() => GetAllItems(itemRepository: sl()));
  sl.registerFactory(() => Login(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => Logout(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => GetCacheUser(authRepository: sl<AuthRepository>()));

  //For notifier
  sl.registerFactory(
        () => ItemNotifier(getAllItems: sl()),
  );

  sl.registerFactory(
        () => AuthNotifier(login: sl<Login>(), logout: sl<Logout>(),
        getCacheUser: sl<GetCacheUser>()
        ),
  );

  // * Domain Layer


  // * Data Layer
  sl.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
      networkInfo: sl()
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
        authRemoteDatasource: sl(),
        authLocalDatasource: sl(),
        networkInfo: sl()
    ),
  );


  // * Network Layer
  sl.registerFactory<ItemRemoteDatasource>(
      () => ItemRemoteDatasourceImpl(fireCloud: sl()));
sl.registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(fireAuth: sl()));

  // * Local Layer
  sl.registerFactory<ItemLocalDatasource>(
      () => ItemLocalDatasourceImpl(sharedPreferences: sl()));

sl.registerFactory<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(sharedPreferences: sl()));




  // * External
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPref);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));

}
