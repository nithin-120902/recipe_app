import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository.dart';
import '../../service/model.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageLoading()) {
    on<FetchDataEvent>((event, emit) async {
      emit(HomepageLoading());
      try {
        final dataFetched =  await HomepageRepository().getHomepageData();
        emit(HomepageSuccess(dataFetched!));
      } catch (e) {
        emit(HomepageFailed(e.toString()));
      }
    });
  }
}
