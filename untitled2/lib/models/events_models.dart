
class git_all_events {

  final int id_event;

  final String name_event_en;

  final String name_event_ar;


  final String image_event;

  git_all_events(this.id_event, this.name_event_en, this.name_event_ar, this.image_event);


  factory git_all_events.fromJson(Map<String,dynamic>data){
    return git_all_events(data['id'], data['name_en'], data['name_ar'],data['image_url']);
  }





}