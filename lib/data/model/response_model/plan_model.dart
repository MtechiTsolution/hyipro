class PlanModel {
  String? status;
  PlanData? message;

  PlanModel({this.status, this.message});

  PlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new PlanData.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class PlanData {
  String? title;
  String? subTitle;
  String? shortDetails;
  String? balance;
  String? totalInvestment_refer;
  String? interestBalance;
  List<Plans>? plans;

  PlanData(
      {this.title,
      this.subTitle,
      this.shortDetails,
      this.balance,
      this.interestBalance,
        this.totalInvestment_refer,
      this.plans});

  PlanData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    shortDetails = json['short_details'];
    balance = json['balance'];
    interestBalance = json['interest_balance'];
    totalInvestment_refer=json['totalInvestment_refer'];
    print("tes: ${json['totalInvestment_refer']}");
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['short_details'] = this.shortDetails;
    data['balance'] = this.balance;
    data['interest_balance'] = this.interestBalance;
    data['totalInvestment_refer']=this.totalInvestment_refer;
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  int? id;
  String? name;
  String? image;
  String? min;
  String? max;
  String? price;
  int? profit;
  String? profitType;
  String? profitFor;
  String? capitalBack;
  String? capitalEarning;

  Plans(
      {this.id,
      this.name,
      this.image,
      this.min,
      this.max,
      this.price,
      this.profit,
      this.profitType,
      this.profitFor,
      this.capitalBack,
      this.capitalEarning});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    min = json['min'];
    max = json['max'];
    price = json['price'];
    profit = json['profit'];
    profitType = json['profitType'];
    profitFor = json['profitFor'];
    capitalBack = json['capitalBack'];
    capitalEarning = json['capitalEarning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min'] = this.min;
    data['max'] = this.max;
    data['price'] = this.price;
    data['profit'] = this.profit;
    data['profitType'] = this.profitType;
    data['profitFor'] = this.profitFor;
    data['capitalBack'] = this.capitalBack;
    data['capitalEarning'] = this.capitalEarning;
    return data;
  }
}
