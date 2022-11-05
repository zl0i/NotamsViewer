#ifndef ABSTRACTNOTAMSLOADER_H
#define ABSTRACTNOTAMSLOADER_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class AbstractNotamsLoader : public QObject
{
    Q_OBJECT
public:
    explicit AbstractNotamsLoader(QObject *parent = nullptr);

signals:
    void finished(QJsonArray notams);
public slots:
    virtual void loadNotams(QJsonArray icao) = 0;

};

#endif // ABSTRACTNOTAMSLOADER_H
