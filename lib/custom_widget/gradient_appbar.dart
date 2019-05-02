import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kLeadingWidth = kToolbarHeight;

class GradientAppBar extends StatefulWidget implements PreferredSizeWidget{
  final Widget title;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final List<Widget> actions;
  final bool centerTitle;

  GradientAppBar({
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.centerTitle,
  }):preferredSize = Size.fromHeight(kToolbarHeight);

 @override
  _GradientAppBarState createState() => _GradientAppBarState();

  @override
  final Size preferredSize;
}

class _GradientAppBarState extends State<GradientAppBar> {
  static const double _defaultElevation = 4.0;

  @override
  Widget build(BuildContext context) {
    print("Test1");
    // final AppBarTheme appBarTheme = AppBarTheme.of(context);
    // TextStyle centerStyle = appBarTheme.textTheme.title;
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    Widget title = widget.title;
        
    if (title != null) {
      bool namesRoute;
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
           namesRoute = true;
           break;
        case TargetPlatform.iOS:
          break;
      }
      title = DefaultTextStyle(
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Semantics(
          namesRoute: namesRoute,
          child: title,
          header: true,
        ),
      );
    }

    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (canPop){
        leading = const BackButton(
          color: Colors.white,
        );
      }
    }

    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: _kLeadingWidth),
        child: leading,
      );
    }

    Widget actions;
    if (widget.actions != null && widget.actions.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions,
      );
    } 

    // Allow the trailing actions to have their own theme if necessary.
    if (actions != null) {
      actions = IconTheme.merge(
        // data: actionsIconTheme,
        child: actions,
      );
    }

    return PreferredSize(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: leading!=null 
                ? leading
                : Container(),
            ),
            Container(
              child: title,
            ),
            Container(
              child: Container(
                child: actions,
              ),
            ),
          ],
        ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink[300],
            Colors.pink[100],
          ]
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            blurRadius: 5.0,
            spreadRadius: 1.0,
          )
        ]
      ),
    ),
      preferredSize: new Size(
        MediaQuery.of(context).size.width,
        100.0
      ),
    );
  }
}

