import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../functions/print_function.dart';
import 'custom_loader.dart';
import 'custom_text.dart';

class CustomPaginatedListView<T> extends StatefulWidget {
  final NullableIndexedWidgetBuilder? itemBuilder;
  final Widget? child;
  final ScrollPhysics physics;
  final int? itemCount;
  final bool load;
  final String noDataText;
  final Color? noDataColor;
  final Function()? onMaxScrollExtent;
  final bool reverse;
  final bool isLastPage;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final  Future<void> Function()? onRefresh;
  final void Function()? onBackInitialScroll;
  final Future<void> Function() onLoadMore;
  const CustomPaginatedListView({
    super.key,
    required this.itemBuilder,
    this.physics = const AlwaysScrollableScrollPhysics(),
    required this.itemCount,
    this.child,
    this.padding,
    this.onMaxScrollExtent,
    this.onBackInitialScroll,
    required this.onLoadMore,
     this.isLastPage = false,
    this.noDataColor,
    this.load = false,
    this.onRefresh,
    this.noDataText = 'No data found',
    this.reverse = false,
    this.shrinkWrap = false,
  });

  @override
  State<CustomPaginatedListView<T>> createState() => _CustomPaginatedListViewState<T>();
}

class _CustomPaginatedListViewState<T> extends State<CustomPaginatedListView<T>> {


  ScrollController scrollController = ScrollController();
  bool _isLoading = false;


  initializeListener(){
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        widget.onBackInitialScroll?.call();
      }
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        print("adadtadtadtdatdatdtadtadta:::::::::::scrolllll mxxxxxx");

        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (!widget.isLastPage) {
          await widget.onLoadMore();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    initializeListener();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    if(widget.load){
      return CustomLoader();
    }
    if(widget.itemCount==0){
      return  RefreshIndicator(
        onRefresh: ()async{
          print('refresh is called from ${widget.itemCount} count');
          try{
            await widget.onRefresh!();
          }catch(e){
            print('Error in catch block, refresh function not set');
          }
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: widget.shrinkWrap?MediaQuery.of(context).size.height-280:null,
            child: Center(
              child: ParagraphText(widget.noDataText, color: widget.noDataColor,),
            ),
          ),
        ),
      );
    }


    return RefreshIndicator(
      onRefresh: ()async{
        print('refresh is called from ${widget.itemCount} count');
        widget.onRefresh;
      },
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (scroll) {
          myCustomPrintStatement('Notification is listened');

          if (scroll.metrics.maxScrollExtent == scroll.metrics.pixels) {
            myCustomPrintStatement('Notification is listened...max extent reached');

            if(widget.onMaxScrollExtent!=null){
              widget.onMaxScrollExtent!();
            }
          }
          return true;
        },
        child: ListView.builder(
          itemBuilder: widget.itemBuilder??(context, index){
            return widget.child;
          },
          controller: scrollController,
          reverse: widget.reverse,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          itemCount: widget.itemCount,
          padding: widget.padding,

        ),
      ),
    );
  }
}
