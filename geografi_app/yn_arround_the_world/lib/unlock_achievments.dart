import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'unlockablestuff.dart';

// here we use async and shared prefs to create a list of the ulocked object from the json list in unlockablestuff
class UnlockAchievment {
  static const String _friendsKey = 'unlocked_friends';
  static const String _souvenirsKey = 'unlocked_souvenirs';
  //we work with static because we want to acsses this variables in static methods.

  static Future<void> unlockItem(UnlockableThing item) async {
    // we use a static function because we are not working with instances of the items that are being unlocked
    // we get an UnlockableThing type for each item
    final prefs = await SharedPreferences.getInstance();

    final key = item.isItAfriend ? _friendsKey : _souvenirsKey;
    final jsonList =
        prefs.getString(key) ??
        '[]'; //get the list from the respective item, if none return empty list
    final list =
        (jsonDecode(jsonList)
                as List) //we decode the list and use .map to return an iterable of each element in the specific Unlockable thing
            .map((e) => UnlockableThing.fromJson(e))
            .toList(); //we make the iterable into a list

    if (list.any((e) => e.id == item.id))
      return; // we chect that the element isnt allready been decoded (no duplicates)
    list.add(item);
    final updatedJson = jsonEncode(list.map((e) => e.toJson()).toList());
    // we add the element from the list creating an updated json list of elements
    await prefs.setString(
      key,
      updatedJson,
    ); //we store it in the shared preferences an give it the updatedJson tag
  }

  static Future<List<UnlockableThing>> getFriends() async {
    final prefs = await SharedPreferences.getInstance();
    final json =
        prefs.getString(_friendsKey) ??
        '[]'; //we acsses the previos stores updated json in the shared prefs
    return (jsonDecode(json) as List)
        .map((e) => UnlockableThing.fromJson(e))
        .toList();
  }

  static Future<List<UnlockableThing>> getSouvenirs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_souvenirsKey) ?? '[]'; //same here
    return (jsonDecode(json) as List)
        .map((e) => UnlockableThing.fromJson(e))
        .toList();
  }
}
