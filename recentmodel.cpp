#include "recentmodel.h"

RecentModel::RecentModel(QObject *parent)
    : QAbstractListModel{parent}, file("./recents.json")
{
    if(file.open(QIODevice::ReadWrite)) {
        array = QJsonDocument::fromJson(file.readAll()).array();
        emit dataChanged(index(0, 0), index(rowCount()-1, 0));

    }
}

RecentModel::~RecentModel()
{
    qDebug() << "tut";
    QJsonDocument doc(array);
    file.resize(0);
    file.write(doc.toJson());
    file.close();
}

int RecentModel::rowCount(const QModelIndex&) const
{
    return array.count();
}

QVariant RecentModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > array.count())
        return QVariant();

    const QJsonObject n = array.at(index.row()).toObject();

    switch (role) {
    case NameRoles:
        return n.value("name").toVariant();
    case ICAOSRoles:
        return n.value("icaos").toString();
    case FilterRoles:
        return n.value("filters").toVariant();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> RecentModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[NameRoles] = "name";
    roles[ICAOSRoles] = "icaos";
    roles[FilterRoles] = "filters";
    return roles;
}

void RecentModel::add(QString name, QString icaos, QJsonObject filter)
{
    array.append(QJsonObject {
                     {"name", name},
                     {"icaos", icaos},
                     {"filter", filter}
                 });
}

