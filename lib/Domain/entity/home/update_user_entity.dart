class UpdateUserEntity {
  UpdateUserEntity({
    this.message,
    this.user,
  });

  String? message;
  UserUpEntity? user;
}

class UserUpEntity {
  UserUpEntity({
    this.name,
    this.email,
  });

  String? name;
  String? email;
}
