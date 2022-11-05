#include "notamshttploader.h"

NotamsHttpLoader::NotamsHttpLoader(QObject *parent)
    : AbstractNotamsLoader{parent}
{

}

void NotamsHttpLoader::loadNotams(QJsonArray icao)
{

    QString icaoJoin = icao.at(0).toString();
    for (int i = 1; i < icao.size(); i++) {
        icaoJoin.append(",");
        icaoJoin.append(icao.at(i).toString());
    }
    QUrlQuery query;
    query.addQueryItem("icao", icaoJoin);
    QUrl url("https://notams.bot.zloi.space/parse/notams");
    url.setQuery(query);
    QNetworkRequest request(url);
    QNetworkReply *reply = manager.get(request);
    connect(reply, &QNetworkReply::finished, [=] {
        if(reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            emit finished(doc.array());
        }
    });
}
