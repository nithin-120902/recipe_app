part of 'querypage_bloc.dart';

@immutable
abstract class QuerypageState {}

class QuerypageInitial extends QuerypageState {}

class QuerypageLoading extends QuerypageState {}

class QuerypageSuccess extends QuerypageState {
  late final List<Model> dataFetched;
  QuerypageSuccess(this.dataFetched);
}

class QuerypageFailed extends QuerypageState {
  late final String error;
  QuerypageFailed(this.error);
}
