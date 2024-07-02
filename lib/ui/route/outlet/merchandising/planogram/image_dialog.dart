import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog({super.key});

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    ))
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage=value;
                  });
                },
                children: const <Widget>[
                  Center(
                    child: Image(
                        image: AssetImage("assets/images/traditional_trade.png")),
                  ),
                  Center(
                    child: Image(
                        image: AssetImage('assets/images/modern_trade.png')),
                  ),
                  Center(
                    child: Image(
                        image: AssetImage('assets/images/double_door_trade.png')),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 50, left: 10, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          _previousPage();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                  ),
                  Text(
                    "${_currentPage + 1}/3",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          _nextPage();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
