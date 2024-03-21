import 'package:flutter/material.dart';
import 'package:sqlflitecrud/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Create User'),
              onPressed: () async {
                await dbHelper.createUser('John Doe', 'john@example.com');
                print('User created');
              },
            ),
            ElevatedButton(
              child: Text('Read Users'),
              onPressed: () async {
                List<Map<String, dynamic>> users = await dbHelper.getAllUsers();
                print('All users: $users');
              },
            ),
            ElevatedButton(
              child: Text('Update User'),
              onPressed: () async {
                await dbHelper.updateUser(1, 'John Updated', 'john.updated@example.com');
                print('User updated');
              },
            ),
            ElevatedButton(
              child: Text('Delete User'),
              onPressed: () async {
                await dbHelper.deleteUser(1);
                print('User deleted');
              },
            ),
          ],
        ),
      ),
    );
  }
}
