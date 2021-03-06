part of app_database.dart;

@freezed
@immutable
class UserDTO with _$UserDTO {
  static const String tableName = 'users';

  @Entity(tableName: UserDTO.tableName)
  const factory UserDTO({
    @primaryKey String? id,
    String? token,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? email,
    String? phone,
    String? password,
    @JsonKey(name: 'current_password') String? oldPassword,
    @JsonKey(name: 'password_confirmation') String? confirmation,
    @JsonKey(name: 'image') String? image,
    @AuthProviderSerializer() AuthProvider? provider,
    @JsonKey(name: 'created_at') @TimestampConverter() DateTime? createdAt,
    @JsonKey(name: 'updated_at') @TimestampConverter() DateTime? updatedAt,
    @JsonKey(name: 'deleted_at') @TimestampConverter() DateTime? deletedAt,
  }) = _UserDTO;

  const UserDTO._();

  factory UserDTO.fromDomain(User? instance) => UserDTO(
        firstName: instance?.firstName.getOrNull,
        lastName: instance?.lastName.getOrNull,
        email: instance?.email.getOrNull,
        phone: instance?.phone.getOrNull,
        password: instance?.password.getOrNull,
      );

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  User get domain => User(
        uid: UniqueId.fromExternal(id),
        firstName: DisplayName(firstName),
        lastName: DisplayName(lastName),
        email: EmailAddress(email),
        phone: Phone(phone),
        password: Password(password),
        photo: MediaField(image),
        provider: provider!,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: deletedAt,
      );

  _$_UserDTO get floor => _$_UserDTO(
        id: id,
        token: token,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        oldPassword: oldPassword,
        confirmation: confirmation,
        phone: phone,
        image: image,
        provider: provider,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: deletedAt,
      );
}

@dao
abstract class UserDAO extends BaseDAO<_$_UserDTO> {
  @Query('SELECT * FROM ${UserDTO.tableName}')
  Stream<List<_$_UserDTO?>> watchUsers();

  @Query('SELECT * FROM ${UserDTO.tableName}')
  Future<List<_$_UserDTO?>> allUsers();

  @Query('SELECT * FROM ${UserDTO.tableName} WHERE id = :id')
  Future<_$_UserDTO?> findUser(int id);

  @Query('DELETE FROM ${UserDTO.tableName}')
  Future<void> removeUsers();

  @Query('SELECT * FROM ${UserDTO.tableName} ORDER BY ID DESC LIMIT 1')
  Future<_$_UserDTO?> lastUser();
}
