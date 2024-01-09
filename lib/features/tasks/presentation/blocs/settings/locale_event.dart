part of 'locale_bloc.dart';

@immutable
abstract class LocaleEvent extends Equatable {}

class LocaleInitialEvent extends LocaleEvent {
  final String lang;

  LocaleInitialEvent({required this.lang});

  @override
  List<Object?> get props => [lang];
}

class ChangeLangEvent extends LocaleEvent {
  final String lang;

  ChangeLangEvent({required this.lang});

  @override
  List<Object?> get props => [lang];
}
