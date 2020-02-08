#include "BoundaryModel.h"

#include <QGuiApplication>
#include <QFile>
#include <QDir>
#include <QRegularExpression>
//QT += concurrent
#include <QtConcurrentRun>

#include <QDebug>

BoundaryModel::BoundaryModel(QObject *parent)
    : QAbstractListModel(parent)
{
    qRegisterMetaType<QList<QList<double>>>("QList<QList<double>>");
    connect(this,&BoundaryModel::loadFinish,this,&BoundaryModel::updateData);
}

void BoundaryModel::classBegin()
{

}

void BoundaryModel::componentComplete()
{
    if(_loadPath.isEmpty()){
        _loadPath=qApp->applicationDirPath()+"/pathfiles/";
    }
    loadData();
}

QHash<int, QByteArray> BoundaryModel::roleNames() const
{
    return QHash<int,QByteArray>{{Qt::UserRole,"boundary"}};
}

int BoundaryModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    //qDebug()<<"BoundaryModel::rowCount"<<_data.count()<<parent.isValid();
    return _id.count();
}

QVariant BoundaryModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(index)
    Q_UNUSED(role)
    //qDebug()<<"BoundaryModel::data";
    return QVariant();
}

int BoundaryModel::getId(int index)
{
    if(index<0||index>_id.count())
        return -1;
    return _id.at(index);
}

QList<double> BoundaryModel::getLatitudes(int index)
{
    if(index<0||index>_id.count())
        return QList<double>();
    return _latitudes.at(index);
}

QList<double> BoundaryModel::getLongitudes(int index)
{
    if(index<0||index>_id.count())
        return QList<double>();
    return _longitudes.at(index);
}

void BoundaryModel::loadData()
{
    if(_loadPath.isEmpty())
        return;
    QtConcurrent::run([this](){
        doLoad(_loadPath);
    });
}

void BoundaryModel::updateData(const QList<int> &idList,
                               const QList<QList<double> > &latitudesList,
                               const QList<QList<double> > &longitudesList)
{
    if(idList.count()!=latitudesList.count()
            ||latitudesList.count()!=longitudesList.count())
        return;
    beginResetModel();
    _id=idList;
    _latitudes=latitudesList;
    _longitudes=longitudesList;
    endResetModel();
}

void BoundaryModel::doLoad(const QString &path)
{
    QList<int> id_list;
    QList<QList<double>> latitude_list;
    QList<QList<double>> longitude_list;

    //读取指定路径下的txt文件，并解析为坐标点List
    //const QString path=qApp->applicationDirPath()+"/data/PageBoundary/";
    QDir dir(path);
    const QStringList file_list = dir.entryList(QStringList{"*.txt"},
                                                QDir::Files|QDir::Readable, QDir::Name);
    QRegularExpression re(R"(:\s*([0-9\.]+))");
    const int capturingGroupsCount = re.captureCount() + 1;
    if(capturingGroupsCount!=2)
        return;
    for(int i=0;i<file_list.count();i++){
        QFile file(path+file_list.at(i));
        if(file.open(QIODevice::ReadOnly|QIODevice::Text)){
            QList<double> one_lat,one_long;
            double first_lat,first_long;
            bool is_first=true;
            while (!file.atEnd()) {
                QString line = QString::fromLatin1(file.readLine());
                if(line.isEmpty()) continue;
                //QRegularExpressionMatch match=re.match(line);
                //if(match.hasMatch()&&match.lastCapturedIndex()==1){
                //    qDebug()<<match.captured(0)<<match.captured(1);
                //}

                QRegularExpressionMatchIterator iterator = re.globalMatch(line);
                double latitude=0,longitude=0;
                if(iterator.hasNext()) {
                    longitude=iterator.next().captured(1).toDouble();
                }
                if(iterator.hasNext()) {
                    latitude=iterator.next().captured(1).toDouble();
                }
                //把飞地单独作为一个区域，但是使用同一个id
                if(is_first){
                    is_first=false;
                    first_lat=latitude;
                    first_long=longitude;
                    one_lat.push_back(latitude);
                    one_long.push_back(longitude);
                }else{
                    //十位小数精度就够了
                    if(qAbs(first_lat-latitude)<1E-10
                            &&qAbs(first_long-longitude)<1E-10){
                        one_lat.push_back(latitude);
                        latitude_list.push_back(one_lat);
                        one_long.push_back(longitude);
                        longitude_list.push_back(one_long);
                        id_list.push_back(i);
                        is_first=true;
                        one_lat.clear();
                        one_long.clear();
                    }else{
                        one_lat.push_back(latitude);
                        one_long.push_back(longitude);
                    }
                }
            }
            file.close();
            if(one_lat.count()>3){
                latitude_list.push_back(one_lat);
                longitude_list.push_back(one_long);
                id_list.push_back(i);
            }
        }else{
            qDebug()<<"open error:"<<path+file_list.at(i)<<file.errorString();
        }
    }
    //qDebug()<<id_list.count()<<data_list.count();
    emit loadFinish(id_list,latitude_list,longitude_list);
}
