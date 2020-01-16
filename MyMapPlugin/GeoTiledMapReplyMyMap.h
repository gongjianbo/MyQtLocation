#ifndef GEOTILEDMAPREPLYMYMAP_H
#define GEOTILEDMAPREPLYMYMAP_H

#include <QtNetwork/QNetworkReply>
#include <QtLocation/private/qgeotiledmapreply_p.h>

QT_BEGIN_NAMESPACE
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

#endif // GEOTILEDMAPREPLYMYMAP_H
