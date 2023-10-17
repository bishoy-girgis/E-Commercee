import 'package:e_commerce_app/Domain/entity/payment/koisk_payment_entity.dart';

class KoiskPaymentModel extends KoiskPaymentEntity {
  KoiskPaymentModel({
    super.id,
    this.pending,
    this.amountCents,
    this.success,
    this.isAuth,
    this.isCapture,
    this.isStandalonePayment,
    this.isVoided,
    this.isRefunded,
    this.is3dSecure,
    this.integrationId,
    this.profileId,
    this.hasParentTransaction,
    this.createdAt,
    this.currency,
    this.apiSource,
    this.terminalId,
    this.merchantCommission,
    this.installment,
    this.isVoid,
    this.isRefund,
    this.data,
    this.isHidden,
    this.errorOccured,
    this.isLive,
    this.otherEndpointReference,
    this.refundedAmountCents,
    this.sourceId,
    this.isCaptured,
    this.capturedAmount,
    this.merchantStaffTag,
    this.updatedAt,
    this.isSettled,
    this.billBalanced,
    this.isBill,
    this.owner,
    this.parentTransaction,
  });

  KoiskPaymentModel.fromJson(dynamic json) {
    id = json['id'];
    pending = json['pending'];
    amountCents = json['amount_cents'];
    success = json['success'];
    isAuth = json['is_auth'];
    isCapture = json['is_capture'];
    isStandalonePayment = json['is_standalone_payment'];
    isVoided = json['is_voided'];
    isRefunded = json['is_refunded'];
    is3dSecure = json['is_3d_secure'];
    integrationId = json['integration_id'];
    profileId = json['profile_id'];
    hasParentTransaction = json['has_parent_transaction'];
    createdAt = json['created_at'];
    currency = json['currency'];
    apiSource = json['api_source'];
    terminalId = json['terminal_id'];
    merchantCommission = json['merchant_commission'];
    installment = json['installment'];
    isVoid = json['is_void'];
    isRefund = json['is_refund'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    isHidden = json['is_hidden'];
    errorOccured = json['error_occured'];
    isLive = json['is_live'];
    otherEndpointReference = json['other_endpoint_reference'];
    refundedAmountCents = json['refunded_amount_cents'];
    sourceId = json['source_id'];
    isCaptured = json['is_captured'];
    capturedAmount = json['captured_amount'];
    merchantStaffTag = json['merchant_staff_tag'];
    updatedAt = json['updated_at'];
    isSettled = json['is_settled'];
    billBalanced = json['bill_balanced'];
    isBill = json['is_bill'];
    owner = json['owner'];
    parentTransaction = json['parent_transaction'];
  }

  bool? pending;
  int? amountCents;
  bool? success;
  bool? isAuth;
  bool? isCapture;
  bool? isStandalonePayment;
  bool? isVoided;
  bool? isRefunded;
  bool? is3dSecure;
  int? integrationId;
  int? profileId;
  bool? hasParentTransaction;
  String? createdAt;
  String? currency;
  String? apiSource;
  dynamic terminalId;
  int? merchantCommission;
  dynamic installment;
  bool? isVoid;
  bool? isRefund;
  Data? data;
  bool? isHidden;
  bool? errorOccured;
  bool? isLive;
  dynamic otherEndpointReference;
  int? refundedAmountCents;
  int? sourceId;
  bool? isCaptured;
  int? capturedAmount;
  dynamic merchantStaffTag;
  String? updatedAt;
  bool? isSettled;
  bool? billBalanced;
  bool? isBill;
  int? owner;
  dynamic parentTransaction;
}

class Data {
  Data({
    this.klass,
    this.gatewayIntegrationPk,
    this.ref,
    this.rrn,
    this.amount,
    this.fromUser,
    this.message,
    this.biller,
    this.txnResponseCode,
    this.billReference,
    this.aggTerminal,
    this.dueAmount,
    this.cashoutAmount,
    this.paidThrough,
    this.otp,
  });

  Data.fromJson(dynamic json) {
    klass = json['klass'];
    gatewayIntegrationPk = json['gateway_integration_pk'];
    ref = json['ref'];
    rrn = json['rrn'];
    amount = json['amount'];
    fromUser = json['from_user'];
    message = json['message'];
    biller = json['biller'];
    txnResponseCode = json['txn_response_code'];
    billReference = json['bill_reference'];
    aggTerminal = json['agg_terminal'];
    dueAmount = json['due_amount'];
    cashoutAmount = json['cashout_amount'];
    paidThrough = json['paid_through'];
    otp = json['otp'];
  }

  String? klass;
  int? gatewayIntegrationPk;
  dynamic ref;
  dynamic rrn;
  dynamic amount;
  dynamic fromUser;
  String? message;
  dynamic biller;
  String? txnResponseCode;
  int? billReference;
  dynamic aggTerminal;
  int? dueAmount;
  dynamic cashoutAmount;
  String? paidThrough;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['klass'] = klass;
    map['gateway_integration_pk'] = gatewayIntegrationPk;
    map['ref'] = ref;
    map['rrn'] = rrn;
    map['amount'] = amount;
    map['from_user'] = fromUser;
    map['message'] = message;
    map['biller'] = biller;
    map['txn_response_code'] = txnResponseCode;
    map['bill_reference'] = billReference;
    map['agg_terminal'] = aggTerminal;
    map['due_amount'] = dueAmount;
    map['cashout_amount'] = cashoutAmount;
    map['paid_through'] = paidThrough;
    map['otp'] = otp;
    return map;
  }
}
