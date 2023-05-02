enum Flavour {
  apple,
  blueberry,
  bonbon,
  dragonBlood,
  dragonFruit,
  fruitMix,
  grape,
  melon,
  mint,
  passionFruit,
  pineapple,
  raspberry,
  menthol,
  strawberry;

  String toJson() => name;

  String get text {
    switch (this) {
      case Flavour.apple:
        return "Apple";
      case Flavour.blueberry:
        return "Blueberry";
      case Flavour.bonbon:
        return "BonBon";
      case Flavour.dragonBlood:
        return "Dragon Blood";
      case Flavour.dragonFruit:
        return "Dragon Fruit";
      case Flavour.fruitMix:
        return "Fruit Mix";
      case Flavour.grape:
        return "Grape";
      case Flavour.melon:
        return "Melon";
      case Flavour.mint:
        return "Mint";
      case Flavour.passionFruit:
        return "Passion Fruit";
      case Flavour.pineapple:
        return "Pineapple";
      case Flavour.raspberry:
        return "Raspberry";
      case Flavour.menthol:
        return "Menthol (ice)";
      case Flavour.strawberry:
        return "Strawberry";
    }
  }
}

List<Flavour> flavours = <Flavour>[
  Flavour.apple,
  Flavour.blueberry,
  Flavour.bonbon,
  Flavour.dragonBlood,
  Flavour.dragonFruit,
  Flavour.fruitMix,
  Flavour.grape,
  Flavour.melon,
  Flavour.mint,
  Flavour.passionFruit,
  Flavour.pineapple,
  Flavour.raspberry,
  Flavour.menthol,
  Flavour.strawberry,
];
