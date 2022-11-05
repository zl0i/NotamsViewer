#include "notamsmodel.h"

NotamsModel::NotamsModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

int NotamsModel::rowCount(const QModelIndex &) const
{
    return array.count();
}

QVariant NotamsModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > array.count())
        return QVariant();

    const QJsonObject n = array.at(index.row()).toObject();

    switch (role) {
    case NotamIDRole:
        return n.value("id").toString();
    case StartDateRole:
        return n.value("start_date").toVariant();
    case EndDateRole:
        return n.value("end_date").toVariant();
    case CreateDateRole:
        return n.value("create_date").toVariant();
    case TextRole:
        return n.value("text").toVariant();
    case FLStartRole:
        return n.value("fl_start").toVariant();
    case FLEndRole:
        return n.value("fl_end").toVariant();
    case IsUNLRole:
        return n.value("isUNL").toBool();
    case PointsRole:
        return n.value("points").toArray();
    case DurationSecRole:
        return n.value("duration_sec").toVariant();
    case DurationStrRole:
        return n.value("duration_str").toVariant();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> NotamsModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[NotamIDRole] = "notamID";
    roles[StartDateRole] = "startDate";
    roles[EndDateRole] = "endDate";
    roles[CreateDateRole] = "createDate";
    roles[TextRole] = "text";
    roles[FLStartRole] = "flStart";
    roles[FLEndRole] = "flEnd";
    roles[IsUNLRole] = "isUNL";
    roles[PointsRole] = "points";
    roles[DurationSecRole] = "durationSeconds";
    roles[DurationStrRole] = "durationHumon";
    return roles;
}

void NotamsModel::parse(QJsonArray array)
{
    beginRemoveRows(QModelIndex {}, 0, this->array.count());
    endRemoveRows();
    beginInsertRows(QModelIndex {}, 0, array.count()-1);
    this->array = array;
    endInsertRows();
    emit dataChanged(index(0, 0), index(rowCount()-1, 0));
}
