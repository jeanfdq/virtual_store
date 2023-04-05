import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/dialog.dart';
import 'package:virtual_store/components/spacers.dart';
import 'package:virtual_store/models/product_cart.dart';
import 'package:virtual_store/models/sales_order.dart';
import 'package:virtual_store/services/admin_sales_order_manager.dart';
import 'package:virtual_store/services/user_account_manager.dart';

class SaleOrderProductTile extends StatelessWidget {
  const SaleOrderProductTile(
      {super.key, required this.saleOrder, required this.product});

  final SalesOrder saleOrder;
  final ProductCart product;

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<UserAccountmanager>().isAdmin;
    final adminSalesOrderManager = context.read<AdminSalesOrdersManager>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Image.network(
              product.product.images.first,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  product.product.name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SpacerHeight.h5(),
              Text(
                'Tamanho: ${product.size}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SpacerHeight.h15(),
              Text(
                'R\$ ${product.itemPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SpacerHeight.h10(),
              Visibility(
                visible: isAdmin,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 60,
                  width: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        bottom: 0,
                        child: Container(
                          height: 20,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onLongPress: () {
                                      salesOrderStatusChangeDialog(
                                          context,
                                          adminSalesOrderManager,
                                          SaleOrderStatus.canceled,
                                          'Deseja realmente "CANCELAR" o pedido?');
                                    },
                                    child: const Tooltip(
                                      message: 'Cancelar pedido',
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: Icon(
                                        Icons.cancel_presentation,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onLongPress: () {
                                      salesOrderStatusChangeDialog(
                                          context,
                                          adminSalesOrderManager,
                                          SaleOrderStatus.preparing,
                                          'Deseja realmente colocar em "PREPARAÇÃO" o pedido?');
                                    },
                                    child: const Tooltip(
                                      message: 'Pedido em preparação',
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: Icon(
                                        Icons.gesture,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onLongPress: () {
                                      salesOrderStatusChangeDialog(
                                          context,
                                          adminSalesOrderManager,
                                          SaleOrderStatus.transporting,
                                          'Deseja realmente colocar em "TRANSPORTE" o pedido?');
                                    },
                                    child: const Tooltip(
                                      message: 'Pedido em transporte',
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: Icon(
                                        Icons.connecting_airports,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onLongPress: () {
                                      salesOrderStatusChangeDialog(
                                          context,
                                          adminSalesOrderManager,
                                          SaleOrderStatus.delivered,
                                          'Deseja realmente colocar como "ENTREGUE" o pedido?');
                                    },
                                    child: const Tooltip(
                                      message: 'Pedido entregue',
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: Icon(
                                        Icons.download_done,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Alterar de status',
                          style: TextStyle(backgroundColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              product.quantity.toString(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void salesOrderStatusChangeDialog(
      BuildContext context,
      AdminSalesOrdersManager adminSalesOrderManager,
      SaleOrderStatus status,
      String message) {
    return context.showDialog(
        title: 'Cancelar Pedido',
        text: message,
        onCancelText: 'Não',
        onCancel: () {},
        onConfirmText: 'Sim',
        onConfirm: () async {
          saleOrder.status = status;
          final isCancel =
              await adminSalesOrderManager.cancelSaleOrder(saleOrder);
          final String message =
              isCancel ? 'Pedido cancelado com sucesso!' : 'Algo deu errado!';
          final backgroud = isCancel ? Colors.green : Colors.red;
          Get.snackbar('Alteração de status', message,
              backgroundColor: backgroud);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        });
  }
}
