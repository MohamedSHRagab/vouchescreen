class Sbsinventoryprices {
  String? link;
  var marginAmt;
  var marginWithTaxAmt;
  var marginPercent;
  var markupPercent;
  var coefficient;
  var price;

  Sbsinventoryprices(
      {this.link,
        this.marginAmt,
        this.marginWithTaxAmt,
        this.marginPercent,
        this.markupPercent,
        this.price});

  Sbsinventoryprices.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    marginAmt = json['margin_amt'];
    marginWithTaxAmt = json['margin_with_tax_amt'];
    marginPercent = json['margin_percent'];
    markupPercent = json['markup_percent'];
    coefficient = json['coefficient'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['margin_amt'] = this.marginAmt;
    data['margin_with_tax_amt'] = this.marginWithTaxAmt;
    data['margin_percent'] = this.marginPercent;
    data['markup_percent'] = this.markupPercent;
    data['coefficient'] = this.coefficient;
    data['price'] = this.price;
    return data;
  }
}


