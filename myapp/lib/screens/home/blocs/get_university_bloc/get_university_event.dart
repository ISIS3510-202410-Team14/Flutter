part of 'get_university_bloc.dart';

sealed class GetUniversityEvent extends Equatable {
  const GetUniversityEvent();

  @override
  List<Object> get props => [];
}

class GetUniversity extends GetUniversityEvent{}