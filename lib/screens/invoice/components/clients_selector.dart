import 'package:flutter_svg/svg.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/core/types/daily_info_model.dart';
import 'package:smart_admin_dashboard/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../../core/types/Memo.dart';
import '../../../core/models/Client.dart';

class ClientsSelector extends StatelessWidget {
  const ClientsSelector({
    Key? key,
    required this.callback

  }) : super(key: key);

  final Function(String, String) callback;

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
    String query='';
    return clients.isEmpty? Text("You have not added any clients yet."): SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: secondaryColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              suffixIcon: InkWell(
                onTap: () async {
                   clients = await searchClients(query);
                   setState(() {

                   });
                },
                child: Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Search.svg",
                  ),
                ),
              ),
            ),
            onChanged: (value) async {
              query = value;
              clients = await searchClients(query);
              setState(() {

              });

            },
          ),
          SizedBox(height: 10,),
          GridView.builder(
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
          )
        ],
      ),
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

  int selectedClient = 0;

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
        color: selectedClient==widget.memo.id?darkgreenColor:Colors.black38,
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
                      "${widget.memo.name?? 'Name'}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Visibility(
                      visible: !_visible,
                      child: selectedClient==widget.memo.id?Icon(Icons.cancel_outlined, size: 18):Icon(Icons.add, size: 18),
                    )
                  ],
                ),
              ),
              onTap: () {
                // _toggle();
                if(selectedClient==widget.memo.id){
                  widget.callback(widget.memo.id.toString()!, "not");
                  selectedClient=='';
                  print(selectedClient);
                  Navigator.of(context).pop();
                  setState(() {
                  });
                }else{
                  widget.callback(widget.memo.id.toString()!, "set");
                  selectedClient = widget.memo.id!;
                  print(selectedClient);
                  Navigator.of(context).pop();
                  setState(() {
                  });

                }
              }
              ),

        ],
      ),
    );
  }

}
