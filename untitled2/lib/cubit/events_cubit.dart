import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Api/api_consumer.dart';
import '../Api/endpoint.dart';
import '../Api/exception.dart';
import '../models/events_models.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsStatus> {
  EventsCubit(this.api) : super(InitialEvents());

  static EventsCubit get(context) => BlocProvider.of(context);

  final ApiConsumer api;
  static List<git_all_events> _allEvents = [];

  List<git_all_events> get allEvents => _allEvents;

  Future<void> getAllEvents() async {
    try {
      emit(LoadingEvents());
      final response = await api.get(Endpoint.get_all_events);
      List<dynamic> data = response['events'];

      _allEvents = data.map((item) => git_all_events.fromJson(item)).toList();
      emit(LoadedEvents());
    } on serverException catch (e) {
      emit(ErrorEvents(e.errorModel.errorMessage));
    }
  }
}
