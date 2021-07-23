import 'assets.dart';

getRisingBadge(count) {
  count = int.parse(count);
  if (count >= 15 && count < 40)
    return Assets.rlightblue;
  else if (count >= 40 && count < 70)
    return Assets.rlightpurple;
  else if (count >= 70 && count < 100)
    return Assets.rlightpink;
  else if (count >= 100 && count < 125)
    return Assets.rdarkteapink;
  else if (count >= 125)
    return Assets.rldarkpink;
  else
    return " ";
}

getProfessionalBadge(count) {
  count = int.parse(count);
  if (count >= 15 && count < 40)
    return Assets.slightblue;
  else if (count >= 40 && count < 70)
    return Assets.slightpurple;
  else if (count >= 70 && count < 100)
    return Assets.slogopink;
  else if (count >= 100 && count < 125)
    return Assets.sdarkteapink;
  else if (count >= 125)
    return Assets.slightpink;
  else
    return " ";
}
