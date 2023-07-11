import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<GetHistory>((event, emit) async{
      emit(HistoryLoading());
      List<String> historyList = [];
      try {
        await Hive.initFlutter('searchHistory');
        Box box = await Hive.openBox('Box');
        Map history = box.toMap();
        print("history");
        print(history);
        List values = history.values.toSet().toList();
        while(values.isNotEmpty){
          var max = values.reduce((value, element) => value > element ? value : element);
        //   historyList.addAll(history.keys.firstWhere(
        // (k) => history[k] == max, orElse: () => null));
          for(var key in history.keys){
            if(history[key]==max){
              historyList.add(key);
            }
          }
        values.remove(max);
        }
        print(historyList);
        emit(HistorySuccess(historyList));
        
      } catch (e) {
        emit(HistoryFailed(e.toString()));
      }
    });
  }
}
