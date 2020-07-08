# MyQtLocation

Qt Location custom plugin,map tiles can be loaded.

自定义Qt Location插件，可用于加载瓦片地图。

我的CSDN博客：https://blog.csdn.net/gongjianbo1992/article/details/103655126

# Note（注意）

1.Tested at Qt5.12+MSVC2017/Qt5.15+MSVC2019. 测试环境为Qt5.12+MSVC2017及Qt5.15+MSVC2019

2.Using ArcGIS Server to organize tiles. 瓦片图片使用ArcGIS Server组织方式

3.After testing, the tiles of Google-maps and GaoDe-maps are available, but the tiles of Baidu-maps are not organized in the same way. 经测试，谷歌地图和高德地图的瓦片可用，但是百度地图的瓦片组织方式不一样，用百度地图需要改下加载的路径拼接

4.In MinGW, location and control2 cannot be mixed. 在MinGW中，不能把location和control2混用

5.In MinGW, Map cannot be loaded with QQuickWidget. 在MinGW中，不能用QQuickWidget加载Map

6.When you switch focus, the map will have white blocks. You can set the transparency of the map or the parent item to 0.99. 切换焦点时，地图会有白块，可将地图或上级Item设置透明度为0.99

7.Currently, there is no management of tile cache. After tile update, it needs to be cleaned manually (Windows in AppData\Local\cache\QtLocation). 目前没有对瓦片缓存进行管理，更新瓦片后需要手动清理(Windows在AppData\Local\cache\QtLocation)

# Reference（参考）

1.Qt官方文档及源码 https://doc.qt.io/qt-5/qtlocation-geoservices.html

2.https://github.com/mavlink/qgroundcontrol

3.https://github.com/vladest/googlemaps

4.https://github.com/wangpengcheng/OfflineMapTest

5.百度和高德瓦片组织方式 https://blog.csdn.net/qq_28459505/article/details/83176577

