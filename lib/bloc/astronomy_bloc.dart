import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/astronomy_api.dart';
import 'astronomy_event.dart';
import 'astronomy_state.dart';

class AstronomyBloc extends Bloc<AstronomyEvent, AstronomyState> {
  final AstronomyApi astronomyApi;

  AstronomyBloc(this.astronomyApi) : super(AstronomyInitial()) {
    // Register the event handler for LoadAstronomyPicture event
    on<LoadAstronomyPicture>(_onLoadAstronomyPicture);
  }

  // Event handler for LoadAstronomyPicture
  Future<void> _onLoadAstronomyPicture(
      LoadAstronomyPicture event, Emitter<AstronomyState> emit) async {
    emit(AstronomyLoading()); // Emit loading state
    try {
      final response = await astronomyApi.getAstronomyPicture(date: event.date); // Fetch the picture
      emit(AstronomyLoaded(response)); // Emit loaded state with data
    } catch (e) {
      emit(AstronomyError("Failed to load picture: ${e.toString()}")); // Emit error state
    }
  }
}
