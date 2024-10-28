import '../data/astronomy_response.dart';

abstract class AstronomyState {}

class AstronomyInitial extends AstronomyState {}

class AstronomyLoading extends AstronomyState {}

class AstronomyLoaded extends AstronomyState {
  final AstronomyResponse astronomyResponse;

  AstronomyLoaded(this.astronomyResponse);
}

class AstronomyError extends AstronomyState {
  final String message;

  AstronomyError(this.message);
}
