import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitialState()) {
    on<LocaleEvent>((event, emit) {

    });
    on<ChangeLangEvent>((event, emit) async {
      var langBox = await Hive.openBox<String>('box_for_lang');
      final lang = langBox.get("lang") ?? "ru";
      if (lang == "ru") {
        langBox.put("lang", "en");
        emit(ChangedLangState(lang: "en"));
      } else {
        langBox.put("lang", "ru");
        emit(ChangedLangState(lang: "ru"));
      }
    });
  }

}
