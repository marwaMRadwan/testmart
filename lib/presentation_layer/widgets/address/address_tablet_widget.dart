import 'package:flutter/material.dart';
import 'package:martizoom/business_logic_layer/addresses_cubit/addresses_cubit.dart';
import 'package:martizoom/data_layer/models/address_model.dart';
import 'package:martizoom/presentation_layer/screens/add_update_address/add_update_address_tablet_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';

class AddressTabletWidget extends StatelessWidget {
  final AddressModel addressModel;

  const AddressTabletWidget({Key? key, required this.addressModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _addressesCubit = AddressesCubit.get(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: setWidthValue(
          portraitValue: 0.02,
          landscapeValue: 0.015,
        ),
        vertical: setHeightValue(
          portraitValue: 0.02,
          landscapeValue: 0.02,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color:

            /// checking the address is default or not
            /// and give the card a specific color
            addressModel.flag != '0'
                ? Colors.red[100]?.withOpacity(0.5)
                : addressModel.isDefault == '1'
                    ? Colors.grey[300]
                    : Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: Colors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// address name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: setWidthValue(
                      portraitValue: 0.005,
                      landscapeValue: 0.005,
                    ),
                  ),
                  child: Text(
                    '${addressModel.building}, ${addressModel.street}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (addressModel.flag != '0')
                Text(
                  appLocalization!.disabled,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
            ],
          ),

          ///address details
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidthValue(
                portraitValue: 0.005,
                landscapeValue: 0.005,
              ),
            ),
            child: Text(
              addressModel.additionalAddressInfo ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// checking the address is enabled or not
              /// and show the enabling details
              if (addressModel.flag == '0')

                /// checking the address is default or not
                /// and show the consistent widget (text,button)
                addressModel.isDefault != null && addressModel.isDefault == '1'
                    ? Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFce0900),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: EdgeInsets.symmetric(
                          vertical: setHeightValue(
                            portraitValue: 0.01,
                            landscapeValue: 0.01,
                          ),
                          horizontal: setWidthValue(
                            portraitValue: 0.008,
                            landscapeValue: 0.008,
                          ),
                        ),
                        child: Text(
                          appLocalization!.defaultAddress,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _addressesCubit.setDefaultAddress(
                              addressId: addressModel.id ?? '0');
                        },
                        child: Text(appLocalization!.setAsDefaultAddress),
                      ),
              Expanded(child: Container()),

              /// delete and edit
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _addressesCubit.deleteUserAddress(
                          addressId: addressModel.id ?? '0');
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[600],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      navigateTo(
                        context: context,
                        screen: AddUpdateAddressTabletScreen(
                          addressModel: addressModel,
                          isDefaultAddress: addressModel.isDefault == '1',
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
