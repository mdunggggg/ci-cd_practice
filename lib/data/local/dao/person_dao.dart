import 'package:floor/floor.dart';
import 'package:flutter_clean_architecture/data/model/person_model.dart';

@dao
abstract class PersonDao {
  @insert
  Future<void> insertPerson(PersonModel person);
  @update
  Future<void> updatePerson(PersonModel person);
  @delete
  Future<void> deletePerson(PersonModel person);
  @Query('SELECT * FROM PersonModel')
  Future<List<PersonModel>> getPersons();
}