#ifndef BOUNDARYMODEL_H
#define BOUNDARYMODEL_H

#include <QAbstractListModel>
#include <QQmlParserStatus>
#include <QList>
#include <QVariant>

class BoundaryModel : public QAbstractListModel, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
public:
    explicit BoundaryModel(QObject *parent = nullptr);

    // QQmlParserStatus：构造前
    void classBegin() override;
    // QQmlParserStatus：构造后
    void componentComplete() override;

    QHash<int,QByteArray> roleNames() const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE int getId(int index);
    Q_INVOKABLE QList<double> getLatitudes(int index);
    Q_INVOKABLE QList<double> getLongitudes(int index);

    //加载数据
    void loadData();
    void updateData(const QList<int> &idList,
                    const QList<QList<double>> &latitudesList,
                    const QList<QList<double>> &longitudesList);

private:
    void doLoad(const QString &path);

signals:
    void loadFinish(const QList<int> &idList,
                    const QList<QList<double>> &latitudesList,
                    const QList<QList<double>> &longitudesList);

private:
    QList<int> _id;
    QList<QList<double>> _latitudes;
    QList<QList<double>> _longitudes;

    QString _loadPath;
};

#endif // BOUNDARYMODEL_H
