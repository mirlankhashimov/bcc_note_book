part of 'locale_bloc.dart';

@immutable
abstract class LocaleState {}

class LocaleInitialState extends LocaleState {}

class ChangedLangState extends LocaleState {
  final String lang;

  ChangedLangState({required this.lang});

  List<Object?> get props => [lang];
}
