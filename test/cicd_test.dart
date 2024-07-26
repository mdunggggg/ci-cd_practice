// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_clean_architecture/data/local/dao/person_dao.dart';
import 'package:flutter_clean_architecture/data/local/database/app_database.dart';
import 'package:flutter_clean_architecture/data/model/person_model.dart';
import 'package:flutter_test/flutter_test.dart';


main() async {
  final AppDatabase appDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
  final PersonDao personDao = appDatabase.personDao;
  test('1', () async {
    await personDao.insertPerson(PersonModel(name: 'John Doe', age: 30, address: 'New York', dateOfBirth: '1990-01-01'));
    final List<PersonModel> persons = await personDao.getPersons();
    expect(persons.length, 1);
  });

  test('2', () async {
    await personDao.insertPerson(PersonModel(name: 'John Doe', age: 30, address: 'New York', dateOfBirth: '1990-01-01'));
    await personDao.insertPerson(PersonModel(name: 'Jane Doe 2', age: 25, address: 'Los Angeles', dateOfBirth: '1995-01-01'));
    final List<PersonModel> persons = await personDao.getPersons();
    expect(persons.length, 2);
  });


}
