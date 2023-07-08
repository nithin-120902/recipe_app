import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '../../repository/repository.dart';
import '../../service/model.dart';

part 'querypage_event.dart';
part 'querypage_state.dart';

class QuerypageBloc extends Bloc<QuerypageEvent, QuerypageState> {
  late String query;
  QuerypageBloc() : super(QuerypageInitial()) {
    on<QuerypageEvent>(mapEventToState);
  }

  Future<void> mapEventToState(QuerypageEvent event,Emitter<QuerypageState> emit) async {
    if(event is GetQuery){
      query=event.inputText;
      await Hive.initFlutter('searchHistory');
      Box box = await Hive.openBox('Box');
      query = query.trim();
      if (box.get(query) == null) {
        box.put(query, 1);
      } else {
        dynamic k = box.get(query);
        box.delete(query);
        box.put(query, k + 1);
      }
      dynamic keys = box.keys;
      Map map = {};
      for (var i in keys) {
        map[i] = box.get(i);
      }
    }
    else if(event is FetchDataEvent){
      emit(QuerypageLoading());
      try {
        final dataFetched = await QuerypageRepository().getQuerypageData(query);
        emit(QuerypageSuccess(dataFetched!));
      } catch (e) {
        emit(QuerypageFailed(e.toString()));
      }
    }
  }
}
