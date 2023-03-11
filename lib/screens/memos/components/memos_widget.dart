import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/models/daily_info_model.dart';
import 'package:smart_admin_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../../models/Memo.dart';

class MemoSelectionSection extends StatelessWidget {
  const MemoSelectionSection({
    Key? key,
    required this.memos,
    required this.callback

  }) : super(key: key);

  final Function(String, String) callback;
  final List<Memo> memos;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: InformationCard(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.2 : 1,
            memos: memos,
            callback: callback
          ),
          tablet: InformationCard(
            memos: memos,
            callback: callback
          ),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.3,
            memos: memos,
            callback: callback
          ),
        ),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 1,
    required this.memos,
    required this.callback,

  }) : super(key: key);

  final List<Memo> memos;
  final int crossAxisCount;
  final double childAspectRatio;
  final Function(String, String) callback;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: memos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          MiniInformationWidget(memo: memos[index], callback:callback),
    );
  }
}

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.memo,
    required this.callback
  }) : super(key: key);
  final Memo memo;
  final Function(String, String) callback;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  bool _visible = false;

  TextEditingController _controller = TextEditingController();

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  int charLength = 0;

  bool status = false;
  bool _closeIcon = true;

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });

    if (charLength >= 6) {
      setState(() {
        _closeIcon = _closeIcon;
        status = true;
      });
    } else {
      setState(() {
        _closeIcon = !_closeIcon;
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: widget.memo.set=="set"?darkgreenColor:Colors.black38,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.lightBlue!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(
                  widget.memo.icon,
                  color: Colors.lightBlue,
                  size: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.memo.title!}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Visibility(
                      visible: !_visible,
                      child: widget.memo.set=="set"?Icon(Icons.backspace_outlined, size: 18):Icon(Icons.add, size: 18),
                    )
                  ],
                ),
              ),
              onTap: () {
                // _toggle();
                if(widget.memo.set=="set"){
                  widget.callback(widget.memo.code!, "not");
                  setState(() {
                    widget.memo.set="not";
                  });
                }else{
                  widget.callback(widget.memo.code!, "set");
                  setState(() {
                    widget.memo.set="set";
                  });

                }
              }
              ),

        ],
      ),
    );
  }

}
