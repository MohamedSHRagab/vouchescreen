import 'dart:core';

class ProductInfo {
  String id;
  String itemsid;
  String alu;
  String upc;
  String vendcode;
  String description;
  String flag;
  var flag_val;
  var bouns;
  var price;
  var ext_price;
  var cost;
  var ext_cost;
  var itemcost;
  var quantity;
  var storequantity;
  var margin;
  var ext_margin;
  var origincost;
  var lotDate;
  var lotNote;
  var checked;
  var tax_perc;
  var tax_ext;
  var totalcostwithtax;
  var lot_type;
  var lot_number;
  var serial;
  bool added;


  ProductInfo(
      this.id,
      this.itemsid,
      this.alu,
      this.upc,
      this.vendcode,
      this.description,
      this.flag,
      this.flag_val,
      this.bouns,
      this.price,
      this.ext_price,
      this.cost,
      this.ext_cost,
      this.itemcost,
      this.origincost,
      this.quantity,
      this.storequantity,
      this.margin,
      this.ext_margin,
      this.lotDate,
      this.lotNote,
      this.checked,
      this.tax_perc,
      this.tax_ext,
      this.totalcostwithtax,
      this.lot_type,
      this.lot_number,
      this.serial,
      this.added,





      );
}
