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


signals:

public slots:
    void setFilter(QString id, int flStart, int flEnd, QString regExp);
    void resetFilter();

};

#endif // PROXYNOTAMSMODEL_H
