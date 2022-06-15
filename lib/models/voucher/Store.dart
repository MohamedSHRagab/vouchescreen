import 'package:voucher/models/voucher/Hrefs.dart';
import 'package:voucher/models/voucher/Sbsinventoryprices.dart';
import 'package:voucher/models/voucher/Sbsinventoryqtys.dart';

class Store {
  var link;
  var sid;
  var createdBy;
  var createdDatetime;
  var modifiedBy;
  var modifiedDatetime;
  var controllerSid;
  var originApplication;
  var postDate;
  var rowVersion;
  var tenantSid;
  var subsidiarySid;
  var storeNumber;
  var storeName;
  var active;
  var activationDate;
  var storeCode;
  var globalStoreCode;
  var storeTypeSid;
  var address1;
  var address2;
  var address3;
  var address4;
  var address5;
  var zip;
  var phone1;
  var phone2;
  var activePriceLevelSid;
  var totalSurface;
  var displaySurface;
  var windows;
  var floors;
  var fullTimeEmployee;
  var partTimeEmployee;
  var seasonalEmpl;
  var salesTargetPercent;
  var udf1String;
  var udf2String;
  var udf3String;
  var udf4String;
  var udf5String;
  var ecommerceCatalog;
  var webstoreCatalog;
  var subsidiaryName;
  var subsidiaryNumber;
  var activePriceLevel;
  var taxAreaSid;
  var taxArea2Sid;
  var taxAreaName;
  var taxArea2Name;
  List<Workstationss>? workstationss;
  List<Employeess>? employeess;
  var serverAddress;
  var address6;
  var fiscalCode;
  Hrefs? hrefs;

  Store(
      {this.link,
        this.sid,
        this.createdBy,
        this.createdDatetime,
        this.modifiedBy,
        this.modifiedDatetime,
        this.controllerSid,
        this.originApplication,
        this.postDate,
        this.rowVersion,
        this.tenantSid,
        this.subsidiarySid,
        this.storeNumber,
        this.storeName,
        this.active,
        this.activationDate,
        this.storeCode,
        this.globalStoreCode,
        this.storeTypeSid,
        this.address1,
        this.address2,
        this.address3,
        this.address4,
        this.address5,
        this.zip,
        this.phone1,
        this.phone2,
        this.activePriceLevelSid,
        this.totalSurface,
        this.displaySurface,
        this.windows,
        this.floors,
        this.fullTimeEmployee,
        this.partTimeEmployee,
        this.seasonalEmpl,
        this.salesTargetPercent,
        this.udf1String,
        this.udf2String,
        this.udf3String,
        this.udf4String,
        this.udf5String,
        this.ecommerceCatalog,
        this.webstoreCatalog,
        this.subsidiaryName,
        this.subsidiaryNumber,
        this.activePriceLevel,
        this.taxAreaSid,
        this.taxArea2Sid,
        this.taxAreaName,
        this.taxArea2Name,
        this.workstationss,
        this.employeess,
        this.serverAddress,
        this.address6,
        this.fiscalCode,
        this.hrefs});

