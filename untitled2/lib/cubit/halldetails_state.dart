abstract class HalldetailsStatus {}
class inital_Halldetails extends HalldetailsStatus{}
class start_HallDetails_class extends HalldetailsStatus{}
class finish_HallDetails_class extends HalldetailsStatus{}
class error_HallDetails_class extends HalldetailsStatus{
  final String errorModel;

  error_HallDetails_class(this.errorModel);

}

class start_HallDetailsServices_class extends HalldetailsStatus{}
class finish_HallDetailsServices_class extends HalldetailsStatus{}
class error_HallDetailsServices_class extends HalldetailsStatus{
  final String errorModel;

  error_HallDetailsServices_class(this.errorModel);

}

class Add_Star extends HalldetailsStatus{}

class start_AddFavorit_Status extends HalldetailsStatus{}

class finish_AddFavorit_Status extends HalldetailsStatus{}

class error_AddFavorit_Status extends HalldetailsStatus{
  final String error;
  error_AddFavorit_Status(this.error);

}


class start_DeleteFavorit_Status extends HalldetailsStatus{}

class finish_DeleteFavorit_Status extends HalldetailsStatus{}

class error_DeleteFavorit_Status extends HalldetailsStatus{
  final String error;
  error_DeleteFavorit_Status(this.error);

}
class date_selected_success extends HalldetailsStatus{}

class time_selected_success extends HalldetailsStatus{}



class start_gettimes_Status extends HalldetailsStatus{}

class finish_gettimes_Status extends HalldetailsStatus{}

class error_gettimes_Status extends HalldetailsStatus{
  final String error;
  error_gettimes_Status(this.error);

}


class start_ReserveHallStatus extends HalldetailsStatus{}

class finish_ReserveHallStatus extends HalldetailsStatus{}

class error_ReserveHallStatus extends HalldetailsStatus{
  final String errormassege;
  error_ReserveHallStatus(this.errormassege);
}