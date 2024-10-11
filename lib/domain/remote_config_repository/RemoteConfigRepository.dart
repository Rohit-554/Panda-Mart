import '../../core/resources/data_state.dart';

abstract class RemoteConfigRepository {
  Future<DataState<void>> initialize();
  Future<DataState<void>> fetchAndActivate();
  DataState<String> getStringValue(String key);
  DataState<int> getIntValue(String key);
  DataState<bool> getBoolValue(String key);
}
