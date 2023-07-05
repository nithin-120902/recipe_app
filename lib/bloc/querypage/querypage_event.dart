// ignore_for_file: must_be_immutable

part of 'querypage_bloc.dart';

@immutable
abstract class QuerypageEvent {}

class FetchDataEvent extends QuerypageEvent {}

class GetQuery extends QuerypageEvent {
  String inputText;
  GetQuery(this.inputText);
}