class Notif{
  String title;
  String body;
  String date;
  String type;

  Notif({this.title, this.body, this.date, this.type});

   Notif.fromJson(json){
    this.title = json['title'];
    this.body = json['body'];
    this.type = json['type'];
    this.date = json['created_at'].toString();
  }
}