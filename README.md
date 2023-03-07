# bienvx_test_newwave_solutions_jsc

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
#   b i e n v x _ t e s t _ f l u t t e r 
 
 

#GetBuilder<Controller>(
init: Controller(),
builder: (controller) {
final data = controller.categoryModel;
return GridView.count(
crossAxisSpacing: 20,
mainAxisSpacing: 20,
crossAxisCount: 2,
shrinkWrap: true,
physics: const ScrollPhysics(),
childAspectRatio: (itemWidth / itemHeight),
children: [
...data.map((e) {
final releaseDate = e.releaseDate?.substring(0, 4);
// double p = double.parse(e.voteAverage.toString());
// print(p);
final voteAverage1 = e.voteAverage.toString()[0];
final voteAverage2 = num.tryParse('${e.voteAverage}')?.toDouble();
final voteAverageFix = voteAverage2.toString()[2];
return Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),
boxShadow: [
BoxShadow(
color: Colors.grey.withOpacity(0.7),
spreadRadius: 5,
blurRadius: 7,
offset: const Offset(
0, 8), // changes position of shadow
),
],
),
child: Stack(
children: [
ClipRRect(
borderRadius: BorderRadius.circular(8),
child: Image.network(
'https://image.tmdb.org/t/p/w500/${e.posterPath}',
height: 500,
width: 200,
fit: BoxFit.cover,
)),
Positioned(
left: 5,
bottom: 10,
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
releaseDate ?? '',
style: const TextStyle(
color: Colors.white70,
fontWeight: FontWeight.w500),
),
const SizedBox(
height: 5,
),
SizedBox(
width: Get.size.width / 3,
child: Text(
e.originalTitle ?? '',
maxLines: 2,
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.w800,
overflow: TextOverflow.ellipsis,
),
),
)
],
)),
Positioned(
right: 10,
top: 10,
child: Container(
decoration: const BoxDecoration(
shape: BoxShape.circle,
gradient: LinearGradient(
begin: Alignment.topLeft,
colors: [
Color(0xfff2831b),
Color(0xfff2831b),
Color(0xffe16b5c),
Color(0xffca485c),
],
),
),
child: CircleAvatar(
radius: 20, // Im
backgroundColor: Colors.transparent,
// age radius
child: Row(
mainAxisAlignment:
MainAxisAlignment.center,
children: [
Text(
voteAverage1,
style: const TextStyle(fontSize: 25),
),
const Text('.'),
Text( voteAverageFix,
style:
const TextStyle(fontSize: 15)),
],
)),
))
],
),
);
})
],
);
})