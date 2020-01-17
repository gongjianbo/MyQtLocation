#include "GeoTiledMapReplyMyMap.h"

QT_BEGIN_NAMESPACE
GeoTiledMapReplyMyMap::GeoTiledMapReplyMyMap(
        QNetworkReply *reply,
        const QGeoTileSpec &spec,
        const QString &imageFormat,
        QObject *parent)
    :QGeoTiledMapReply(spec, parent)
{
    if (!reply) {
        setError(UnknownError, QStringLiteral("Null reply"));
        return;
    }
    connect(reply, SIGNAL(finished()), this, SLOT(networkReplyFinished()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
            this, SLOT(networkReplyError(QNetworkReply::NetworkError)));
    connect(this, &QGeoTiledMapReply::aborted, reply, &QNetworkReply::abort);
    connect(this, &QObject::destroyed, reply, &QObject::deleteLater);
    setMapImageFormat(imageFormat);
}

void GeoTiledMapReplyMyMap::networkReplyFinished()
{
    QNetworkReply *reply = static_cast<QNetworkReply *>(sender());
    reply->deleteLater();

    if (reply->error() != QNetworkReply::NoError) // Already handled in networkReplyError
        return;

    setMapImageData(reply->readAll());
    setFinished(true);
}

void GeoTiledMapReplyMyMap::networkReplyError(QNetworkReply::NetworkError error)
{
    QNetworkReply *reply = static_cast<QNetworkReply *>(sender());
    reply->deleteLater();
    if (error == QNetworkReply::OperationCanceledError)
        setFinished(true);
    else
        setError(QGeoTiledMapReply::CommunicationError, reply->errorString());
    //可以在这里返回自定义的图片
}

QT_END_NAMESPACE
