library auth_local_source.dart;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:washryte/core/data/index.dart';
import 'package:washryte/features/auth/data/models/token_response/token_response.dart';
import 'package:washryte/features/auth/data/repositories/repos.dart';

@singleton
class AuthLocalDatasource {
  final AccessTokenManager _manager;
  final AppDatabase _database;

  AuthLocalDatasource(this._manager, this._database);

  Future<void> cacheAuthenticatedUser(UserDTO user) async {
    await _database.userDAO.insertItem(user.floor);
  }

  Future<Option<UserDTO?>> getUser() async {
    final dao = _database.userDAO;

    final _result = await dao.lastUser();

    return optionOf(_result);
  }

  Future<void> cacheUserAccessToken(dynamic response) async =>
      await _manager.save(response: TokenResponse.fromJson(response as Map<String, dynamic>));

  Future<void> signOut({
    bool clearUser = true,
    bool clearAccessToken = true,
  }) async {
    if (clearUser) await _database.userDAO.removeUsers();

    if (clearAccessToken) await _manager.delete();
  }
}
