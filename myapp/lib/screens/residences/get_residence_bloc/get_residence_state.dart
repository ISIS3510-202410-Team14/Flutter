part of 'get_residence_bloc.dart';

sealed class GetResidenceState extends Equatable {
  const GetResidenceState();
  
  @override
  List<Object> get props => [];
}

final class GetResidenceInitial extends GetResidenceState {}

final class GetResidenceFailure extends GetResidenceState {}
final class GetResidenceLoading extends GetResidenceState {}
final class GetResidenceSuccess extends GetResidenceState {
  final List<Residence> residences;

  const GetResidenceSuccess(this.residences);

  @override
  List<Object> get props => [residences];
}