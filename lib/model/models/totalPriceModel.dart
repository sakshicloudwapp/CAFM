class TotalPriceModel {
  double? totalPrice;
  List<StockPriceBatches>? stockPriceBatches;

  TotalPriceModel({this.totalPrice, this.stockPriceBatches});

  TotalPriceModel.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    if (json['stockPriceBatches'] != null) {
      stockPriceBatches = <StockPriceBatches>[];
      json['stockPriceBatches'].forEach((v) {
        stockPriceBatches!.add(new StockPriceBatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPrice'] = this.totalPrice;
    if (this.stockPriceBatches != null) {
      data['stockPriceBatches'] =
          this.stockPriceBatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockPriceBatches {
  int? batchId;
  String? batchCode;
  int? unitPrice;
  int? quantity;
  int? batchPrice;

  StockPriceBatches(
      {this.batchId,
        this.batchCode,
        this.unitPrice,
        this.quantity,
        this.batchPrice});

  StockPriceBatches.fromJson(Map<String, dynamic> json) {
    batchId = json['batchId'];
    batchCode = json['batchCode'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    batchPrice = json['batchPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchId'] = this.batchId;
    data['batchCode'] = this.batchCode;
    data['unitPrice'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['batchPrice'] = this.batchPrice;
    return data;
  }
}