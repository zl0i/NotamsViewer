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

void AppCore::saveToFile(QString path, bool isFiltered)
{
    QFile file(path);
    if(!file.open(QIODevice::WriteOnly))
        return;

    file.resize(0);

    const QByteArray doubleLine = QString("\n\n").toLocal8Bit();
    if(isFiltered) {
        for(int i = 0; i < proxyNotams.rowCount(); i++) {
            QByteArray text = proxyNotams.data(proxyNotams.index(i,0), NotamsModel::TextRole).toByteArray();
            for(int j = 80; j < text.count(); j += 80) {
                text.insert(j, '\n');
            }
            file.write(text);
            file.write(doubleLine);
        }
    } else {
        for(int i = 0; i < model.rowCount(); i++) {
            QByteArray text = model.data(model.index(i,0), NotamsModel::TextRole).toByteArray();
            for(int j = 80; j < text.count(); j += 80) {
                text.insert(j, '\n');
            }
            file.write(text);
            file.write(doubleLine);
        }
    }
    file.close();
}
