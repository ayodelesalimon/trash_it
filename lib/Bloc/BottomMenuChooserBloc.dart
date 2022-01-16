// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomMenuChooserBloc extends Bloc<BottomMenuChooserBlocEvent, BottomMenuChooserBlocEvent> {
  BottomMenuChooserBloc(BottomMenuChooserBlocEvent initialState) : super(initialState);

  @override
  BottomMenuChooserBlocEvent get initialState =>
      BottomMenuChooserBlocEvent.home;

  @override
  Stream<BottomMenuChooserBlocEvent> mapEventToState(
      BottomMenuChooserBlocEvent event) async* {
    yield event;
  }
}

enum BottomMenuChooserBlocEvent { home, cards, history, profile }
