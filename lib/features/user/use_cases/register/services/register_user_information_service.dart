import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:stud_advice/features/user/models/university_data.dart';

import '../../../../../common/conf/injection_container.dart';
import '../../../models/city_data.dart';

class RegisterUserInformationService {
  final _dio = locator<Dio>();

  static String generateRandomPseudo() {
    final random = Random();
    final words = all.take(10000).toList();

    String pseudo = '';
    for (int i = 0; i < 2; i++) {
      pseudo += words[random.nextInt(words.length)].substring(0, 3);
    }

    pseudo += (random.nextInt(90) + 10)
        .toString(); // Add a random number at the end of the pseudo.

    return pseudo;
  }

  Future<List<CityData>> fetchCitiesFromAPI(String cityName) async {
    try {
      final cityApiUri = Uri.parse(
          'https://geo.api.gouv.fr/communes?nom=$cityName&boost=population');
      final response = await _dio.get(cityApiUri.toString());

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> data = response.data;
        final cities = data
            .map((json) => CityData.fromJson(json))
            .where((city) => city.nom != null)
            .toList();
        return cities;
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load cities');
    }
  }

  Future<List<String>> fetchPostalCodesFromApi(String? cityName) async {
    try {
      final cityApiUri = Uri.parse(
          'https://geo.api.gouv.fr/communes?nom=$cityName&boost=population');
      final response = await _dio.get(cityApiUri.toString());

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> data = response.data;
        final cities = data
            .map((json) => CityData.fromJson(json))
            .where((city) => city.nom != null)
            .toList();
        if (cities.isNotEmpty) {
          return cities[0].codesPostaux ??
              []; // Return the first match only postal codes.
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load city postal codes');
    }
  }

  Future<List<UniversityData>> fetchUniversityData(String select) async {
    List<UniversityData> allResults = [];
    int totalCount = 0;
    int offset = 0;
    int limit = 100;

    do {
      final universityApiUri = Uri.parse(
          '/api/explore/v2.1/catalog/datasets/fr-esr-principaux-etablissements-enseignement-superieur/records?select=$select&where=champ_recherche%20like%22lyon%22&limit=$limit&offset=$offset');
      final response = await _dio.get(universityApiUri.toString());

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        final universityData = UniversityResults.fromJson(data);
        allResults.addAll(universityData.results ?? []);
        totalCount = universityData.totalCount ?? 0;
      } else {
        throw Exception('Failed to load university data');
      }

      offset += limit;
    } while (allResults.length < totalCount);

    return allResults;
  }
}
