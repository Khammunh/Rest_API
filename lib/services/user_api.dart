import 'dart:convert';

import 'package:api/model/user_dob.dart';
import 'package:api/model/user_location.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../model/user_name.dart';

class UserAPI {
  static Future<List<User>> fetchUser() async {
    print("fetchUsers called");
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      final date = e['dob']['date'];
      final dob = UserDob(
        date: DateTime.parse(date),
        age: e['dob']['age'],
      );

      final coordinate = LocationCoordinate(
        latitude: e['location']['coordinates']['latitude'],
        longitude: e['location']['coordinates']['longitude'],
      );
      final street = LocationStreet(
        number: e['location']['street']['number'],
        name: e['location']['street']['name'],
      );
      final timezone = LocationTimezone(
        offset: e['location']['timezone']['offset'],
        description: e['location']['timezone']['description'],
      );
      final location = UserLocation(
        city: e['location']['city'],
        state: e['location']['state'],
        country: e['location']['country'],
        postcode: e['location']['postcode'].toString(),
        coordinate: coordinate,
        street: street,
        timezone: timezone,
      );
      return User(
          cell: e['cell'],
          email: e['email'],
          gender: e['gender'],
          nat: e['nat'],
          phone: e['phone'],
          name: name,
          dob: dob,
          location: location);
    }).toList();
    return users;
  }
}
