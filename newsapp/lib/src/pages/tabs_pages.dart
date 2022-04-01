import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _MyPages(),
        bottomNavigationBar: _MyNavigator(),
      ),
    );
  }
}

class _MyNavigator extends StatelessWidget {
  const _MyNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        onTap: (i) => navegationModel.actualPage = i,
        currentIndex: navegationModel.actualPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Para Ti'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: 'Encabezados'),
        ]);
  }
}

class _MyPages extends StatelessWidget {
  const _MyPages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavigationModel>(context);

    return PageView(
        controller: navegationModel.pageController,
        // El never Scrollable physics permite que unicamente se cambien las pestañas con el navigator
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(color: Colors.red),
          Container(color: Colors.green)
        ]);
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  final PageController _pageController = PageController();

  int get actualPage => _actualPage;

  PageController get pageController => _pageController;

  set actualPage(int value) {
    _actualPage = value;
    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInCirc);
    notifyListeners();
  }
}
