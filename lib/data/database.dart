import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  Database _db;

  DatabaseHelper.internal();

  final int _version = 1;
  final StoreRef mainStore = StoreRef<String, dynamic>.main();
  final String keyEmployees = "employees_key";

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  _initDb() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'employees.db');
    final database = await databaseFactoryIo.openDatabase(dbPath, version: _version);
    return database;
  }

  Future<dynamic> getEmpData() async {
    var client = await db;
    try {
      return await mainStore.record(keyEmployees).get(client) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> setEmpData(dynamic value) async {
    var client = await db;
    try {
      await mainStore.record(keyEmployees).put(client, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clear() async {
    var client = await db;
    try {
      await mainStore.delete(client);
      return true;
    } catch (e) {
      return false;
    }
  }
}
