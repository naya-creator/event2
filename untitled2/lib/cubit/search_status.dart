

abstract class Search_Status {}

class initial_Search_Status extends Search_Status{}

class start_Search_Status extends Search_Status{}

class finish_Search_Status extends Search_Status{}


class error_Search_Status extends Search_Status{
  final String error ;

  error_Search_Status(this.error);
}

class history_Search_Status extends Search_Status{}