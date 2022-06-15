class Hrefs {
  String? subsidiarySid;
  String? dcsSid;
  String? controllerSid;
  String? vendorSid;
  String? taxCodeSid;

  Hrefs(
      {this.subsidiarySid,
        this.dcsSid,
        this.controllerSid,
        this.vendorSid,
        this.taxCodeSid});

  Hrefs.fromJson(Map<String, dynamic> json) {
    subsidiarySid = json['subsidiary_sid'];
    dcsSid = json['dcs_sid'];
    controllerSid = json['controller_sid'];
    vendorSid = json['vendor_sid'];
    taxCodeSid = json['tax_code_sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subsidiary_sid'] = this.subsidiarySid;
    data['dcs_sid'] = this.dcsSid;
    data['controller_sid'] = this.controllerSid;
    data['vendor_sid'] = this.vendorSid;
    data['tax_code_sid'] = this.taxCodeSid;
    return data;
  }
}