#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

#include "notamsloader.h"
#include "notamsmodel.h"
#include "proxynotamsmodel.h"

class AppCore : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ProxyNotamsModel* notams READ notams NOTIFY notamsChanged)
public:
    explicit AppCore(QObject *parent = nullptr);

    ProxyNotamsModel* notams() { return &proxyNotams; }

private:
    NotamsLoader loader;
    NotamsModel model;
    ProxyNotamsModel proxyNotams;

signals:
    void finished(QJsonArray arr);
    void notamsChanged();

public slots:
    void loadNotams(QJsonArray icao);

};

#endif // APPCORE_H
