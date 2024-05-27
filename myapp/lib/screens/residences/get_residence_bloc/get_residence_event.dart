part of 'get_residence_bloc.dart';

sealed class GetResidenceEvent extends Equatable {
  const GetResidenceEvent();

  @override
  List<Object> get props => [];
}

class GetResidence extends GetResidenceEvent{}