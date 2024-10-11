import '../../core/resources/data_state.dart';
import '../../domain/remote_config_repository/RemoteConfigRepository.dart';
import '../service/FirebaseRemoteConfigService.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final FirebaseRemoteConfigService _service;

  RemoteConfigRepositoryImpl(this._service);

  @override
  Future<DataState<void>> initialize() async {
    try {
      await _service.initialize();
      return DataSuccess(null);
    } catch (error) {
      return DataFailed(error);
    }
  }

  @override
  Future<DataState<void>> fetchAndActivate() async {
    try {
      await _service.fetchAndActivate();
      return DataSuccess(null);
    } catch (error) {
      return DataFailed(error);
    }
  }

  @override
  DataState<String> getStringValue(String key) {
    try {
      final value = _service.getStringValue(key);
      return DataSuccess(value);
    } catch (error) {
      return DataFailed(error);
    }
  }

  @override
  DataState<int> getIntValue(String key) {
    try {
      final value = _service.getIntValue(key);
      return DataSuccess(value);
    } catch (error) {
      return DataFailed(error);
    }
  }

  @override
  DataState<bool> getBoolValue(String key) {
    try {
      final value = _service.getBoolValue(key);
      return DataSuccess(value);
    } catch (error) {
      return DataFailed(error);
    }
  }
}
