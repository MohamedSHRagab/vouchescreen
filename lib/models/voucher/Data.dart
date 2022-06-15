class DataModel {
  var sid;
  var createdby;
  var createddatetime;
  var modifiedby;
  var modifieddatetime;
  var controllersid;
  var originapplication;
  var postdate;
  var rowversion;
  var tenantsid;
  var invnitemuid;
  var sbssid;
  var alu;
  var stylesid;
  var dcssid;
  var vendsid;
  var description1;
  var description2;
  var description3;
  var description4;
  var longdescription;
  var text1;
  var text2;
  var text3;
  var text4;
  var text5;
  var text6;
  var text7;
  var text8;
  var text9;
  var text10;
  var attribute;
  var cost;
  var spif;
  var currencysid;
  var lastsolddate;
  var markdowndate;
  var discontinueddate;
  var taxcodesid;
  var udf1float;
  var udf2float;
  var udf3float;
  var udf1date;
  var udf2date;
  var udf3date;
  var itemsize;
  var fccost;
  var fstprice;
  var firstrcvddate;
  var lastrcvddate;
  var lastrcvdcost;
  var commsid;
  var discschedulesid;
  var udf1string;
  var udf2string;
  var udf3string;
  var udf4string;
  var udf5string;
  var sellabledate;
  var orderabledate;
  var orderable;
  var useqtydecimals;
  var description;
  var regional;
  var active;
  var qtypercase;
  var upc;
  var maxdiscperc1;
  var maxdiscperc2;
  var itemno;
  var serialtype;
  var lottype;
  var kittype;
  var scalesid;
  var promoqtydiscweight;
  var promoinvenexclude;
  var noninventory;
  var noncommitted;
  var itemstate;
  var publishstatus;
  var ltypriceinpoints;
  var ltypointsearned;
  var minordqty;
  var vendorlistcost;
  var tradediscpercent;
  var forceorigtax;
  var taxcode;
  var activestoresid;
  var activepricelevelsid;
  var activeseasonsid;
  var actstrdbprice;
  var actstrprice;
  var actstrpricewt;
  var actstrohqty;
  var actstrcaseqty;
  var actstrsoldqty;
  var actstrrcvdqty;
  var actstronorderedqty;
  var actstravailqty;
  var actstrextcost;
  var actstrextprice;
  var actstrextpricewt;
  var actstrtaxpctg;
  var actstrtaxamt;
  var actstrtaxpctg2;
  var actstrtaxamt2;
  var actstrexttaxamt;
  var actstrexttaxamt1;
  var actstrexttaxamt2;
  var actstrmarginpctg;
  var actstrmarginamt;
  var actstrextmarginamt;
  var actstrmarginamtwt;
  var actstrextmarginamtwt;
  var actstrmarkuppctg;
  var actstrcoefficient;
  var actstrminqty;
  var actstrmaxqty;
  var actstrminextcost;
  var actstrminextprice;
  var actstrminextpricewt;
  var actstrmaxextcost;
  var actstrmaxextprice;
  var actstrmaxextpricewt;
  var cmpstrohqty;
  var cmpstrextcost;
  var cmpstrextprice;
  var cmpstrminqty;
  var cmpstrminextcost;
  var cmpstrminextprice;
  var cmpstrminextpricewt;
  var cmpstrmaxqty;
  var cmpstrmaxextcost;
  var cmpstrmaxextprice;
  var cmpstrmaxextpricewt;
  var udf12string;
  var udf8string;
  var udf13string;
  var udf9string;
  var udf10string;
  var udf11string;
  var udf2largestring;
  var udf14string;
  var udf15string;
  var udf1largestring;
  var udf6string;
  var udf7string;
  var dcscode;
  var sbsno;
  var sbsname;
  var scaleno;
  var scalename;
  var vendorcode;
  var vendorname;
  var vendorid;
  var taxname;
  var currencyalphacode;
  var imagepath;
  var cname;
  var dname;
  var sname;
  var docitemsid;
  var docitemrowversion;
  var height;
  var length;
  var width;
  var specialorder;
  var measureunit;
  var shipmeasurement1;
  var shipmeasurement2;
  var docqty;
  var doccaseqty;
  var docprice;
  var doccost;
  var defaultprice;
  var defaultpricewt;
  var itemimage;
  var itemimageindex;
  var actstrqtysid;
  var actstrqtyrowver;
  var mmsid;
  var actstrmmqtysid;
  var actstrmmqtyrowver;
  var actstrnewminqty;
  var actstrnewmaxqty;
  var actstrmmbegindate;
  var actstrmmenddate;

  DataModel(
      {this.sid,
        this.createdby,
        this.createddatetime,
        this.modifiedby,
        this.modifieddatetime,
        this.controllersid,
        this.originapplication,
        this.postdate,
        this.rowversion,
        this.tenantsid,
        this.invnitemuid,
        this.sbssid,
        this.alu,
        this.stylesid,
        this.dcssid,
        this.vendsid,
        this.description1,
        this.description2,
        this.description3,
        this.description4,
        this.longdescription,
        this.text1,
        this.text2,
        this.text3,
        this.text4,
        this.text5,
        this.text6,
        this.text7,
        this.text8,
        this.text9,
        this.text10,
        this.attribute,
        this.cost,
        this.spif,
        this.currencysid,
        this.lastsolddate,
        this.markdowndate,
        this.discontinueddate,
        this.taxcodesid,
        this.udf1float,
        this.udf2float,
        this.udf3float,
        this.udf1date,
        this.udf2date,
        this.udf3date,
        this.itemsize,
        this.fccost,
        this.fstprice,
        this.firstrcvddate,
        this.lastrcvddate,
        this.lastrcvdcost,
        this.commsid,
        this.discschedulesid,
        this.udf1string,
        this.udf2string,
        this.udf3string,
        this.udf4string,
        this.udf5string,
        this.sellabledate,
        this.orderabledate,
        this.orderable,
        this.useqtydecimals,
        this.description,
        this.regional,
        this.active,
        this.qtypercase,
        this.upc,
        this.maxdiscperc1,
        this.maxdiscperc2,
        this.itemno,
        this.serialtype,
        this.lottype,
        this.kittype,
        this.scalesid,
        this.promoqtydiscweight,
        this.promoinvenexclude,
        this.noninventory,
        this.noncommitted,
        this.itemstate,
        this.publishstatus,
        this.ltypriceinpoints,
        this.ltypointsearned,
        this.minordqty,
        this.vendorlistcost,
        this.tradediscpercent,
        this.forceorigtax,
        this.taxcode,
        this.activestoresid,
        this.activepricelevelsid,
        this.activeseasonsid,
        this.actstrdbprice,
        this.actstrprice,
        this.actstrpricewt,
        this.actstrohqty,
        this.actstrcaseqty,
        this.actstrsoldqty,
        this.actstrrcvdqty,
        this.actstronorderedqty,
        this.actstravailqty,
        this.actstrextcost,
        this.actstrextprice,
        this.actstrextpricewt,
        this.actstrtaxpctg,
        this.actstrtaxamt,
        this.actstrtaxpctg2,
        this.actstrtaxamt2,
        this.actstrexttaxamt,
        this.actstrexttaxamt1,
        this.actstrexttaxamt2,
        this.actstrmarginpctg,
        this.actstrmarginamt,
        this.actstrextmarginamt,
        this.actstrmarginamtwt,
        this.actstrextmarginamtwt,
        this.actstrmarkuppctg,
        this.actstrcoefficient,
        this.actstrminqty,
        this.actstrmaxqty,
        this.actstrminextcost,
        this.actstrminextprice,
        this.actstrminextpricewt,
        this.actstrmaxextcost,
        this.actstrmaxextprice,
        this.actstrmaxextpricewt,
        this.cmpstrohqty,
        this.cmpstrextcost,
        this.cmpstrextprice,
        this.cmpstrminqty,
        this.cmpstrminextcost,
        this.cmpstrminextprice,
        this.cmpstrminextpricewt,
        this.cmpstrmaxqty,
        this.cmpstrmaxextcost,
        this.cmpstrmaxextprice,
        this.cmpstrmaxextpricewt,
        this.udf12string,
        this.udf8string,
        this.udf13string,
        this.udf9string,
        this.udf10string,
        this.udf11string,
        this.udf2largestring,
        this.udf14string,
        this.udf15string,
        this.udf1largestring,
        this.udf6string,
        this.udf7string,
        this.dcscode,
        this.sbsno,
        this.sbsname,
        this.scaleno,
        this.scalename,
        this.vendorcode,
        this.vendorname,
        this.vendorid,
        this.taxname,
        this.currencyalphacode,
        this.imagepath,
        this.cname,
        this.dname,
        this.sname,
        this.docitemsid,
        this.docitemrowversion,
        this.height,
        this.length,
        this.width,
        this.specialorder,
        this.measureunit,
        this.shipmeasurement1,
        this.shipmeasurement2,
        this.docqty,
        this.doccaseqty,
        this.docprice,
        this.doccost,
        this.defaultprice,
        this.defaultpricewt,
        this.itemimage,
        this.itemimageindex,
        this.actstrqtysid,
        this.actstrqtyrowver,
        this.mmsid,
        this.actstrmmqtysid,
        this.actstrmmqtyrowver,
        this.actstrnewminqty,
        this.actstrnewmaxqty,
        this.actstrmmbegindate,
        this.actstrmmenddate});

  DataModel.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    createdby = json['createdby'];
    createddatetime = json['createddatetime'];
    modifiedby = json['modifiedby'];
    modifieddatetime = json['modifieddatetime'];
    controllersid = json['controllersid'];
    originapplication = json['originapplication'];
    postdate = json['postdate'];
    rowversion = json['rowversion'];
    tenantsid = json['tenantsid'];
    invnitemuid = json['invnitemuid'];
    sbssid = json['sbssid'];
    alu = json['alu'];
    stylesid = json['stylesid'];
    dcssid = json['dcssid'];
    vendsid = json['vendsid'];
    description1 = json['description1'];
    description2 = json['description2'];
    description3 = json['description3'];
    description4 = json['description4'];
    longdescription = json['longdescription'];
    text1 = json['text1'];
    text2 = json['text2'];
    text3 = json['text3'];
    text4 = json['text4'];
    text5 = json['text5'];
    text6 = json['text6'];
    text7 = json['text7'];
    text8 = json['text8'];
    text9 = json['text9'];
    text10 = json['text10'];
    attribute = json['attribute'];
    cost = json['cost'];
    spif = json['spif'];
    currencysid = json['currencysid'];
    lastsolddate = json['lastsolddate'];
    markdowndate = json['markdowndate'];
    discontinueddate = json['discontinueddate'];
    taxcodesid = json['taxcodesid'];
    udf1float = json['udf1float'];
    udf2float = json['udf2float'];
    udf3float = json['udf3float'];
    udf1date = json['udf1date'];
    udf2date = json['udf2date'];
    udf3date = json['udf3date'];
    itemsize = json['itemsize'];
    fccost = json['fccost'];
    fstprice = json['fstprice'];
    firstrcvddate = json['firstrcvddate'];
    lastrcvddate = json['lastrcvddate'];
    lastrcvdcost = json['lastrcvdcost'];
    commsid = json['commsid'];
    discschedulesid = json['discschedulesid'];
    udf1string = json['udf1string'];
    udf2string = json['udf2string'];
    udf3string = json['udf3string'];
    udf4string = json['udf4string'];
    udf5string = json['udf5string'];
    sellabledate = json['sellabledate'];
    orderabledate = json['orderabledate'];
    orderable = json['orderable'];
    useqtydecimals = json['useqtydecimals'];
    description = json['description'];
    regional = json['regional'];
    active = json['active'];
    qtypercase = json['qtypercase'];
    upc = json['upc'];
    maxdiscperc1 = json['maxdiscperc1'];
    maxdiscperc2 = json['maxdiscperc2'];
    itemno = json['itemno'];
    serialtype = json['serialtype'];
    lottype = json['lottype'];
    kittype = json['kittype'];
    scalesid = json['scalesid'];
    promoqtydiscweight = json['promoqtydiscweight'];
    promoinvenexclude = json['promoinvenexclude'];
    noninventory = json['noninventory'];
    noncommitted = json['noncommitted'];
    itemstate = json['itemstate'];
    publishstatus = json['publishstatus'];
    ltypriceinpoints = json['ltypriceinpoints'];
    ltypointsearned = json['ltypointsearned'];
    minordqty = json['minordqty'];
    vendorlistcost = json['vendorlistcost'];
    tradediscpercent = json['tradediscpercent'];
    forceorigtax = json['forceorigtax'];
    taxcode = json['taxcode'];
    activestoresid = json['activestoresid'];
    activepricelevelsid = json['activepricelevelsid'];
    activeseasonsid = json['activeseasonsid'];
    actstrdbprice = json['actstrdbprice'];
    actstrprice = json['actstrprice'];
    actstrpricewt = json['actstrpricewt'];
    actstrohqty = json['actstrohqty'];
    actstrcaseqty = json['actstrcaseqty'];
    actstrsoldqty = json['actstrsoldqty'];
    actstrrcvdqty = json['actstrrcvdqty'];
    actstronorderedqty = json['actstronorderedqty'];
    actstravailqty = json['actstravailqty'];
    actstrextcost = json['actstrextcost'];
    actstrextprice = json['actstrextprice'];
    actstrextpricewt = json['actstrextpricewt'];
    actstrtaxpctg = json['actstrtaxpctg'];
    actstrtaxamt = json['actstrtaxamt'];
    actstrtaxpctg2 = json['actstrtaxpctg2'];
    actstrtaxamt2 = json['actstrtaxamt2'];
    actstrexttaxamt = json['actstrexttaxamt'];
    actstrexttaxamt1 = json['actstrexttaxamt1'];
    actstrexttaxamt2 = json['actstrexttaxamt2'];
    actstrmarginpctg = json['actstrmarginpctg'];
    actstrmarginamt = json['actstrmarginamt'];
    actstrextmarginamt = json['actstrextmarginamt'];
    actstrmarginamtwt = json['actstrmarginamtwt'];
    actstrextmarginamtwt = json['actstrextmarginamtwt'];
    actstrmarkuppctg = json['actstrmarkuppctg'];
    actstrcoefficient = json['actstrcoefficient'];
    actstrminqty = json['actstrminqty'];
    actstrmaxqty = json['actstrmaxqty'];
    actstrminextcost = json['actstrminextcost'];
    actstrminextprice = json['actstrminextprice'];
    actstrminextpricewt = json['actstrminextpricewt'];
    actstrmaxextcost = json['actstrmaxextcost'];
    actstrmaxextprice = json['actstrmaxextprice'];
    actstrmaxextpricewt = json['actstrmaxextpricewt'];
    cmpstrohqty = json['cmpstrohqty'];
    cmpstrextcost = json['cmpstrextcost'];
    cmpstrextprice = json['cmpstrextprice'];
    cmpstrminqty = json['cmpstrminqty'];
    cmpstrminextcost = json['cmpstrminextcost'];
    cmpstrminextprice = json['cmpstrminextprice'];
    cmpstrminextpricewt = json['cmpstrminextpricewt'];
    cmpstrmaxqty = json['cmpstrmaxqty'];
    cmpstrmaxextcost = json['cmpstrmaxextcost'];
    cmpstrmaxextprice = json['cmpstrmaxextprice'];
    cmpstrmaxextpricewt = json['cmpstrmaxextpricewt'];
    udf12string = json['udf12string'];
    udf8string = json['udf8string'];
    udf13string = json['udf13string'];
    udf9string = json['udf9string'];
    udf10string = json['udf10string'];
    udf11string = json['udf11string'];
    udf2largestring = json['udf2largestring'];
    udf14string = json['udf14string'];
    udf15string = json['udf15string'];
    udf1largestring = json['udf1largestring'];
    udf6string = json['udf6string'];
    udf7string = json['udf7string'];
    dcscode = json['dcscode'];
    sbsno = json['sbsno'];
    sbsname = json['sbsname'];
    scaleno = json['scaleno'];
    scalename = json['scalename'];
    vendorcode = json['vendorcode'];
    vendorname = json['vendorname'];
    vendorid = json['vendorid'];
    taxname = json['taxname'];
    currencyalphacode = json['currencyalphacode'];
    imagepath = json['imagepath'];
    cname = json['cname'];
    dname = json['dname'];
    sname = json['sname'];
    docitemsid = json['docitemsid'];
    docitemrowversion = json['docitemrowversion'];
    height = json['height'];
    length = json['length'];
    width = json['width'];
    specialorder = json['specialorder'];
    measureunit = json['measureunit'];
    shipmeasurement1 = json['shipmeasurement1'];
    shipmeasurement2 = json['shipmeasurement2'];
    docqty = json['docqty'];
    doccaseqty = json['doccaseqty'];
    docprice = json['docprice'];
    doccost = json['doccost'];
    defaultprice = json['defaultprice'];
    defaultpricewt = json['defaultpricewt'];
    itemimage = json['itemimage'];
    itemimageindex = json['itemimageindex'];
    actstrqtysid = json['actstrqtysid'];
    actstrqtyrowver = json['actstrqtyrowver'];
    mmsid = json['mmsid'];
    actstrmmqtysid = json['actstrmmqtysid'];
    actstrmmqtyrowver = json['actstrmmqtyrowver'];
    actstrnewminqty = json['actstrnewminqty'];
    actstrnewmaxqty = json['actstrnewmaxqty'];
    actstrmmbegindate = json['actstrmmbegindate'];
    actstrmmenddate = json['actstrmmenddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['createdby'] = this.createdby;
    data['createddatetime'] = this.createddatetime;
    data['modifiedby'] = this.modifiedby;
    data['modifieddatetime'] = this.modifieddatetime;
    data['controllersid'] = this.controllersid;
    data['originapplication'] = this.originapplication;
    data['postdate'] = this.postdate;
    data['rowversion'] = this.rowversion;
    data['tenantsid'] = this.tenantsid;
    data['invnitemuid'] = this.invnitemuid;
    data['sbssid'] = this.sbssid;
    data['alu'] = this.alu;
    data['stylesid'] = this.stylesid;
    data['dcssid'] = this.dcssid;
    data['vendsid'] = this.vendsid;
    data['description1'] = this.description1;
    data['description2'] = this.description2;
    data['description3'] = this.description3;
    data['description4'] = this.description4;
    data['longdescription'] = this.longdescription;
    data['text1'] = this.text1;
    data['text2'] = this.text2;
    data['text3'] = this.text3;
    data['text4'] = this.text4;
    data['text5'] = this.text5;
    data['text6'] = this.text6;
    data['text7'] = this.text7;
    data['text8'] = this.text8;
    data['text9'] = this.text9;
    data['text10'] = this.text10;
    data['attribute'] = this.attribute;
    data['cost'] = this.cost;
    data['spif'] = this.spif;
    data['currencysid'] = this.currencysid;
    data['lastsolddate'] = this.lastsolddate;
    data['markdowndate'] = this.markdowndate;
    data['discontinueddate'] = this.discontinueddate;
    data['taxcodesid'] = this.taxcodesid;
    data['udf1float'] = this.udf1float;
    data['udf2float'] = this.udf2float;
    data['udf3float'] = this.udf3float;
    data['udf1date'] = this.udf1date;
    data['udf2date'] = this.udf2date;
    data['udf3date'] = this.udf3date;
    data['itemsize'] = this.itemsize;
    data['fccost'] = this.fccost;
    data['fstprice'] = this.fstprice;
    data['firstrcvddate'] = this.firstrcvddate;
    data['lastrcvddate'] = this.lastrcvddate;
    data['lastrcvdcost'] = this.lastrcvdcost;
    data['commsid'] = this.commsid;
    data['discschedulesid'] = this.discschedulesid;
    data['udf1string'] = this.udf1string;
    data['udf2string'] = this.udf2string;
    data['udf3string'] = this.udf3string;
    data['udf4string'] = this.udf4string;
    data['udf5string'] = this.udf5string;
    data['sellabledate'] = this.sellabledate;
    data['orderabledate'] = this.orderabledate;
    data['orderable'] = this.orderable;
    data['useqtydecimals'] = this.useqtydecimals;
    data['description'] = this.description;
    data['regional'] = this.regional;
    data['active'] = this.active;
    data['qtypercase'] = this.qtypercase;
    data['upc'] = this.upc;
    data['maxdiscperc1'] = this.maxdiscperc1;
    data['maxdiscperc2'] = this.maxdiscperc2;
    data['itemno'] = this.itemno;
    data['serialtype'] = this.serialtype;
    data['lottype'] = this.lottype;
    data['kittype'] = this.kittype;
    data['scalesid'] = this.scalesid;
    data['promoqtydiscweight'] = this.promoqtydiscweight;
    data['promoinvenexclude'] = this.promoinvenexclude;
    data['noninventory'] = this.noninventory;
    data['noncommitted'] = this.noncommitted;
    data['itemstate'] = this.itemstate;
    data['publishstatus'] = this.publishstatus;
    data['ltypriceinpoints'] = this.ltypriceinpoints;
    data['ltypointsearned'] = this.ltypointsearned;
    data['minordqty'] = this.minordqty;
    data['vendorlistcost'] = this.vendorlistcost;
    data['tradediscpercent'] = this.tradediscpercent;
    data['forceorigtax'] = this.forceorigtax;
    data['taxcode'] = this.taxcode;
    data['activestoresid'] = this.activestoresid;
    data['activepricelevelsid'] = this.activepricelevelsid;
    data['activeseasonsid'] = this.activeseasonsid;
    data['actstrdbprice'] = this.actstrdbprice;
    data['actstrprice'] = this.actstrprice;
    data['actstrpricewt'] = this.actstrpricewt;
    data['actstrohqty'] = this.actstrohqty;
    data['actstrcaseqty'] = this.actstrcaseqty;
    data['actstrsoldqty'] = this.actstrsoldqty;
    data['actstrrcvdqty'] = this.actstrrcvdqty;
    data['actstronorderedqty'] = this.actstronorderedqty;
    data['actstravailqty'] = this.actstravailqty;
    data['actstrextcost'] = this.actstrextcost;
    data['actstrextprice'] = this.actstrextprice;
    data['actstrextpricewt'] = this.actstrextpricewt;
    data['actstrtaxpctg'] = this.actstrtaxpctg;
    data['actstrtaxamt'] = this.actstrtaxamt;
    data['actstrtaxpctg2'] = this.actstrtaxpctg2;
    data['actstrtaxamt2'] = this.actstrtaxamt2;
    data['actstrexttaxamt'] = this.actstrexttaxamt;
    data['actstrexttaxamt1'] = this.actstrexttaxamt1;
    data['actstrexttaxamt2'] = this.actstrexttaxamt2;
    data['actstrmarginpctg'] = this.actstrmarginpctg;
    data['actstrmarginamt'] = this.actstrmarginamt;
    data['actstrextmarginamt'] = this.actstrextmarginamt;
    data['actstrmarginamtwt'] = this.actstrmarginamtwt;
    data['actstrextmarginamtwt'] = this.actstrextmarginamtwt;
    data['actstrmarkuppctg'] = this.actstrmarkuppctg;
    data['actstrcoefficient'] = this.actstrcoefficient;
    data['actstrminqty'] = this.actstrminqty;
    data['actstrmaxqty'] = this.actstrmaxqty;
    data['actstrminextcost'] = this.actstrminextcost;
    data['actstrminextprice'] = this.actstrminextprice;
    data['actstrminextpricewt'] = this.actstrminextpricewt;
    data['actstrmaxextcost'] = this.actstrmaxextcost;
    data['actstrmaxextprice'] = this.actstrmaxextprice;
    data['actstrmaxextpricewt'] = this.actstrmaxextpricewt;
    data['cmpstrohqty'] = this.cmpstrohqty;
    data['cmpstrextcost'] = this.cmpstrextcost;
    data['cmpstrextprice'] = this.cmpstrextprice;
    data['cmpstrminqty'] = this.cmpstrminqty;
    data['cmpstrminextcost'] = this.cmpstrminextcost;
    data['cmpstrminextprice'] = this.cmpstrminextprice;
    data['cmpstrminextpricewt'] = this.cmpstrminextpricewt;
    data['cmpstrmaxqty'] = this.cmpstrmaxqty;
    data['cmpstrmaxextcost'] = this.cmpstrmaxextcost;
    data['cmpstrmaxextprice'] = this.cmpstrmaxextprice;
    data['cmpstrmaxextpricewt'] = this.cmpstrmaxextpricewt;
    data['udf12string'] = this.udf12string;
    data['udf8string'] = this.udf8string;
    data['udf13string'] = this.udf13string;
    data['udf9string'] = this.udf9string;
    data['udf10string'] = this.udf10string;
    data['udf11string'] = this.udf11string;
    data['udf2largestring'] = this.udf2largestring;
    data['udf14string'] = this.udf14string;
    data['udf15string'] = this.udf15string;
    data['udf1largestring'] = this.udf1largestring;
    data['udf6string'] = this.udf6string;
    data['udf7string'] = this.udf7string;
    data['dcscode'] = this.dcscode;
    data['sbsno'] = this.sbsno;
    data['sbsname'] = this.sbsname;
    data['scaleno'] = this.scaleno;
    data['scalename'] = this.scalename;
    data['vendorcode'] = this.vendorcode;
    data['vendorname'] = this.vendorname;
    data['vendorid'] = this.vendorid;
    data['taxname'] = this.taxname;
    data['currencyalphacode'] = this.currencyalphacode;
    data['imagepath'] = this.imagepath;
    data['cname'] = this.cname;
    data['dname'] = this.dname;
    data['sname'] = this.sname;
    data['docitemsid'] = this.docitemsid;
    data['docitemrowversion'] = this.docitemrowversion;
    data['height'] = this.height;
    data['length'] = this.length;
    data['width'] = this.width;
    data['specialorder'] = this.specialorder;
    data['measureunit'] = this.measureunit;
    data['shipmeasurement1'] = this.shipmeasurement1;
    data['shipmeasurement2'] = this.shipmeasurement2;
    data['docqty'] = this.docqty;
    data['doccaseqty'] = this.doccaseqty;
    data['docprice'] = this.docprice;
    data['doccost'] = this.doccost;
    data['defaultprice'] = this.defaultprice;
    data['defaultpricewt'] = this.defaultpricewt;
    data['itemimage'] = this.itemimage;
    data['itemimageindex'] = this.itemimageindex;
    data['actstrqtysid'] = this.actstrqtysid;
    data['actstrqtyrowver'] = this.actstrqtyrowver;
    data['mmsid'] = this.mmsid;
    data['actstrmmqtysid'] = this.actstrmmqtysid;
    data['actstrmmqtyrowver'] = this.actstrmmqtyrowver;
    data['actstrnewminqty'] = this.actstrnewminqty;
    data['actstrnewmaxqty'] = this.actstrnewmaxqty;
    data['actstrmmbegindate'] = this.actstrmmbegindate;
    data['actstrmmenddate'] = this.actstrmmenddate;
    return data;
  }
}
