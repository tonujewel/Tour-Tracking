import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Widget childs;
  final bool isLoading;
  final void Function() onPressed;
  final Color backgroundColor;
  final BoxDecoration decoration;
  final Widget loadingWidget;
  final bool defaultStyle;
  final String text;

  const LoadingButton(
      {Key key,
      this.childs,
      this.onPressed,
      this.isLoading = false,
      this.backgroundColor,
      this.decoration,
      this.loadingWidget,
        this.text,
      this.defaultStyle = false})
      : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  BoxDecoration decoration;
  Widget loadingWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buildDecoration();
    buildLoadingWidget();
  }

  void buildDecoration() {
    decoration = widget.decoration ??
        BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        );
  }

  void buildLoadingWidget() {
    loadingWidget = loadingWidget ??
        SizedBox(
          width: widget.defaultStyle ? 25 : 10,
          height: 25,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
          ),
        );
  }

  double mainWidth;
  static double padding = 16.0;
  static double textSizeBig = 16.0;
  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    buildDecoration();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          padding: widget.isLoading ? EdgeInsets.all(10) : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: widget.isLoading ? decoration.copyWith(borderRadius: BorderRadius.circular(100)) : decoration,
          child: widget.isLoading
              ? loadingWidget
              : Container(
                  height: 25,
                  width: mainWidth - 20 - (padding * 2),
                  alignment: Alignment.center,
                  child: Text(
                    "${widget.text}",
                    style:
                        TextStyle(color: Colors.white, fontSize: textSizeBig, fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );
  }
}
