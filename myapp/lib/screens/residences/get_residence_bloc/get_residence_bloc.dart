import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:residence_repository/residence_repository.dart';

part 'get_residence_event.dart';
part 'get_residence_state.dart';

class GetResidenceBloc extends Bloc<GetResidenceEvent, GetResidenceState> {
  final ResidenceRepo _residenceRepo;

  GetResidenceBloc(this._residenceRepo) : super(GetResidenceInitial()) {
    on<GetResidence>((event, emit) async {
      emit(GetResidenceLoading());
      try {
        List<Residence> residences = await _residenceRepo.getResidences();
        emit(GetResidenceSuccess(residences));
      } catch (e) {
        emit(GetResidenceFailure());
      }
    });
  }
}