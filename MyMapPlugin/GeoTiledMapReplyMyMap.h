#pragma once
#include <QtNetwork/QNetworkReply>
#include <QtLocation/private/qgeotiledmapreply_p.h>

QT_BEGIN_NAMESPACE

/**
 * @brief 处理请求的相应
 * @author 龚建波
 * @date 2021-07-03
 */
class GeoTiledMapReplyMyMap: public QGeoTiledMapReply
{
    Q_OBJECT

public:
    GeoTiledMapReplyMyMap(QNetworkReply *reply, const QGeoTileSpec &spec,
                          const QString &imageFormat, QObject *parent = nullptr);

private Q_SLOTS:
    void networkReplyFinished();
    void networkReplyError(QNetworkReply::NetworkError error);
};
QT_END_NAMESPACE

