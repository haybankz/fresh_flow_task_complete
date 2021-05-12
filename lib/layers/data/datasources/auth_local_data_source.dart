
abstract class AuthLocalDatasource {


  String getLoggedInUser();

  Future<String> cacheUser(String userEmail);

  Future<void> logOutCacheUser();
}