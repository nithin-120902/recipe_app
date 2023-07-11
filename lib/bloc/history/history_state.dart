// ignore_for_file: must_be_immutable

part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  List<String> list;
  HistorySuccess(this.list);
}

class HistoryFailed extends HistoryState {
  String error;
  HistoryFailed(this.error);
}
