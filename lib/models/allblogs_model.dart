class AllBlogs {
  final bool success;
  final String message;
  final List<Data> data;
  final int status;

  AllBlogs({required this.success, required this.message, required this.data, required this.status});
   factory AllBlogs.fromJson(Map<String, dynamic> json){
    return AllBlogs(success: json['success'], message: json['message'], data: json['data'], status: json['status']);
   }
 
}

class Data {
  final int id;
  final String title;
   final String author;
   final String body;
   final String createdAt;
  final  String updatedAt;

  Data(
      {
        required this.id,
     required this.title,
    required  this.author,
     required this.body,
     required this.createdAt,
     required this.updatedAt});
     
     factory Data.fromJson(Map<String, dynamic> datajson){
    return Data(id: datajson['id'], title: datajson['title'], author: datajson['author'], body: datajson['body'], createdAt: datajson['created_at'], updatedAt: datajson['updated_at']);
  }

}