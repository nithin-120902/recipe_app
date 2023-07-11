import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favoritelist_event.dart';
part 'favoritelist_state.dart';

class FavoritelistBloc extends Bloc<FavoritelistEvent, FavoritelistState> {
  FavoritelistBloc() : super(FavoritelistInitial()) {
    on<FavoritelistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
