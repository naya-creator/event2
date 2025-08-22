class Search_events_model{

  final  String name_ar;

  final  String name_en;

  final  String image_url;

  Search_events_model(this.name_ar, this.name_en, this.image_url);

  factory Search_events_model.fromJson(Map<String,dynamic>data){

   return Search_events_model(data['name_ar'], data['name_en'], data['image_url']);

  }


}