import 'package:probot/config.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 100,
            leadingWidth: 80,
            automaticallyImplyLeading: false,
            leading: SvgPicture.asset(eSvgAssets.menu).paddingAll(Insets.i8).decorated(color: appCtrl.appTheme.white.withOpacity(.4),borderRadius: BorderRadius.circular(AppRadius.r6)).paddingSymmetric(horizontal: Insets.i20,vertical: Insets.i30),
            pinned: true,
            expandedHeight: 350.0,

            title: Image.asset(eImageAssets.logo1,width: Sizes.s106,),
            centerTitle: true,
            actions: [
              SvgPicture.asset(eSvgAssets.bell).paddingAll(Insets.i12).decorated(color: appCtrl.appTheme.white.withOpacity(.4),borderRadius: BorderRadius.circular(AppRadius.r6)).paddingOnly(top: Insets.i30,bottom: Insets.i25,right: Insets.i20)
            ],
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(

                    gradient: RadialGradient(
                        focalRadius: 1,
                        radius: 1,
                        center: const Alignment(-0.1, 0.1),
                        colors: [
                  appCtrl.appTheme.primary,
                  appCtrl.appTheme.radialGradient
                ])),child: Image.asset(eImageAssets.ob3,fit: BoxFit.contain ,).paddingSymmetric(vertical: Insets.i30),),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
