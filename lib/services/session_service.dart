import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_goal_session.dart';

class SessionService extends ChangeNotifier {
  static final SessionService _instance = SessionService._internal();
  static SessionService get instance => _instance;

  SessionService._internal();

  static const String _keyIsLoggedIn = 'auth_is_logged_in';
  static const String _keyUserEmail = 'auth_user_email';
  static const String _keyGoalSession = 'user_goal_session_json';

  SharedPreferences? _prefs;
  bool _isLoggedIn = false;
  String? _userEmail;
  UserGoalSession? _savedSession;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  UserGoalSession? get savedSession => _savedSession;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = _prefs?.getBool(_keyIsLoggedIn) ?? false;
    _userEmail = _prefs?.getString(_keyUserEmail);
    final sessionJsonStr = _prefs?.getString(_keyGoalSession);
    if (sessionJsonStr != null && sessionJsonStr.isNotEmpty) {
      try {
        final map = jsonDecode(sessionJsonStr) as Map<String, dynamic>;
        _savedSession = UserGoalSession.fromMap(map);
      } catch (e) {
        debugPrint('Error loading saved session: $e');
      }
    }
    notifyListeners();
  }

  Future<void> login({required String email, UserGoalSession? session}) async {
    _isLoggedIn = true;
    _userEmail = email;
    if (session != null) {
      _savedSession = session;
    }
    await _prefs?.setBool(_keyIsLoggedIn, true);
    await _prefs?.setString(_keyUserEmail, email);
    if (_savedSession != null) {
      await _prefs?.setString(
        _keyGoalSession,
        jsonEncode(_savedSession!.toMap()),
      );
    }
    notifyListeners();
  }

  Future<void> saveGoalSession(UserGoalSession session) async {
    _savedSession = session;
    await _prefs?.setString(
      _keyGoalSession,
      jsonEncode(session.toMap()),
    );
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userEmail = null;
    await _prefs?.setBool(_keyIsLoggedIn, false);
    await _prefs?.remove(_keyUserEmail);
    notifyListeners();
  }
}
