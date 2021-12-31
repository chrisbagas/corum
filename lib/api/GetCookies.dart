import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ConnectNetworkService {
  Map<String, String> headers = {};
  Map<String, String> cookies = {};
  final http.Client _client = http.Client();

  late SharedPreferences local;

  bool loggedIn = false;
  bool initialized = false;
  String username = "";

  Future init(BuildContext context) async {
    if (!initialized) {
      local = await SharedPreferences.getInstance();
      String? savedCookies = local.getString("cookies");
      if (savedCookies != null) {
        cookies = Map<String, String>.from(json.decode(savedCookies));
        if (cookies['sessionid'] != null) {
          loggedIn = true;
          headers['cookie'] = _generateCookieHeader();
        }
      }
    }
    initialized = true;
  }

  Future persist(String cookies) async {
    local.setString("cookies", cookies);
  }

  Future<dynamic> login(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }

    http.Response response =
        await _client.post(Uri.parse(url), body: data, headers: headers);

    _updateCookie(response);

    if (response.statusCode == 200) {
      loggedIn = true;
      username = json.decode(response.body)['username'];
    } else {
      loggedIn = false;
    }

    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<dynamic> get(String url) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    http.Response response =
        await _client.get(Uri.parse(url), headers: headers);
    _updateCookie(response);
    return response.toString();
  }

  Future<dynamic> post(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    http.Response response =
        await _client.post(Uri.parse(url), body: data, headers: headers);
    _updateCookie(response);
    return response.toString();
  }

  Future<dynamic> postJson(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    // Add additional header
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    http.Response response =
        await _client.post(Uri.parse(url), body: data, headers: headers);
    // Remove used additional header
    headers.remove('Content-Type');
    _updateCookie(response);
    return response.toString();
  }

  Future<dynamic> postMultipart(
      String url, Map<String, String> data, String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(data)
      ..files.add(await http.MultipartFile.fromPath('thumbnail', filePath))
      ..headers.addAll(headers);

    var streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    _updateCookie(response);
    return response.toString();
  }

  void _updateCookie(http.Response response) {
    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
      String cookieObject = (const JsonEncoder()).convert(cookies);
      persist(cookieObject);
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      String? newCookie = cookies[key];
      cookie += '$key=$newCookie';
    }

    return cookie;
  }

  Future<dynamic> logoutAccount(String url) async {
    http.Response response = await _client.post(Uri.parse(url));

    if (response.statusCode == 200) {
      loggedIn = false;
      username = "";
    } else {
      loggedIn = true;
    }

    cookies = {};

    return json.decode(response.body);
  }
}
