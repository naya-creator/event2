 abstract class Places_Status {}
 class initial_places extends Places_Status{}
 class start_places_class extends Places_Status{}
 class finish_places_class extends Places_Status{}
 class error_places_class extends Places_Status{
   final String errormassege;

   error_places_class(this.errormassege);
 }