import 'package:e_commerce_app/Domain/entity/payment/order_id_entity.dart';

class OrderIdModel extends OrderIdEntity {
  OrderIdModel({
      super.id,
      this.createdAt, 
      this.deliveryNeeded, 
      this.merchant, 
      this.collector, 
      this.amountCents, 
      this.shippingData, 
      this.currency, 
      this.isPaymentLocked, 
      this.isReturn, 
      this.isCancel, 
      this.isReturned, 
      this.isCanceled, 
      this.merchantOrderId, 
      this.walletNotification, 
      this.paidAmountCents, 
      this.notifyUserWithEmail,
      this.orderUrl, 
      this.commissionFees, 
      this.deliveryFeesCents, 
      this.deliveryVatCents, 
      this.paymentMethod, 
      this.merchantStaffTag, 
      this.apiSource, 
      this.data, 
      this.token, 
      this.url,});

  OrderIdModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    deliveryNeeded = json['delivery_needed'];
    merchant = json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
    collector = json['collector'];
    amountCents = json['amount_cents'];
    shippingData = json['shipping_data'];
    currency = json['currency'];
    isPaymentLocked = json['is_payment_locked'];
    isReturn = json['is_return'];
    isCancel = json['is_cancel'];
    isReturned = json['is_returned'];
    isCanceled = json['is_canceled'];
    merchantOrderId = json['merchant_order_id'];
    walletNotification = json['wallet_notification'];
    paidAmountCents = json['paid_amount_cents'];
    notifyUserWithEmail = json['notify_user_with_email'];
    orderUrl = json['order_url'];
    commissionFees = json['commission_fees'];
    deliveryFeesCents = json['delivery_fees_cents'];
    deliveryVatCents = json['delivery_vat_cents'];
    paymentMethod = json['payment_method'];
    merchantStaffTag = json['merchant_staff_tag'];
    apiSource = json['api_source'];
    data = json['data'];
    token = json['token'];
    url = json['url'];
  }
  String? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  dynamic collector;
  int? amountCents;
  dynamic shippingData;
  String? currency;
  bool? isPaymentLocked;
  bool? isReturn;
  bool? isCancel;
  bool? isReturned;
  bool? isCanceled;
  dynamic merchantOrderId;
  dynamic walletNotification;
  int? paidAmountCents;
  bool? notifyUserWithEmail;
  String? orderUrl;
  int? commissionFees;
  int? deliveryFeesCents;
  int? deliveryVatCents;
  String? paymentMethod;
  dynamic merchantStaffTag;
  String? apiSource;
  dynamic data;
  String? token;
  String? url;


}
class Merchant {
  Merchant({
      this.id, 
      this.createdAt, 
      this.phones, 
      this.companyEmails, 
      this.companyName, 
      this.state, 
      this.country, 
      this.city, 
      this.postalCode, 
      this.street,});

  Merchant.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    phones = json['phones'] != null ? json['phones'].cast<String>() : [];
    companyEmails = json['company_emails'] != null ? json['company_emails'].cast<String>() : [];
    companyName = json['company_name'];
    state = json['state'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    street = json['street'];
  }
  int? id;
  String? createdAt;
  List<String>? phones;
  List<String>? companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['phones'] = phones;
    map['company_emails'] = companyEmails;
    map['company_name'] = companyName;
    map['state'] = state;
    map['country'] = country;
    map['city'] = city;
    map['postal_code'] = postalCode;
    map['street'] = street;
    return map;
  }

}