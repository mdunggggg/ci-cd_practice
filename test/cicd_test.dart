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
  test('test insert person', () async {
    await personDao.insertPerson(PersonModel(name: 'John Doe', age: 30, address: 'New York', dateOfBirth: '1990-01-01'));
    final List<PersonModel> persons = await personDao.getPersons();
    expect(persons.length, 1);
  });

  test('test insert multi person', () async {
    const int numPerson = 10;
    for (int i = 0; i < numPerson; i++) {
      await personDao.insertPerson(PersonModel(name: 'John Doe $i', age: 30 + i, address: 'New York $i', dateOfBirth: '1990-01-01'));
    }
    final List<PersonModel> persons = await personDao.getPersons();
    expect(persons.length, numPerson);
  });

  test('test update person', () async {
    await personDao.insertPerson(PersonModel(name: 'John Doe', age: 30, address: 'New York', dateOfBirth: '1990-01-01'));
    final List<PersonModel> persons = await personDao.getPersons();
    PersonModel person = persons.first;
    person = person.copyWith(age: 31);
    await personDao.updatePerson(person);
    final List<PersonModel> updatedPersons = await personDao.getPersons();
    expect(updatedPersons.first.age, 31);
  });

  test('test delete person', () async {
    await personDao.insertPerson(PersonModel(name: 'John Doe', age: 30, address: 'New York', dateOfBirth: '1990-01-01'));
    final List<PersonModel> persons = await personDao.getPersons();
    final PersonModel person = persons.first;
    await personDao.deletePerson(person);
    final List<PersonModel> deletedPersons = await personDao.getPersons();
    expect(deletedPersons.length, 0);
  });


}
