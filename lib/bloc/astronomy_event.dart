abstract class AstronomyEvent {}

class LoadAstronomyPicture extends AstronomyEvent {
  final DateTime? date;

  LoadAstronomyPicture({this.date});
}
