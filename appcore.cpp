#include "appcore.h"

AppCore::AppCore(QObject *parent)
    : QObject{parent}, _recents(this)
{
    proxyNotams.setSourceModel(&model);
    connect(&loader, &NotamsLoader::finished, this, &AppCore::finished);
    connect(&loader, &NotamsLoader::finished, [=](QJsonArray notams) {
        model.parse(notams);
    });
}


void AppCore::loadNotams(QJsonArray icao)
{
    loader.loadNotams(icao);

}
