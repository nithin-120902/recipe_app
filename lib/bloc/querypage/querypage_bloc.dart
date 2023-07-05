import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository.dart';
import '../../service/model.dart';

part 'querypage_event.dart';
part 'querypage_state.dart';

class QuerypageBloc extends Bloc<QuerypageEvent, QuerypageState> {
  late String query;
  QuerypageBloc() : super(QuerypageInitial()) {
    on<QuerypageEvent>(mapEventToState);
    on<FetchDataEvent>(onFetchDataEvent);
  }

  void mapEventToState(QuerypageEvent event,Emitter<QuerypageState> emit){
    if(event is GetQuery){
      query=event.inputText;
    }
  }

  Future<void> onFetchDataEvent(FetchDataEvent event, Emitter<QuerypageState> emit) async {
    emit(QuerypageLoading());
    try {
      final dataFetched = await QuerypageRepository().getQuerypageData(query);
      emit(QuerypageSuccess(dataFetched!));
    } catch (e){
      emit(QuerypageFailed(e.toString()));
    }
  }
}
