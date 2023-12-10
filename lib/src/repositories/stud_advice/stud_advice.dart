import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stud_advice/src/repositories/stud_advice/stud_advice_interface.dart';
import '../../models/stud_advice/Categories.dart';

class StudAdviceRepository implements IStudAdviceRepository {
  final _dio = Get.find<Dio>();
  final String baseUrl = 'https://localhost:8080';

  @override
  Future<AdministrativeProcessCategory> getCategories({required int number, required int size}) async {
    // try {
    //   final response = await _dio.get(
    //     '$baseUrl/categories',
    //     queryParameters: {'page': number, 'size': size},
    //   );
    //
    //   if (response.statusCode == 200) {
    //     return AdministrativeProcessCategory.fromJson(response.data);
    //   } else {
    //     throw Exception('Failed to load categories');
    //   }
    // } catch (error) {
    //   throw Exception('Failed to connect to the server');
    // }
    // Réponse JSON statique
    String jsonResponse;
    if (number == 0) {
      jsonResponse = '''
{
  "content": [
    {
      "id": "1",
      "name": "Santé",
      "description": "Description de Santé",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FFA500",
      "administrativeProcesses": []
    },
    {
      "id": "2",
      "name": "Éducation",
      "description": "Description d'Éducation",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "00FF00",
      "administrativeProcesses": []
    },
    {
      "id": "3",
      "name": "Finance",
      "description": "Description de Finance",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "0000FF",
      "administrativeProcesses": []
    },
    {
      "id": "4",
      "name": "Technologie",
      "description": "Description de Technologie",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FF0000",
      "administrativeProcesses": []
    },
    {
      "id": "5",
      "name": "Art",
      "description": "Description d'Art",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "800080",
      "administrativeProcesses": []
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 5,
    "sort": {
      "empty": true,
      "sorted": false,
      "unsorted": true
    },
    "offset": 0,
    "paged": true,
    "unpaged": false
  },
  "totalElements": 10,
  "totalPages": 2,
  "last": false,
  "size": 5,
  "number": 0,
  "sort": {
    "empty": true,
    "sorted": false,
    "unsorted": true
  },
  "numberOfElements": 5,
  "first": true,
  "empty": false
}
''';
    } else {
      jsonResponse = '''
{
  "content": [
    {
      "id": "6",
      "name": "Science",
      "description": "Description de Science",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FFFF00",
      "administrativeProcesses": []
    },
    {
      "id": "7",
      "name": "Sports",
      "description": "Description de Sports",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "00FFFF",
      "administrativeProcesses": []
    },
    {
      "id": "8",
      "name": "Mode",
      "description": "Description de Mode",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FF00FF",
      "administrativeProcesses": []
    },
    {
      "id": "9",
      "name": "Environnement",
      "description": "Description d'Environnement",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "008000",
      "administrativeProcesses": []
    },
    {
      "id": "10",
      "name": "Voyages",
      "description": "Description de Voyages",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "800000",
      "administrativeProcesses": []
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 5,
    "sort": {
      "empty": true,
      "sorted": false,
      "unsorted": true
    },
    "offset": 0,
    "paged": true,
    "unpaged": false
  },
  "totalElements": 10,
  "totalPages": 2,
  "last": true,
  "size": 5,
  "number": 0,
  "sort": {
    "empty": true,
    "sorted": false,
    "unsorted": true
  },
  "numberOfElements": 5,
  "first": false,
  "empty": false
}
''';
    }

    final Map<String, dynamic> parsedJson = json.decode(jsonResponse);

    final administrativeProcessCategory = AdministrativeProcessCategory.fromJson(parsedJson);

    return administrativeProcessCategory;
  }

  @override
  Future<AdministrativeProcessCategory> getCategoriesBySearch({required int number, required int size,required String query}) async {
    String jsonResponse;
    if (number == 0) {
      jsonResponse = '''
{
  "content": [
    {
      "id": "1",
      "name": "Santé",
      "description": "Description de Santé",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FFA500",
      "administrativeProcesses": []
    },
    {
      "id": "2",
      "name": "Éducation",
      "description": "Description d'Éducation",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "00FF00",
      "administrativeProcesses": []
    },
    {
      "id": "3",
      "name": "Finance",
      "description": "Description de Finance",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "0000FF",
      "administrativeProcesses": []
    },
    {
      "id": "4",
      "name": "Technologie",
      "description": "Description de Technologie",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FF0000",
      "administrativeProcesses": []
    },
    {
      "id": "5",
      "name": "Art",
      "description": "Description d'Art",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "800080",
      "administrativeProcesses": []
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 5,
    "sort": {
      "empty": true,
      "sorted": false,
      "unsorted": true
    },
    "offset": 0,
    "paged": true,
    "unpaged": false
  },
  "totalElements": 10,
  "totalPages": 2,
  "last": false,
  "size": 5,
  "number": 0,
  "sort": {
    "empty": true,
    "sorted": false,
    "unsorted": true
  },
  "numberOfElements": 5,
  "first": true,
  "empty": false
}
''';
    } else {
      jsonResponse = '''
{
  "content": [
    {
      "id": "6",
      "name": "Science",
      "description": "Description de Science",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FFFF00",
      "administrativeProcesses": []
    },
    {
      "id": "7",
      "name": "Sports",
      "description": "Description de Sports",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "00FFFF",
      "administrativeProcesses": []
    },
    {
      "id": "8",
      "name": "Mode",
      "description": "Description de Mode",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "FF00FF",
      "administrativeProcesses": []
    },
    {
      "id": "9",
      "name": "Environnement",
      "description": "Description d'Environnement",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "008000",
      "administrativeProcesses": []
    },
    {
      "id": "10",
      "name": "Voyages",
      "description": "Description de Voyages",
      "imageId": "657574b5be94f11bd8d9466d",
      "color": "800000",
      "administrativeProcesses": []
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 5,
    "sort": {
      "empty": true,
      "sorted": false,
      "unsorted": true
    },
    "offset": 0,
    "paged": true,
    "unpaged": false
  },
  "totalElements": 10,
  "totalPages": 2,
  "last": true,
  "size": 5,
  "number": 0,
  "sort": {
    "empty": true,
    "sorted": false,
    "unsorted": true
  },
  "numberOfElements": 5,
  "first": false,
  "empty": false
}
''';
    }

    final Map<String, dynamic> parsedJson = json.decode(jsonResponse);

    final administrativeProcessCategory = AdministrativeProcessCategory.fromJson(parsedJson);

    return administrativeProcessCategory;
  }
}