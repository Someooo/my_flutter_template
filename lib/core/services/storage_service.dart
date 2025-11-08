// Placeholder service for local persistence interactions.

class StorageService {
  Future<T?> read<T>(String boxName, String key) async {
    return null;
  }

  Future<void> write<T>(String boxName, String key, T value) async {}

  Future<void> clear(String boxName) async {}
}
