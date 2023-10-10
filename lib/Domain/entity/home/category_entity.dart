import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;

  const CategoryEntity(
      {required this.title,  required this.id, required this.imageUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, imageUrl];
}
