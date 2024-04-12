import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university_repository/university_repository.dart';

part 'get_university_event.dart';
part 'get_university_state.dart';

class GetUniversityBloc extends Bloc<GetUniversityEvent, GetUniversityState> {
  final UniversityRepo _universityRepo;

  GetUniversityBloc(this._universityRepo) : super(GetUniversityInitial()) {
    on<GetUniversity>((event, emit) async {
      emit(GetUniversityLoading());
      try {
        List<University> universitys = await _universityRepo.getUniversitys();
        emit(GetUniversitySuccess(universitys));
      } catch (e) {
        emit(GetUniversityFailure());
      }
    });
  }
}