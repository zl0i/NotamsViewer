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
    bool sortUNL = false;
    bool sortArea = false;

signals:

public slots:
    void setFilter(QJsonObject filter);
    void resetFilter();

};

#endif // PROXYNOTAMSMODEL_H
