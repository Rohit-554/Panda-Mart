import '../../core/resources/data_state.dart';
import '../../domain/remote_config_repository/RemoteConfigRepository.dart';
class FetchRemoteConfigUseCase {
  final RemoteConfigRepository _repository;

  FetchRemoteConfigUseCase(this._repository);

  Future<DataState<void>> execute() async {
    return await _repository.fetchAndActivate();
  }

  DataState<String> getStringValue(String key) {
    return _repository.getStringValue(key);
  }

  DataState<int> getIntValue(String key) {
    return _repository.getIntValue(key);
  }

  DataState<bool> getBoolValue(String key) {
    return _repository.getBoolValue(key);
  }
}
