import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../layout/adaptive.dart';

class AfrAppBar extends StatefulWidget {
  @override
  _AfrAppBarState createState() => _AfrAppBarState();
}

class _AfrAppBarState extends State<AfrAppBar> with SingleTickerProviderStateMixin {
  AnimationController _menuIconAnimationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _menuIconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _menuIconAnimationController.dispose();
  }

  void _menuIconToggle() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? _menuIconAnimationController.forward() : _menuIconAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black26,
      ),
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: isDesktop ? 250.0 : 160.0,
      
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Image.asset(
          "assets/images/afrLogo.png",
          width: isDesktop ? 100.0 : 70.0,
        ),
        background: Image.asset(
          "assets/images/appBarBackground.jpg",
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        IconButton(
          // color: Colors.black26,
          iconSize: 50,
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _menuIconAnimationController,
            semanticLabel: 'Show menu',
          ),
          onPressed: () {
            _menuIconToggle();
            showGeneralDialog(
              barrierLabel: "Barrier",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.3),
              transitionDuration: Duration(milliseconds: 500),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 55, left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // width: MediaQuery.of(context).size.width * 1,
                    child: SizedBox.expand(
                      child: FlutterLogo()
                    ),
                  ),
                );
              },
              transitionBuilder: (context, animation, anim2, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(1, 0), end: Offset(0, 0))
                      .animate(animation),
                  child: child,
                );
                // return FadeTransition(opacity: animation, child: child,);
                // return ScaleTransition(
                //   scale: animation,
                //   child: child,
                // );
              },
            ).then((returnVal) {
              _menuIconToggle();
            });
          },
        ),
      ],
    );
  }
}
