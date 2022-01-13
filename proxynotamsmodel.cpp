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
    return accept;
}

void ProxyNotamsModel::setFilter(QString id, int flStart, int flEnd, QString regExp, int duration, QString compare)
{
    sortId = id;
    sortFlStart = flStart;
    sortFlEnd = flEnd;
    sortRegExp = regExp;
    sortDuration = duration;
    compareDuration = compare;
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
    invalidateFilter();
}
