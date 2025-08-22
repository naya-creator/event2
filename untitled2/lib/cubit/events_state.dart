abstract class EventsStatus {}

class InitialEvents extends EventsStatus {}

class LoadingEvents extends EventsStatus {}

class LoadedEvents extends EventsStatus {}

class ErrorEvents extends EventsStatus {
  final String errorMessage;
  ErrorEvents(this.errorMessage);
}
