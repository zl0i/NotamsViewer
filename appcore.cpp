#include "appcore.h"

AppCore::AppCore(QObject *parent)
    : QObject{parent}
{
    connect(&loader, &NotamsLoader::finished, this, &AppCore::finished);
    connect(&loader, &NotamsLoader::finished, [=](QJsonArray notams) {
        qDebug() << notams.count();
        model.parse(notams);
        //emit notamsChanged();
    });
}


void AppCore::loadNotams(QJsonArray icao)
{
    loader.loadNotams(icao);

}
