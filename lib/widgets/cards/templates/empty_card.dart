import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../card_favorite.dart';

class EmptyCard extends BaseCard {
  @override
  _EmptyCardState createState() => _EmptyCardState();
}

class _EmptyCardState extends BaseCardState<EmptyCard> {
  @override
  Widget card() {
    return Opacity(
      opacity: 0.4,
      child: CardFavorite(
        height: 65,
        header: CardHeader(
          title: 'Error al obtener cotización',
          shareButton: null,
        ),
        direction: Axis.vertical,
        rates: [],
        logo: CardLogo(
          iconData: FontAwesomeIcons.times,
          tag: null,
        ),
        gradiantColors: DolarBotConstants.kGradiantError,
        lastUpdated: null,
      ),
    );
  }
}
