import 'package:flutter_new_template/core/view/widgets/custom_list_view_builder.dart';

import '../../../export.dart';

class CustomCubitBuilder<T> extends StatelessWidget {
  const CustomCubitBuilder({
    super.key,
    required this.cubit,
    this.onSuccess,
    required this.tryAgain,
    this.onLoading,
    this.onError,
    this.onEmpty,
    this.buildWhen,
    this.listChild,
    this.listHeader,
    this.listSeparatorWidget,
    this.listFooter,
  }) : assert(listChild != null || onSuccess != null);
  final Widget Function(BuildContext, BaseState<T>)? onLoading;
  final Widget Function(BuildContext, BaseState<T>)? onEmpty;
  final Widget Function(BuildContext, BaseState<T>)? onError;

  /// use this if you will custom success widget
  final Widget Function(BuildContext, BaseState<T>)? onSuccess;

  /// use this if you will use success list view builder
  final Widget Function(BuildContext, T data, int index)? listChild;
  final Cubit<BaseState<T>> cubit;
  final Function tryAgain;
  final bool Function(BaseState<T>, BaseState<T>)? buildWhen;
  final Widget? listHeader;
  final Widget? listSeparatorWidget;

  /// usually added for floatingActionButton hiding last list element
  final Widget? listFooter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubit<BaseState<T>>, BaseState<T>>(
        bloc: cubit,
        buildWhen: buildWhen,
        builder: (ctx, state) {
          switch (state.status) {
            case RxStatus.loading:
              return onLoading != null
                  ? onLoading!(context, state)
                  : const Center(child: CircularProgressIndicator());
            case RxStatus.error:
              return onError != null
                  ? onError!(context, state)
                  : Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.errorMessage ?? 'error occurred'),
                        10.heightBox,
                        RoundedCornerLoadingButton(
                            text: 'try again',
                            onPressed: () async {
                              await tryAgain();
                            })
                      ],
                    ));
            case RxStatus.empty:
              return onEmpty != null
                  ? onEmpty!(context, state)
                  : const Center(child: Text('no data'));
            default:
              return onSuccess != null
                  ? onSuccess!(context, state)
                  : CustomListViewBuilder(
                      itemCount: listLength(state),
                      itemBuilder: (context, index) =>
                          listChild!(context, state.data as T, index),
                      footer: listFooter,
                      header: listHeader,
                      separatorWidget: listSeparatorWidget,
                    );
          }
        });
  }

  listLength(BaseState<T> state) {
    if (state.data is List) {
      return (state.data! as List).length;
    } else {
      Logger().e('state.data is not list  ');
      return 0;
    }
  }
}
