import 'package:flutter/material.dart';
import '../../core/resources/data_state.dart';
import '../usecases/firebase_remote_config.dart';

class RemoteConfigViewModel extends ChangeNotifier {
  final FetchRemoteConfigUseCase _fetchRemoteConfigUseCase;
  bool _isLoading = false;
  String? _configValue;
  String? _error;

  RemoteConfigViewModel(this._fetchRemoteConfigUseCase);

  bool get isLoading => _isLoading;
  String? get configValue => _configValue;
  String? get error => _error;

  Future<void> fetchRemoteConfig() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _fetchRemoteConfigUseCase.execute();
    // final configResult = _fetchRemoteConfigUseCase.getStringValue('shouldShowDiscountedPrice');
    // _configValue = configResult.data;
    if (result is DataSuccess<void>) {
      final configResult = _fetchRemoteConfigUseCase.getStringValue('shouldShowDiscountedPrice');
      if (configResult is DataSuccess<String>) {
        _configValue = configResult.data;
      } else if (configResult is DataFailed<String>) {
        _error = configResult.error.toString();
      }
    } else if (result is DataFailed<void>) {
      _error = result.error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
