part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageSuccess extends HomepageState {
  late final List<Model> dataFetched;
  HomepageSuccess(this.dataFetched);
}

class HomepageFailed extends HomepageState {
  late final String error;
  HomepageFailed(this.error);
}