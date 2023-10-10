
class SignUpRequestModel {
  final String name;
  final String password;
  final String email;
  final String rePassword;
  final String phoneNumber;

  const SignUpRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phoneNumber,
  });

}