  Store.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    sid = json['sid'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
    modifiedBy = json['modified_by'];
    modifiedDatetime = json['modified_datetime'];
    controllerSid = json['controller_sid'];
    originApplication = json['origin_application'];
    postDate = json['post_date'];
    rowVersion = json['row_version'];
    tenantSid = json['tenant_sid'];
    subsidiarySid = json['subsidiary_sid'];
    storeNumber = json['store_number'];
    storeName = json['store_name'];
    active = json['active'];
    activationDate = json['activation_date'];
    storeCode = json['store_code'];
    globalStoreCode = json['global_store_code'];
    storeTypeSid = json['store_type_sid'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    address5 = json['address5'];
    zip = json['zip'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    activePriceLevelSid = json['active_price_level_sid'];
    totalSurface = json['total_surface'];
    displaySurface = json['display_surface'];
    windows = json['windows'];
    floors = json['floors'];
    fullTimeEmployee = json['full_time_employee'];
    partTimeEmployee = json['part_time_employee'];
    seasonalEmpl = json['seasonal_empl'];
    salesTargetPercent = json['sales_target_percent'];
    udf1String = json['udf1_string'];
    udf2String = json['udf2_string'];
    udf3String = json['udf3_string'];
    udf4String = json['udf4_string'];
    udf5String = json['udf5_string'];
    ecommerceCatalog = json['ecommerce_catalog'];
    webstoreCatalog = json['webstore_catalog'];
    subsidiaryName = json['subsidiary_name'];
    subsidiaryNumber = json['subsidiary_number'];
    activePriceLevel = json['active_price_level'];
    taxAreaSid = json['tax_area_sid'];
    taxArea2Sid = json['tax_area2_sid'];
    taxAreaName = json['tax_area_name'];
    taxArea2Name = json['tax_area2_name'];
    if (json['workstationss'] != null) {
      workstationss = <Workstationss>[];
      json['workstationss'].forEach((v) {
        workstationss!.add(new Workstationss.fromJson(v));
      });
    }
    if (json['employeess'] != null) {
      employeess = <Employeess>[];
      json['employeess'].forEach((v) {
        employeess!.add(new Employeess.fromJson(v));
      });
    }
    serverAddress = json['server_address'];
    address6 = json['address6'];
    fiscalCode = json['fiscal_code'];
    hrefs = json['hrefs'] != null ? new Hrefs.fromJson(json['hrefs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['sid'] = this.sid;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    data['modified_by'] = this.modifiedBy;
    data['modified_datetime'] = this.modifiedDatetime;
    data['controller_sid'] = this.controllerSid;
    data['origin_application'] = this.originApplication;
    data['post_date'] = this.postDate;
    data['row_version'] = this.rowVersion;
    data['tenant_sid'] = this.tenantSid;
    data['subsidiary_sid'] = this.subsidiarySid;
    data['store_number'] = this.storeNumber;
    data['store_name'] = this.storeName;
    data['active'] = this.active;
    data['activation_date'] = this.activationDate;
    data['store_code'] = this.storeCode;
    data['global_store_code'] = this.globalStoreCode;
    data['store_type_sid'] = this.storeTypeSid;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['address5'] = this.address5;
    data['zip'] = this.zip;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['active_price_level_sid'] = this.activePriceLevelSid;
    data['total_surface'] = this.totalSurface;
    data['display_surface'] = this.displaySurface;
    data['windows'] = this.windows;
    data['floors'] = this.floors;
    data['full_time_employee'] = this.fullTimeEmployee;
    data['part_time_employee'] = this.partTimeEmployee;
    data['seasonal_empl'] = this.seasonalEmpl;
    data['sales_target_percent'] = this.salesTargetPercent;
    data['udf1_string'] = this.udf1String;
    data['udf2_string'] = this.udf2String;
    data['udf3_string'] = this.udf3String;
    data['udf4_string'] = this.udf4String;
    data['udf5_string'] = this.udf5String;
    data['ecommerce_catalog'] = this.ecommerceCatalog;
    data['webstore_catalog'] = this.webstoreCatalog;
    data['subsidiary_name'] = this.subsidiaryName;
    data['subsidiary_number'] = this.subsidiaryNumber;
    data['active_price_level'] = this.activePriceLevel;
    data['tax_area_sid'] = this.taxAreaSid;
    data['tax_area2_sid'] = this.taxArea2Sid;
    data['tax_area_name'] = this.taxAreaName;
    data['tax_area2_name'] = this.taxArea2Name;
    if (this.workstationss != null) {
      data['workstationss'] =
          this.workstationss!.map((v) => v.toJson()).toList();
    }
    if (this.employeess != null) {
      data['employeess'] = this.employeess!.map((v) => v.toJson()).toList();
    }

    data['server_address'] = this.serverAddress;
    data['address6'] = this.address6;
    data['fiscal_code'] = this.fiscalCode;

    return data;
  }
}

class Workstationss {
  String? link;

  Workstationss({this.link});

  Workstationss.fromJson(Map<String, dynamic> json) {
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    return data;
  }
}

class Employeess {
  String? link;
  String? customerSid;
  Hrefs? hrefs;

  Employeess({this.link, this.customerSid, this.hrefs});

  Employeess.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    customerSid = json['customer_sid'];
    hrefs = json['hrefs'] != null ? new Hrefs.fromJson(json['hrefs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['customer_sid'] = this.customerSid;
    return data;
  }
}

class Hrefs {
  String? customerSid;

  Hrefs({this.customerSid});

  Hrefs.fromJson(Map<String, dynamic> json) {
    customerSid = json['customer_sid'];
  }
}

class Hrefs2 {
  String? controllerSid;
  String? subsidiarySid;

  Hrefs2({this.controllerSid, this.subsidiarySid});

  Hrefs2.fromJson(Map<String, dynamic> json) {
    controllerSid = json['controller_sid'];
    subsidiarySid = json['subsidiary_sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['controller_sid'] = this.controllerSid;
    data['subsidiary_sid'] = this.subsidiarySid;
    return data;
  }
}
