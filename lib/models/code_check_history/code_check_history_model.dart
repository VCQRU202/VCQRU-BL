class CodeheckHistoryModel {
  bool? status;
  String? message;
  List<HistoryData>? data;


  CodeheckHistoryModel(
      {this.status, this.message, this.data});

  CodeheckHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HistoryData>[];
      json['data'].forEach((v) {
        data!.add(new HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class HistoryData {
  var cureency;
  var currencySign;
  var enqDate;
  var clr;
  var cls;
  var sSign;
  var trStatus;
  var msg1;
  var msg2;
  var compName;
  var updthalf;
  var updtfull;
  var loyalty;
  var code1;
  var code2;
  var giftname;
  var mobileNo;
  var transNum;
  var proName;
  var proId;
  var serviceID;
  var serviceName;
  var purchaseDate;
  var warrantyPeriod;
  var expirationDate;
  var numberofDays;
  var iswarrantyclaimed;
  var comment;
  var vendorcomments;
  var vendorclaimstatus;
  var billno;
  var imagepathbill;
  var vehicleno;
  var device;
  var warrantyId;
  var uPIID;
  var paymentStatus;
  var bankRefID;
  var transactionDate;
  var paymentRemarks;

  var orderID;
  var status;
  var remarks;
  var updt1;

  HistoryData(
      {this.cureency,
        this.currencySign,
        this.enqDate,
        this.clr,
        this.cls,
        this.sSign,
        this.trStatus,
        this.msg1,
        this.msg2,
        this.compName,
        this.updthalf,
        this.updtfull,
        this.loyalty,
        this.code1,
        this.code2,
        this.giftname,
        this.mobileNo,
        this.transNum,
        this.proName,
        this.proId,
        this.serviceID,
        this.serviceName,
        this.purchaseDate,
        this.warrantyPeriod,
        this.expirationDate,
        this.numberofDays,
        this.iswarrantyclaimed,
        this.comment,
        this.vendorcomments,
        this.vendorclaimstatus,
        this.billno,
        this.imagepathbill,
        this.vehicleno,
        this.device,
        this.warrantyId,
        this.uPIID,
        this.paymentStatus,
        this.bankRefID,
        this.transactionDate,
        this.paymentRemarks,

        this.orderID,
        this.status,
        this.remarks,
        this.updt1});

  HistoryData.fromJson(Map<String, dynamic> json) {
    cureency = json['cureency'];
    currencySign = json['currency_sign'];
    enqDate = json['Enq_Date'];
    clr = json['clr'];
    cls = json['cls'];
    sSign = json['_sign'];
    trStatus = json['tr_status'];
    msg1 = json['msg1'];
    msg2 = json['msg2'];
    compName = json['Comp_Name'];
    updthalf = json['Updthalf'];
    updtfull = json['Updtfull'];
    loyalty = json['Loyalty'];
    code1 = json['code1'];
    code2 = json['code2'];
    giftname = json['giftname'];
    mobileNo = json['MobileNo'];
    transNum = json['trans_num'];
    proName = json['Pro_Name'];
    proId = json['Pro_id'];
    serviceID = json['Service_ID'];
    serviceName = json['ServiceName'];
    purchaseDate = json['PurchaseDate'];
    warrantyPeriod = json['WarrantyPeriod'];
    expirationDate = json['ExpirationDate'];
    numberofDays = json['NumberofDays'];
    iswarrantyclaimed = json['iswarrantyclaimed'];
    comment = json['comment'];
    vendorcomments = json['vendorcomments'];
    vendorclaimstatus = json['vendorclaimstatus'];
    billno = json['billno'];
    imagepathbill = json['imagepathbill'];
    vehicleno = json['vehicleno'];
    device = json['device'];
    warrantyId = json['warranty_id'];
    uPIID = json['UPIID'];
    paymentStatus = json['PaymentStatus'];
    bankRefID = json['BankRefID'];
    transactionDate = json['TransactionDate'];
    paymentRemarks = json['PaymentRemarks'];
    uPIID = json['UPI_ID'];
    orderID = json['OrderID'];
    status = json['Status'];
    remarks = json['Remarks'];
    updt1 = json['updt1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cureency'] = this.cureency;
    data['currency_sign'] = this.currencySign;
    data['Enq_Date'] = this.enqDate;
    data['clr'] = this.clr;
    data['cls'] = this.cls;
    data['_sign'] = this.sSign;
    data['tr_status'] = this.trStatus;
    data['msg1'] = this.msg1;
    data['msg2'] = this.msg2;
    data['Comp_Name'] = this.compName;
    data['Updthalf'] = this.updthalf;
    data['Updtfull'] = this.updtfull;
    data['Loyalty'] = this.loyalty;
    data['code1'] = this.code1;
    data['code2'] = this.code2;
    data['giftname'] = this.giftname;
    data['MobileNo'] = this.mobileNo;
    data['trans_num'] = this.transNum;
    data['Pro_Name'] = this.proName;
    data['Pro_id'] = this.proId;
    data['Service_ID'] = this.serviceID;
    data['ServiceName'] = this.serviceName;
    data['PurchaseDate'] = this.purchaseDate;
    data['WarrantyPeriod'] = this.warrantyPeriod;
    data['ExpirationDate'] = this.expirationDate;
    data['NumberofDays'] = this.numberofDays;
    data['iswarrantyclaimed'] = this.iswarrantyclaimed;
    data['comment'] = this.comment;
    data['vendorcomments'] = this.vendorcomments;
    data['vendorclaimstatus'] = this.vendorclaimstatus;
    data['billno'] = this.billno;
    data['imagepathbill'] = this.imagepathbill;
    data['vehicleno'] = this.vehicleno;
    data['device'] = this.device;
    data['warranty_id'] = this.warrantyId;
    data['UPIID'] = this.uPIID;
    data['PaymentStatus'] = this.paymentStatus;
    data['BankRefID'] = this.bankRefID;
    data['TransactionDate'] = this.transactionDate;
    data['PaymentRemarks'] = this.paymentRemarks;
    data['UPI_ID'] = this.uPIID;
    data['OrderID'] = this.orderID;
    data['Status'] = this.status;
    data['Remarks'] = this.remarks;
    data['updt1'] = this.updt1;
    return data;
  }
}