// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:comunect_v2/common/helpers/timestamp.dart';

class Bid extends Timestamp {
  double bidPrice;
  bool isAccepted;
  String bidder;
  String biddedJob;

  Bid({
    super.id,
    required this.bidPrice,
    this.isAccepted=false,
    required this.bidder,
    required this.biddedJob
  });

  Map<String, dynamic> toMap({bool isSavedInTheDatabase=false}) {
    if (isSavedInTheDatabase) {
      return <String, dynamic>{
        'bidPrice': bidPrice,
        'isAccepted': isAccepted,
        'bidder': bidder,
        'biddedJob': biddedJob,
      };
    }

    return <String, dynamic>{
        'id': id,
        'bidPrice': bidPrice,
        'isAccepted': isAccepted,
        'bidder': bidder,
        'biddedJob': biddedJob,
      };
  }

  factory Bid.fromMap(Map<String, dynamic> map) {
    return Bid(
      id: map['id'],
      bidPrice: map['bidPrice'] as double,
      isAccepted: map['isAccepted'] ?? false,
      bidder: map['bidder'] as String,
      biddedJob: map['biddedJob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bid.fromJson(String source) => 
    Bid.fromMap(json.decode(source) as Map<String, dynamic>);
}
