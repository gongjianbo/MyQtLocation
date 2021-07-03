# Warning (2021-7-4)

The old code branches in v1.0.0. Currently refactoring...

旧版代码在v1.0.0分支，当前正在重构中...

# MyQtLocation

Qt Location custom plugin,map tiles can be loaded.

自定义Qt Location插件，可用于加载瓦片地图。

我的CSDN博客：https://blog.csdn.net/gongjianbo1992/article/details/103655126

# Note（注意）

1.Tested at Qt5.12+MSVC2017/Qt5.15+MSVC2019. 测试环境为Qt5.12+MSVC2017及Qt5.15+MSVC2019

2.In MinGW, location and control2 cannot be mixed. 在MinGW中，不能把location和control2混用

3.In MinGW, Map cannot be loaded with QQuickWidget. 在MinGW中，不能用QQuickWidget加载Map

4.When you switch focus, the map will have white blocks. You can set the transparency of the map or the parent item to 0.99. 切换焦点时，地图会有白块，可将地图或上级Item设置透明度为0.99

5.The tile calculation and organization of each map are different. The tiles of this demo Google map and Gaode map are available. 每种地图的瓦片计算和组织都有差异，本Demo谷歌地图和高德地图的瓦片可用

# Reference（参考）

1.Qt官方文档及源码 https://doc.qt.io/qt-5/qtlocation-geoservices.html

2.https://github.com/mavlink/qgroundcontrol

3.https://github.com/vladest/googlemaps

4.https://github.com/wangpengcheng/OfflineMapTest

5.百度和高德瓦片组织方式 https://blog.csdn.net/qq_28459505/article/details/83176577

