#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

#include "notamsloader.h"
#include "notamsmodel.h"

class AppCore : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NotamsModel* notams READ notams NOTIFY notamsChanged)
public:
    explicit AppCore(QObject *parent = nullptr);

    NotamsModel* notams() { return &model; }

private:
    NotamsLoader loader;
    NotamsModel model;

signals:
    void finished(QJsonArray arr);
    void notamsChanged();

public slots:
    void loadNotams(QJsonArray icao);

};

#endif // APPCORE_H
