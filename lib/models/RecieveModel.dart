class RecieveModel {
  var name;
  var metatype;
  var comment;
  var translationid;
  var errors;
  List<Data>? data;

  RecieveModel(
      {this.name,
        this.metatype,
        this.comment,
        this.translationid,
        this.errors,
        this.data});

  RecieveModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    metatype = json['metatype'];
    comment = json['comment'];
    translationid = json['translationid'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['metatype'] = this.metatype;
    data['comment'] = this.comment;
    data['translationid'] = this.translationid;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  var sbssid;
  var storesid;
  var vouno;
  var voutype;
  var vouclass;
  var vendsid;
  var payeesid;
  var vendacctno;
  var vendorinvoicesid;
  var clerksid;
  var station;
  var workstation;
  var origstoresid;
  var origstation;
  var status;
  var procstatus;
  var pono;
  var tono;
  var pkgno;
  var shipmentno;
  var costhandlingcode;
  var updatepriceflag;
  var usevat;
  var discperc;
  var discamt;
  var taxpercincl;
  var taxamtincl;
  var taxpercexcl;
  var taxamtexcl;
  var arriveddate;
  var custfld;
  var seasonsid;
  var refvousid;
  var audited;
  var cms;
  var verified;
  var purchclearamt;
  var cmspostdate;
  var reviewbysid;
  var reviewdate;
  var reviewnote;
  var approvbysid;
  var approvdate;
  var wsseqno;
  var held;
  var active;
  var rate;
  var carrierid;
  var controller;
  var origcontroller;
  var createdbysid;
  var  modifiedbysid;
  var  alextractdate;
  var  alpostdate;
  var  docrefno;
  var slipflag;
  var approvnotes;
  var approvstatus;
  var pendingoverride;
  var trackingno;
  var transreasonid;
  var voureasonsid;
  var contractdate;
  var asnno;
  var archived;
  var taxareasid;
  var taxarea2sid;
  var resolvstatus;
  var resolvsid;
  var note;
  var noofpkgs;
  var posid;
  var tosid;
  var asnsid;
  var refdocsid;
  var vousubtotal;
  var voutotal;
  var disctype;
  var taxincltype;
  var taxexcltype;
  var brmarked;
  var publishstatus;
  var reversedflag;
  var slipsbssid;
  var slipstoresid;
  var lineitems;
  var totalqty;
  var doctotalcost;
  var totalpackages;
  var totalpackagesreceived;
  var voucherqtydiff;
  var itemcostdiff;
  var lineitemsdiff;
  var serialdiff;
  var lotdiff;
  var taxarea;
  var taxarea2;
  var vendoraddress1;
  var vendoraddress2;
  var vendoraddress3;
  var vendoraddress4;
  var vendoraddress5;
  var vendoraddress6;
  var vendorcity;
  var vendorstate;
  var vendorpostalcode;
  var vendorpostalcodeextension;
  var vendoraddress;
  var origstoreaddress;
  var origstoreno;
  var origaddress1;
  var origaddress2;
  var origaddress3;
  var origaddress4;
  var origaddress5;
  var origstorename;
  var origstoreudf1string;
  var origstoreudf2string;
  var origstoreudf3string;
  var origstoreudf4string;
  var origstoreudf5string;
  var origzip;
  var orderdate;
  var canceldate;
  var vendcode;
  var vendname;
  var vendid;
  var payeecode;
  var sbsno;
  var storeno;
  var clerkname;
  var modifiedbyemplid;
  var modifiedbyemplname;
  var createdbyemplname;
  var approvedbyemplname;
  var vendinvcid;
  var vendinvcno;
  var vendinvcdate;
  var address1;
  var address2;
  var address3;
  var address4;
  var address5;
  var storename;
  var zip;
  var vendorudf1string;
  var vendorudf2string;
  var vendorudf3string;
  var vendorudf4string;
  var vendorudf5string;
  var vendorudf6string;
  var vendorudf1date;
  var vendorudf2date;
  var storeudf1string;
  var storeudf2string;
  var storeudf3string;
  var storeudf4string;
  var storeudf5string;
  var reasonname;
  var reasontype;
  var origintimezone;
  var seasoncode;
  var clerkorigsbsno;
  var approvedbyorigsbsno;
  var createdbyorigsbsno;
  var  modifiedbyorigsbsno;
  var  slipsbsno;
  var  slipstoreno;
  var  slipsid;
  var  slipno;
  var slipreversedflag;
  var storecode;
  var origstorecode;
  var slipstorecode;
  var storephone1;
  var origstorephone1;
  var slipstorephone1;
  var storephone2;
  var origstorephone2;
  var slipstorephone2;
  var pcflag;
  var apflag;
  var glflag;

  Data(
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
        this.sbssid,
        this.storesid,
        this.vouno,
        this.voutype,
        this.vouclass,
        this.vendsid,
        this.payeesid,
        this.vendacctno,
        this.vendorinvoicesid,
        this.clerksid,
        this.station,
        this.workstation,
        this.origstoresid,
        this.origstation,
        this.status,
        this.procstatus,
        this.pono,
        this.tono,
        this.pkgno,
        this.shipmentno,
        this.costhandlingcode,
        this.updatepriceflag,
        this.usevat,
        this.discperc,
        this.discamt,
        this.taxpercincl,
        this.taxamtincl,
        this.taxpercexcl,
        this.taxamtexcl,
        this.arriveddate,
        this.custfld,
        this.seasonsid,
        this.refvousid,
        this.audited,
        this.cms,
        this.verified,
        this.purchclearamt,
        this.cmspostdate,
        this.reviewbysid,
        this.reviewdate,
        this.reviewnote,
        this.approvbysid,
        this.approvdate,
        this.wsseqno,
        this.held,
        this.active,
        this.rate,
        this.carrierid,
        this.controller,
        this.origcontroller,
        this.createdbysid,
        this.modifiedbysid,
        this.alextractdate,
        this.alpostdate,
        this.docrefno,
        this.slipflag,
        this.approvnotes,
        this.approvstatus,
        this.pendingoverride,
        this.trackingno,
        this.transreasonid,
        this.voureasonsid,
        this.contractdate,
        this.asnno,
        this.archived,
        this.taxareasid,
        this.taxarea2sid,
        this.resolvstatus,
        this.resolvsid,
        this.note,
        this.noofpkgs,
        this.posid,
        this.tosid,
        this.asnsid,
        this.refdocsid,
        this.vousubtotal,
        this.voutotal,
        this.disctype,
        this.taxincltype,
        this.taxexcltype,
        this.brmarked,
        this.publishstatus,
        this.reversedflag,
        this.slipsbssid,
        this.slipstoresid,
        this.lineitems,
        this.totalqty,
        this.doctotalcost,
        this.totalpackages,
        this.totalpackagesreceived,
        this.voucherqtydiff,
        this.itemcostdiff,
        this.lineitemsdiff,
        this.serialdiff,
        this.lotdiff,
        this.taxarea,
        this.taxarea2,
        this.vendoraddress1,
        this.vendoraddress2,
        this.vendoraddress3,
        this.vendoraddress4,
        this.vendoraddress5,
        this.vendoraddress6,
        this.vendorcity,
        this.vendorstate,
        this.vendorpostalcode,
        this.vendorpostalcodeextension,
        this.vendoraddress,
        this.origstoreaddress,
        this.origstoreno,
        this.origaddress1,
        this.origaddress2,
        this.origaddress3,
        this.origaddress4,
        this.origaddress5,
        this.origstorename,
        this.origstoreudf1string,
        this.origstoreudf2string,
        this.origstoreudf3string,
        this.origstoreudf4string,
        this.origstoreudf5string,
        this.origzip,
        this.orderdate,
        this.canceldate,
        this.vendcode,
        this.vendname,
        this.vendid,
        this.payeecode,
        this.sbsno,
        this.storeno,
        this.clerkname,
        this.modifiedbyemplid,
        this.modifiedbyemplname,
        this.createdbyemplname,
        this.approvedbyemplname,
        this.vendinvcid,
        this.vendinvcno,
        this.vendinvcdate,
        this.address1,
        this.address2,
        this.address3,
        this.address4,
        this.address5,
        this.storename,
        this.zip,
        this.vendorudf1string,
        this.vendorudf2string,
        this.vendorudf3string,
        this.vendorudf4string,
        this.vendorudf5string,
        this.vendorudf6string,
        this.vendorudf1date,
        this.vendorudf2date,
        this.storeudf1string,
        this.storeudf2string,
        this.storeudf3string,
        this.storeudf4string,
        this.storeudf5string,
        this.reasonname,
        this.reasontype,
        this.origintimezone,
        this.seasoncode,
        this.clerkorigsbsno,
        this.approvedbyorigsbsno,
        this.createdbyorigsbsno,
        this.modifiedbyorigsbsno,
        this.slipsbsno,
        this.slipstoreno,
        this.slipsid,
        this.slipno,
        this.slipreversedflag,
        this.storecode,
        this.origstorecode,
        this.slipstorecode,
        this.storephone1,
        this.origstorephone1,
        this.slipstorephone1,
        this.storephone2,
        this.origstorephone2,
        this.slipstorephone2,
        this.pcflag,
        this.apflag,
        this.glflag});

  Data.fromJson(Map<String, dynamic> json) {
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
    sbssid = json['sbssid'];
    storesid = json['storesid'];
    vouno = json['vouno'];
    voutype = json['voutype'];
    vouclass = json['vouclass'];
    vendsid = json['vendsid'];
    payeesid = json['payeesid'];
    vendacctno = json['vendacctno'];
    vendorinvoicesid = json['vendorinvoicesid'];
    clerksid = json['clerksid'];
    station = json['station'];
    workstation = json['workstation'];
    origstoresid = json['origstoresid'];
    origstation = json['origstation'];
    status = json['status'];
    procstatus = json['procstatus'];
    pono = json['pono'];
    tono = json['tono'];
    pkgno = json['pkgno'];
    shipmentno = json['shipmentno'];
    costhandlingcode = json['costhandlingcode'];
    updatepriceflag = json['updatepriceflag'];
    usevat = json['usevat'];
    discperc = json['discperc'];
    discamt = json['discamt'];
    taxpercincl = json['taxpercincl'];
    taxamtincl = json['taxamtincl'];
    taxpercexcl = json['taxpercexcl'];
    taxamtexcl = json['taxamtexcl'];
    arriveddate = json['arriveddate'];
    custfld = json['custfld'];
    seasonsid = json['seasonsid'];
    refvousid = json['refvousid'];
    audited = json['audited'];
    cms = json['cms'];
    verified = json['verified'];
    purchclearamt = json['purchclearamt'];
    cmspostdate = json['cmspostdate'];
    reviewbysid = json['reviewbysid'];
    reviewdate = json['reviewdate'];
    reviewnote = json['reviewnote'];
    approvbysid = json['approvbysid'];
    approvdate = json['approvdate'];
    wsseqno = json['wsseqno'];
    held = json['held'];
    active = json['active'];
    rate = json['rate'];
    carrierid = json['carrierid'];
    controller = json['controller'];
    origcontroller = json['origcontroller'];
    createdbysid = json['createdbysid'];
    modifiedbysid = json['modifiedbysid'];
    alextractdate = json['alextractdate'];
    alpostdate = json['alpostdate'];
    docrefno = json['docrefno'];
    slipflag = json['slipflag'];
    approvnotes = json['approvnotes'];
    approvstatus = json['approvstatus'];
    pendingoverride = json['pendingoverride'];
    trackingno = json['trackingno'];
    transreasonid = json['transreasonid'];
    voureasonsid = json['voureasonsid'];
    contractdate = json['contractdate'];
    asnno = json['asnno'];
    archived = json['archived'];
    taxareasid = json['taxareasid'];
    taxarea2sid = json['taxarea2sid'];
    resolvstatus = json['resolvstatus'];
    resolvsid = json['resolvsid'];
    note = json['note'];
    noofpkgs = json['noofpkgs'];
    posid = json['posid'];
    tosid = json['tosid'];
    asnsid = json['asnsid'];
    refdocsid = json['refdocsid'];
    vousubtotal = json['vousubtotal'];
    voutotal = json['voutotal'];
    disctype = json['disctype'];
    taxincltype = json['taxincltype'];
    taxexcltype = json['taxexcltype'];
    brmarked = json['brmarked'];
    publishstatus = json['publishstatus'];
    reversedflag = json['reversedflag'];
    slipsbssid = json['slipsbssid'];
    slipstoresid = json['slipstoresid'];
    lineitems = json['lineitems'];
    totalqty = json['totalqty'];
    doctotalcost = json['doctotalcost'];
    totalpackages = json['totalpackages'];
    totalpackagesreceived = json['totalpackagesreceived'];
    voucherqtydiff = json['voucherqtydiff'];
    itemcostdiff = json['itemcostdiff'];
    lineitemsdiff = json['lineitemsdiff'];
    serialdiff = json['serialdiff'];
    lotdiff = json['lotdiff'];
    taxarea = json['taxarea'];
    taxarea2 = json['taxarea2'];
    vendoraddress1 = json['vendoraddress1'];
    vendoraddress2 = json['vendoraddress2'];
    vendoraddress3 = json['vendoraddress3'];
    vendoraddress4 = json['vendoraddress4'];
    vendoraddress5 = json['vendoraddress5'];
    vendoraddress6 = json['vendoraddress6'];
    vendorcity = json['vendorcity'];
    vendorstate = json['vendorstate'];
    vendorpostalcode = json['vendorpostalcode'];
    vendorpostalcodeextension = json['vendorpostalcodeextension'];
    vendoraddress = json['vendoraddress'];
    origstoreaddress = json['origstoreaddress'];
    origstoreno = json['origstoreno'];
    origaddress1 = json['origaddress1'];
    origaddress2 = json['origaddress2'];
    origaddress3 = json['origaddress3'];
    origaddress4 = json['origaddress4'];
    origaddress5 = json['origaddress5'];
    origstorename = json['origstorename'];
    origstoreudf1string = json['origstoreudf1string'];
    origstoreudf2string = json['origstoreudf2string'];
    origstoreudf3string = json['origstoreudf3string'];
    origstoreudf4string = json['origstoreudf4string'];
    origstoreudf5string = json['origstoreudf5string'];
    origzip = json['origzip'];
    orderdate = json['orderdate'];
    canceldate = json['canceldate'];
    vendcode = json['vendcode'];
    vendname = json['vendname'];
    vendid = json['vendid'];
    payeecode = json['payeecode'];
    sbsno = json['sbsno'];
    storeno = json['storeno'];
    clerkname = json['clerkname'];
    modifiedbyemplid = json['modifiedbyemplid'];
    modifiedbyemplname = json['modifiedbyemplname'];
    createdbyemplname = json['createdbyemplname'];
    approvedbyemplname = json['approvedbyemplname'];
    vendinvcid = json['vendinvcid'];
    vendinvcno = json['vendinvcno'];
    vendinvcdate = json['vendinvcdate'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    address5 = json['address5'];
    storename = json['storename'];
    zip = json['zip'];
    vendorudf1string = json['vendorudf1string'];
    vendorudf2string = json['vendorudf2string'];
    vendorudf3string = json['vendorudf3string'];
    vendorudf4string = json['vendorudf4string'];
    vendorudf5string = json['vendorudf5string'];
    vendorudf6string = json['vendorudf6string'];
    vendorudf1date = json['vendorudf1date'];
    vendorudf2date = json['vendorudf2date'];
    storeudf1string = json['storeudf1string'];
    storeudf2string = json['storeudf2string'];
    storeudf3string = json['storeudf3string'];
    storeudf4string = json['storeudf4string'];
    storeudf5string = json['storeudf5string'];
    reasonname = json['reasonname'];
    reasontype = json['reasontype'];
    origintimezone = json['origintimezone'];
    seasoncode = json['seasoncode'];
    clerkorigsbsno = json['clerkorigsbsno'];
    approvedbyorigsbsno = json['approvedbyorigsbsno'];
    createdbyorigsbsno = json['createdbyorigsbsno'];
    modifiedbyorigsbsno = json['modifiedbyorigsbsno'];
    slipsbsno = json['slipsbsno'];
    slipstoreno = json['slipstoreno'];
    slipsid = json['slipsid'];
    slipno = json['slipno'];
    slipreversedflag = json['slipreversedflag'];
    storecode = json['storecode'];
    origstorecode = json['origstorecode'];
    slipstorecode = json['slipstorecode'];
    storephone1 = json['storephone1'];
    origstorephone1 = json['origstorephone1'];
    slipstorephone1 = json['slipstorephone1'];
    storephone2 = json['storephone2'];
    origstorephone2 = json['origstorephone2'];
    slipstorephone2 = json['slipstorephone2'];
    pcflag = json['pcflag'];
    apflag = json['apflag'];
    glflag = json['glflag'];
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
    data['sbssid'] = this.sbssid;
    data['storesid'] = this.storesid;
    data['vouno'] = this.vouno;
    data['voutype'] = this.voutype;
    data['vouclass'] = this.vouclass;
    data['vendsid'] = this.vendsid;
    data['payeesid'] = this.payeesid;
    data['vendacctno'] = this.vendacctno;
    data['vendorinvoicesid'] = this.vendorinvoicesid;
    data['clerksid'] = this.clerksid;
    data['station'] = this.station;
    data['workstation'] = this.workstation;
    data['origstoresid'] = this.origstoresid;
    data['origstation'] = this.origstation;
    data['status'] = this.status;
    data['procstatus'] = this.procstatus;
    data['pono'] = this.pono;
    data['tono'] = this.tono;
    data['pkgno'] = this.pkgno;
    data['shipmentno'] = this.shipmentno;
    data['costhandlingcode'] = this.costhandlingcode;
    data['updatepriceflag'] = this.updatepriceflag;
    data['usevat'] = this.usevat;
    data['discperc'] = this.discperc;
    data['discamt'] = this.discamt;
    data['taxpercincl'] = this.taxpercincl;
    data['taxamtincl'] = this.taxamtincl;
    data['taxpercexcl'] = this.taxpercexcl;
    data['taxamtexcl'] = this.taxamtexcl;
    data['arriveddate'] = this.arriveddate;
    data['custfld'] = this.custfld;
    data['seasonsid'] = this.seasonsid;
    data['refvousid'] = this.refvousid;
    data['audited'] = this.audited;
    data['cms'] = this.cms;
    data['verified'] = this.verified;
    data['purchclearamt'] = this.purchclearamt;
    data['cmspostdate'] = this.cmspostdate;
    data['reviewbysid'] = this.reviewbysid;
    data['reviewdate'] = this.reviewdate;
    data['reviewnote'] = this.reviewnote;
    data['approvbysid'] = this.approvbysid;
    data['approvdate'] = this.approvdate;
    data['wsseqno'] = this.wsseqno;
    data['held'] = this.held;
    data['active'] = this.active;
    data['rate'] = this.rate;
    data['carrierid'] = this.carrierid;
    data['controller'] = this.controller;
    data['origcontroller'] = this.origcontroller;
    data['createdbysid'] = this.createdbysid;
    data['modifiedbysid'] = this.modifiedbysid;
    data['alextractdate'] = this.alextractdate;
    data['alpostdate'] = this.alpostdate;
    data['docrefno'] = this.docrefno;
    data['slipflag'] = this.slipflag;
    data['approvnotes'] = this.approvnotes;
    data['approvstatus'] = this.approvstatus;
    data['pendingoverride'] = this.pendingoverride;
    data['trackingno'] = this.trackingno;
    data['transreasonid'] = this.transreasonid;
    data['voureasonsid'] = this.voureasonsid;
    data['contractdate'] = this.contractdate;
    data['asnno'] = this.asnno;
    data['archived'] = this.archived;
    data['taxareasid'] = this.taxareasid;
    data['taxarea2sid'] = this.taxarea2sid;
    data['resolvstatus'] = this.resolvstatus;
    data['resolvsid'] = this.resolvsid;
    data['note'] = this.note;
    data['noofpkgs'] = this.noofpkgs;
    data['posid'] = this.posid;
    data['tosid'] = this.tosid;
    data['asnsid'] = this.asnsid;
    data['refdocsid'] = this.refdocsid;
    data['vousubtotal'] = this.vousubtotal;
    data['voutotal'] = this.voutotal;
    data['disctype'] = this.disctype;
    data['taxincltype'] = this.taxincltype;
    data['taxexcltype'] = this.taxexcltype;
    data['brmarked'] = this.brmarked;
    data['publishstatus'] = this.publishstatus;
    data['reversedflag'] = this.reversedflag;
    data['slipsbssid'] = this.slipsbssid;
    data['slipstoresid'] = this.slipstoresid;
    data['lineitems'] = this.lineitems;
    data['totalqty'] = this.totalqty;
    data['doctotalcost'] = this.doctotalcost;
    data['totalpackages'] = this.totalpackages;
    data['totalpackagesreceived'] = this.totalpackagesreceived;
    data['voucherqtydiff'] = this.voucherqtydiff;
    data['itemcostdiff'] = this.itemcostdiff;
    data['lineitemsdiff'] = this.lineitemsdiff;
    data['serialdiff'] = this.serialdiff;
    data['lotdiff'] = this.lotdiff;
    data['taxarea'] = this.taxarea;
    data['taxarea2'] = this.taxarea2;
    data['vendoraddress1'] = this.vendoraddress1;
    data['vendoraddress2'] = this.vendoraddress2;
    data['vendoraddress3'] = this.vendoraddress3;
    data['vendoraddress4'] = this.vendoraddress4;
    data['vendoraddress5'] = this.vendoraddress5;
    data['vendoraddress6'] = this.vendoraddress6;
    data['vendorcity'] = this.vendorcity;
    data['vendorstate'] = this.vendorstate;
    data['vendorpostalcode'] = this.vendorpostalcode;
    data['vendorpostalcodeextension'] = this.vendorpostalcodeextension;
    data['vendoraddress'] = this.vendoraddress;
    data['origstoreaddress'] = this.origstoreaddress;
    data['origstoreno'] = this.origstoreno;
    data['origaddress1'] = this.origaddress1;
    data['origaddress2'] = this.origaddress2;
    data['origaddress3'] = this.origaddress3;
    data['origaddress4'] = this.origaddress4;
    data['origaddress5'] = this.origaddress5;
    data['origstorename'] = this.origstorename;
    data['origstoreudf1string'] = this.origstoreudf1string;
    data['origstoreudf2string'] = this.origstoreudf2string;
    data['origstoreudf3string'] = this.origstoreudf3string;
    data['origstoreudf4string'] = this.origstoreudf4string;
    data['origstoreudf5string'] = this.origstoreudf5string;
    data['origzip'] = this.origzip;
    data['orderdate'] = this.orderdate;
    data['canceldate'] = this.canceldate;
    data['vendcode'] = this.vendcode;
    data['vendname'] = this.vendname;
    data['vendid'] = this.vendid;
    data['payeecode'] = this.payeecode;
    data['sbsno'] = this.sbsno;
    data['storeno'] = this.storeno;
    data['clerkname'] = this.clerkname;
    data['modifiedbyemplid'] = this.modifiedbyemplid;
    data['modifiedbyemplname'] = this.modifiedbyemplname;
    data['createdbyemplname'] = this.createdbyemplname;
    data['approvedbyemplname'] = this.approvedbyemplname;
    data['vendinvcid'] = this.vendinvcid;
    data['vendinvcno'] = this.vendinvcno;
    data['vendinvcdate'] = this.vendinvcdate;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['address5'] = this.address5;
    data['storename'] = this.storename;
    data['zip'] = this.zip;
    data['vendorudf1string'] = this.vendorudf1string;
    data['vendorudf2string'] = this.vendorudf2string;
    data['vendorudf3string'] = this.vendorudf3string;
    data['vendorudf4string'] = this.vendorudf4string;
    data['vendorudf5string'] = this.vendorudf5string;
    data['vendorudf6string'] = this.vendorudf6string;
    data['vendorudf1date'] = this.vendorudf1date;
    data['vendorudf2date'] = this.vendorudf2date;
    data['storeudf1string'] = this.storeudf1string;
    data['storeudf2string'] = this.storeudf2string;
    data['storeudf3string'] = this.storeudf3string;
    data['storeudf4string'] = this.storeudf4string;
    data['storeudf5string'] = this.storeudf5string;
    data['reasonname'] = this.reasonname;
    data['reasontype'] = this.reasontype;
    data['origintimezone'] = this.origintimezone;
    data['seasoncode'] = this.seasoncode;
    data['clerkorigsbsno'] = this.clerkorigsbsno;
    data['approvedbyorigsbsno'] = this.approvedbyorigsbsno;
    data['createdbyorigsbsno'] = this.createdbyorigsbsno;
    data['modifiedbyorigsbsno'] = this.modifiedbyorigsbsno;
    data['slipsbsno'] = this.slipsbsno;
    data['slipstoreno'] = this.slipstoreno;
    data['slipsid'] = this.slipsid;
    data['slipno'] = this.slipno;
    data['slipreversedflag'] = this.slipreversedflag;
    data['storecode'] = this.storecode;
    data['origstorecode'] = this.origstorecode;
    data['slipstorecode'] = this.slipstorecode;
    data['storephone1'] = this.storephone1;
    data['origstorephone1'] = this.origstorephone1;
    data['slipstorephone1'] = this.slipstorephone1;
    data['storephone2'] = this.storephone2;
    data['origstorephone2'] = this.origstorephone2;
    data['slipstorephone2'] = this.slipstorephone2;
    data['pcflag'] = this.pcflag;
    data['apflag'] = this.apflag;
    data['glflag'] = this.glflag;
    return data;
  }
}