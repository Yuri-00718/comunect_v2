import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comunect_v2/common/helpers/repository.dart';
import 'package:comunect_v2/features/find_a_job/models/bid.dart';
import 'package:comunect_v2/utils/globals.dart';

class BidRepository extends Repository {
  static const String fieldBidPrice = 'bidPrice';
  static const String fieldIsAccepted = 'isAccepted';
  static const String fieldBidder = 'bidder';
  static const String fieldBiddedJob = 'biddedJob';

  @override
  CollectionReference get collection => firestoreDb.collection(collectionName);
  static String get collectionName => 'bids';

  Future<void> makeABid(Map<String, dynamic> values) async {
    Bid newBid = Bid.fromMap(values);
    await collection.add(newBid.toMap());
  }
}