import '../../../../../config.dart';

class Clipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 1 / 5, 0.0);
    path.lineTo(size.width * 1 / 5, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 1 / 5, 0.0);
    path.lineTo(size.width * 2 / 5, 0.0);
    path.lineTo(size.width * 2 / 5, size.height);
    path.lineTo(size.width * 1 / 5, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 2 / 5, 0.0);
    path.lineTo(size.width * 3 / 5, 0.0);
    path.lineTo(size.width * 3 / 5, size.height);
    path.lineTo(size.width * 2 / 5, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 3 / 5, 0.0);
    path.lineTo(size.width * 4 / 5, 0.0);
    path.lineTo(size.width * 4 / 5, size.height);
    path.lineTo(size.width * 3 / 5, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 4 / 5, 0.0);
    path.lineTo(size.width * 5 / 5, 0.0);
    path.lineTo(size.width * 5 / 5, size.height);
    path.lineTo(size.width * 4 / 5, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
