abstract class FoodDetails_Status {}

class intial_FoodDetails_Status extends FoodDetails_Status{}

class start_FoodDetails_Status extends FoodDetails_Status{}

class finish_FoodDetails_Status extends FoodDetails_Status{}

class error_FoodDetails_Status extends FoodDetails_Status{
  final String error;

  error_FoodDetails_Status(this.error);

}

class start_AddtoResve_Status extends FoodDetails_Status{}

class finish_AddtoResve_Status extends FoodDetails_Status{}

class error_AddtoResve_Status extends FoodDetails_Status {
  final String error;

  error_AddtoResve_Status(this.error);
}
