#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QGuiApplication>
#include <QClipboard>

#include "./loader/abstractnotamsloader.h"
#include "notamsmodel.h"
#include "proxynotamsmodel.h"
#include "recentmodel.h"

class AppCore : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ProxyNotamsModel* notams READ notams NOTIFY notamsChanged)
    Q_PROPERTY(RecentModel* recents READ recents NOTIFY recentsChanged)
public:
    explicit AppCore(AbstractNotamsLoader *loader, QObject *parent = nullptr);

    ProxyNotamsModel* notams() { return &proxyNotams; }
    RecentModel* recents() { return &_recents; }

private:
    AbstractNotamsLoader *loader;
    NotamsModel model;
    ProxyNotamsModel proxyNotams;
    RecentModel _recents;

signals:
    void finished(QJsonArray arr);
    void notamsChanged();
    void recentsChanged();

public slots:
    void loadNotams(QJsonArray icao);
    void saveToFile(QString file, bool isFiltered);
    void copyToClipboard(QString text);

};

#endif // APPCORE_H
