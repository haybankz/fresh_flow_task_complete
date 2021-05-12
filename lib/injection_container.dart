
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh_flow_task/commons/network/network_info.dart';
import 'package:fresh_flow_task/layers/data/datasources/local_datasource.dart';
import 'package:fresh_flow_task/layers/data/datasources/remote_datasource.dart';
import 'package:fresh_flow_task/layers/data/repositories/item_repository_impl.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';
import 'package:fresh_flow_task/layers/domain/usecases/get_all_items.dart';
import 'package:fresh_flow_task/layers/local/datasources/local_datasource_impl.dart';
import 'package:fresh_flow_task/layers/network/datasources/remote_datasource_impl.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/item_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  var value = await Firebase.initializeApp();
  print(value.options.storageBucket);




  //For notifier
  sl.registerFactory(
        () => ItemNotifier(getAllItems: sl()),
  );

  // * Domain Layer
  sl.registerFactory(() => GetAllItems(itemRepository: sl()));


  // * Data Layer
  sl.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
      networkInfo: sl()
    ),
  );


  // * Network Layer
  sl.registerFactory<RemoteDatasource>(
      () => RemoteDatasourceImpl(fireCloud: sl(),
      fireAuth: sl()));

  // * Local Layer
  sl.registerFactory<LocalDatasource>(
      () => LocalDatasourceImpl(sharedPreferences: sl()));




  // * External
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPref);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));

}
