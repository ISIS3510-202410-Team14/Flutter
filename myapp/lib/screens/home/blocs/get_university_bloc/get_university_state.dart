part of 'get_university_bloc.dart';

sealed class GetUniversityState extends Equatable {
  const GetUniversityState();
  
  @override
  List<Object> get props => [];
}

final class GetUniversityInitial extends GetUniversityState {}

final class GetUniversityFailure extends GetUniversityState {}
final class GetUniversityLoading extends GetUniversityState {}
final class GetUniversitySuccess extends GetUniversityState {
  final List<University> universitys;

  const GetUniversitySuccess(this.universitys);

  @override
  List<Object> get props => [universitys];
}