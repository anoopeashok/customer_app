class Customer {
  String id,
      cardCode,
      cardName,
      address,
      priceMode,
      priceList,
      phone1,
      cntctPrsn,
      balance,
      creditLine,
      mailAddres;

  Customer.fromJson(Map<String, dynamic> json) {
    this.id = json['_id'];
    this.cardCode = json['cardCode'];
    this.cardName = json['cardName'];
    this.address = json['address'];
    this.priceMode = json['priceMode'];
    this.priceList = json['priceList'];
    this.phone1 = json['phone1'];
    this.cntctPrsn = json['cntctPrsn'];
    this.balance = json['balance'];
    this.creditLine = json['creditLine'];
    this.mailAddres = json['mailAddres'];
  }

  Map<String, dynamic> toJson() {

    return {
            "_id": this.id,
            "cardCode": this.cardCode,
            "cardName": this.cardName,
            "address": this.address,
            "priceMode": this.priceMode,
            "priceList": this.priceList,
            "phone1": this.phone1,
            "cntctPrsn": this.cntctPrsn,
            "balance": this.balance,
            "creditLine": this.creditLine,
            "mailAddres": this.mailAddres
        };
  }
}
