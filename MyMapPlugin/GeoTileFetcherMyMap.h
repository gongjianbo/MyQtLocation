#ifndef GEOTILEFETCHERMYMAP_H
#define GEOTILEFETCHERMYMAP_H

#include <QtLocation/private/qgeotilefetcher_p.h>
#include <QNetworkAccessManager>
#include <QVector>

QT_BEGIN_NAMESPACE

class GeoTileFetcherMyMap : public QGeoTileFetcher
{
    Q_OBJECT
public:
    GeoTileFetcherMyMap(
            const QVariantMap &parameters,
            QGeoMappingManagerEngine *parent);

private:
    QGeoTiledMapReply* getTileImage(const QGeoTileSpec &spec) override;
    QString getUrl(const QGeoTileSpec &spec) const;

private:
    QString _baseUrl;
    QString _format{"png"};
    QNetworkAccessManager*  _networkManager;
};
QT_END_NAMESPACE

#endif // GEOTILEFETCHERMYMAP_H
