import 'package:flutter/material.dart';
import 'unlockablestuff.dart';
import 'unlock_achievments.dart';
import 'settings.dart';
import 'diplay_cards.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  Set<String> _selected = {'Friendlist'};
  List<UnlockableThing> _friends = [];
  List<UnlockableThing> _souvenirs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final friends = await UnlockAchievment.getFriends();
    final souvenirs = await UnlockAchievment.getSouvenirs();
    if (mounted) {
      //we ensure the widget is still in the widget tree after the await
      setState(() {
        //this so we dont call setState on a widget that is no longer there (disposed)
        _friends = friends;
        _souvenirs = souvenirs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _selected.first == 'Friendlist'
        ? _friends
        : _souvenirs; //is the selected button the friendlist then the item is a friend else a souvenir

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Collection',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        centerTitle: true,
        bottomOpacity: 1.0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          ),

          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: const Icon(Icons.shopping_bag),
            tooltip: 'Shop',
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: const Icon(Icons.person),
            tooltip: 'My account',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.topLeft,
            child: SegmentedButton(
              segments: const <ButtonSegment<String>>[
                ButtonSegment(
                  value: 'Friendlist',
                  label: Text('My global Friends'),
                ),
                ButtonSegment(
                  value: 'Collected Souvenirs',
                  label: Text('Collected Souvenirs'),
                ),
              ],
              selected: _selected,
              onSelectionChanged: (newSelection) {
                setState(() => _selected = newSelection);
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : items.isEmpty
                ? Center(
                    child: Text(
                      _selected.first == 'Friendlist'
                          ? 'No friends unlocked yet!\nComplete quizzes to meet new people.'
                          : 'No souvenirs collected yet!\nFinish tours and quizzes.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Displaycard(
                        // renamed widget
                        title: item.title,
                        info: item.description,
                        image: item.imagePath,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
