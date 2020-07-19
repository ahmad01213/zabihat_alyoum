import 'Bid.dart';

class Mazad {
  String id;
  String name;
  String desc;
  String image;
  String minprice;
  String starttime;
  String endttime;
  List<Bid> bids;
  Mazad(
      {this.id,
      this.name,
      this.desc,
      this.minprice,
      this.starttime,
      this.endttime,
      this.bids,
      this.image});
}
