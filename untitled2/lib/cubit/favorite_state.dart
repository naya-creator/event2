abstract class Favorite_Status {}

class intial_getfav extends Favorite_Status{}

class start_getfav extends Favorite_Status{}

class finish_getfav extends Favorite_Status{}

class error_getfav extends Favorite_Status{
  final String error;
  error_getfav(this.error);
}


