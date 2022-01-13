#ifndef PROXYNOTAMSMODEL_H
#define PROXYNOTAMSMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

#include "notamsmodel.h"

class ProxyNotamsModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit ProxyNotamsModel(QObject *parent = nullptr);

    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private:
    QString sortId;
    int sortFlStart = -1;
    int sortFlEnd = -1;
    QString sortRegExp;
    int sortDuration = 0;
    QString compareDuration = "";


signals:

public slots:
    void setFilter(QString id, int flStart, int flEnd, QString regExp, int duration, QString compare);
    void resetFilter();

};

#endif // PROXYNOTAMSMODEL_H
