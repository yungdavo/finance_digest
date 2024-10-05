import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finance_digest/helper/databasehelper.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  test('should insert user into the database', () async {
    final mockDb = MockDatabase();
    final dbHelper = DatabaseHelper(db: mockDb); // Inject mockDb

    // Mock database interaction
    when(mockDb.insert('User', any, conflictAlgorithm: anyNamed('conflictAlgorithm')))
        .thenAnswer((_) async => 1);

    // Test the insertUser method
    await dbHelper.insertUser('John', 'Doe');

    // Verify that the insert method was called with the correct parameters
    verify(mockDb.insert(
      'User',
      {'firstName': 'John', 'lastName': 'Doe'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    ));
  });
}
