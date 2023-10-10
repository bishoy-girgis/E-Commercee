  import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {

  final String userName;
  final String userEmail;
  final String token;

  const SignUpEntity({
    required this.userName,
    required this.userEmail,
    required this.token,
  });

  @override
  List<Object?> get props => [userName, userEmail, token];
}
