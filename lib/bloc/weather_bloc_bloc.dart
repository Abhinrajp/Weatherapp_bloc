import 'package:bloc/bloc.dart';
import 'package:block_weatherapp/model/weather_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    emit(WeatherBlocloading());
    on<Fetchweather>((event, emit) async {
      try {
        WeatherFactory wf = WeatherFactory(apikey, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        print(weather);
        emit(WeatherBlocsuccess(weather));
      } catch (e) {
        print(e);
        emit(WeatherBlocfailure());
      }
    });
  }
}
