import 'package:dio/dio.dart';

class GetCategoriesDataSource {
  final Dio dio;

  GetCategoriesDataSource(this.dio);

  Future<Response> getCategories() async {
    return await dio.get("/api/v1/categories");
  }
}
