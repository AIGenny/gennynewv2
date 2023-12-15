import 'package:flutter/cupertino.dart';

class ReusableBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  ReusableBottomNavigationBar({
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      activeColor: CupertinoColors.white,
      backgroundColor: CupertinoColors.black,
      currentIndex: currentIndex,
      onTap: onPageChanged,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.add),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.shopping_cart),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bell),
          label: '',
        ),
      ],
    );
  }
}
