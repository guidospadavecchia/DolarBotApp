import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';

class EmptyCard extends BaseCard {
  EmptyCard()
      : super(
          title: '',
          showShareButton: false,
          bannerTitle: '',
          gradiantColors: [],
          endpoint: '',
          showPoweredBy: false,
          tag: '',
          numberFormat: NumberFormat.simpleCurrency(),
        );

  @override
  _EmptyCardState createState() => _EmptyCardState();
}

class _EmptyCardState extends BaseCardState<EmptyCard> {
  @override
  Widget card() {
    return const SizedBox.shrink();
  }
}
