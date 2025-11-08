class ForceUpdateState {
  static bool _isForceUpdateActive = false;
  
  static bool get isForceUpdateActive => _isForceUpdateActive;
  
  static void setForceUpdateActive(bool active) {
    _isForceUpdateActive = active;
  }
}
