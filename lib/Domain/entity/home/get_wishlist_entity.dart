
class GetWishlistEntity {
  GetWishlistEntity({
      this.status, 
      this.count, 
      this.data,});


  String? status;
  int? count;
  List<DataWishListEntity>? data;


}


class DataWishListEntity {
  DataWishListEntity({
      this.sold, 
      this.images,
      this.ratingsQuantity, 
      this.id, 
      this.title, 
      this.slug, 
      this.description, 
      this.quantity, 
      this.price, 
      this.imageCover,
      this.brand, 
      this.ratingsAverage, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      });

  int? sold;
  List<String>? images;
  int? ratingsQuantity;
  String? id;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  BrandWishListEntity? brand;
  num? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  int? v;


}


class BrandWishListEntity {
  BrandWishListEntity({
      this.id, 
      this.name, 
      this.slug, 
      this.image,});


  String? id;
  String? name;
  String? slug;
  String? image;


}


