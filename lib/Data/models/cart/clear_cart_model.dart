
class ClearCartModel {
  ClearCartModel({
      this.message,});

  ClearCartModel.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;


}