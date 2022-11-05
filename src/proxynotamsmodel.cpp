#include "proxynotamsmodel.h"

ProxyNotamsModel::ProxyNotamsModel(QObject *parent)
    : QSortFilterProxyModel{parent}
{

}

bool ProxyNotamsModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    bool accept = true;
    if(!sortId.isEmpty()) {
        QString id = sourceModel()->data(index, NotamsModel::NotamIDRole).toString();
        accept &= id.contains(sortId);
    }
    if(sortFlStart != -1) {
        int flStart = sourceModel()->data(index, NotamsModel::FLStartRole).toInt();
        accept &= flStart > sortFlStart;
    }
    if(sortFlEnd != -1) {
        int flEnd = sourceModel()->data(index, NotamsModel::FLEndRole).toInt();
        accept &= flEnd < sortFlEnd;
    }
    if(!sortRegExp.isEmpty()) {
        QString text = sourceModel()->data(index, NotamsModel::TextRole).toString();
        QRegExp reg(sortRegExp, Qt::CaseInsensitive);
        accept &= text.contains(reg);
    }
    if(sortDuration != 0 && !compareDuration.isEmpty()) {
        int duration = sourceModel()->data(index, NotamsModel::DurationSecRole).toInt();
        if(compareDuration == "=") {
            accept &= duration == sortDuration;
        } else if (compareDuration == "<") {
            accept &= duration < sortDuration;
        } else if (compareDuration == ">") {
            accept &= duration > sortDuration;
        } else if (compareDuration == "<=") {
            accept &= duration <= sortDuration;
        } else if (compareDuration == ">=") {
            accept &= duration >= sortDuration;
        }
    }
    if(sortUNL) {
        bool isUNL = sourceModel()->data(index, NotamsModel::IsUNLRole).toBool();
        accept &= isUNL;
    }
    if(sortArea) {
        QJsonArray areas = sourceModel()->data(index, NotamsModel::PointsRole).toJsonArray();
        accept &= !areas.isEmpty();
    }
    return accept;
}

void ProxyNotamsModel::setFilter(QJsonObject filter)
{
    sortId = filter.value("id").toString();
    sortFlStart = filter.value("flStart").toInt();
    sortFlEnd = filter.value("flEnd").toInt();
    sortRegExp = filter.value("regExp").toString();
    sortDuration = filter.value("duration").toInt();
    compareDuration = filter.value("compareDuration").toString();
    sortUNL = filter.value("isUNL").toBool();
    sortArea = filter.value("isArea").toBool();
    invalidateFilter();
}

void ProxyNotamsModel::resetFilter()
{
    sortId = "";
    sortFlStart = -1;
    sortFlEnd = -1;
    sortRegExp = "";
    sortDuration = 0;
    compareDuration = "";
    sortUNL = false;
    sortArea = false;
    invalidateFilter();
}
