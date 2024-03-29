import 'base/base_card.dart';
import 'package:flutter/material.dart';

class EmptyCard extends BaseCard {
  EmptyCard()
      : super(
          title: '',
          showButtons: false,
          bannerTitle: '',
          gradiantColors: [],
          endpoint: '',
          showPoweredBy: false,
          tag: '',
          coloredTag: false,
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
