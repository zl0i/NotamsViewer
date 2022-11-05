#ifndef NOTAMSHTTPLOADER_H
#define NOTAMSHTTPLOADER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrlQuery>

#include "abstractnotamsloader.h"

class NotamsHttpLoader : public AbstractNotamsLoader
{
    Q_OBJECT
public:
    explicit NotamsHttpLoader(QObject *parent = nullptr);

private:
    QNetworkAccessManager manager;

public slots:
    void loadNotams(QJsonArray icao) override;
};

#endif // NOTAMSHTTPLOADER_H
