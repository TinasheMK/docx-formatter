import 'package:docxform/core/constants/color_constants.dart';
import 'package:docxform/core/widgets/app_button_widget.dart';
import 'package:docxform/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../../core/models/Client.dart';
import '../../../core/models/Memo.dart';

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
              crossAxisCount: _size.width < 650 ? 1 : 1,
              childAspectRatio: _size.width < 650 ? 5 : 8,
              memos: memos,
              callback: callback
          ),
          tablet: InformationCard(
              memos: memos,
              callback: callback
          ),
          desktop: InformationCard(
              childAspectRatio: _size.width < 1400 ? 6 : 6,
              memos: memos,
              callback: callback
          ),
        ),
      ],
    );
  }
}


class InformationCard extends StatefulWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 6,
    required this.memos,
    required this.callback,

  }) : super(key: key);

  final List<Memo> memos;
  final int crossAxisCount;
  final double childAspectRatio;
  final Function(String, String) callback;


  @override
  _InformationCardState createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {


  List<Client> clients = [Client.fromJson({})];

  Future<void> _initClients() async {
    clients = await getClients();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initClients();
  }


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: clients.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          MiniInformationWidget(memo: clients[index], callback:widget.callback),
    );
  }
}

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.memo,
    required this.callback
  }) : super(key: key);
  final Client memo;
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding * 0.4),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue!.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.lightBlue,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 6,),
                    Text(
                      "${widget.memo.name??'Objective Null'}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Visibility(
                      visible: !_visible,
                      child: widget.memo.set=="set"?Icon(Icons.cancel_outlined, size: 18):Icon(Icons.add, size: 18),
                    )
                  ],
                ),
              ),
              onTap: () {
                // _toggle();
                if(widget.memo.set=="set"){
                  widget.callback(widget.memo.id.toString()!, "not");
                  setState(() {
                    widget.memo.set="not";
                  });
                }else{
                  widget.callback(widget.memo.id.toString()!, "set");
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
