#include "notamscliloader.h"

NotamsCLILoader::NotamsCLILoader(QObject *parent)
    : AbstractNotamsLoader{parent}
{
    notams.setProcessChannelMode(QProcess::MergedChannels);
    //connect(&notams, &QProcess::readyRead, this, &NotamsLoader::slotReadChanel);
    connect(&notams, static_cast<void (QProcess::*)(int, QProcess::ExitStatus)>(&QProcess::finished), this, &NotamsCLILoader::loaded);
}

void NotamsCLILoader::slotReadChanel()
{
    notams.setReadChannel(QProcess::StandardError);
    QByteArray error = notams.readAll();
    if(!error.isEmpty())
        emit newErrorData(error);

    notams.setReadChannel(QProcess::StandardOutput);
    QByteArray output = notams.readAll();
    if(!output.isEmpty())
        emit newOutputData(output);
}

void NotamsCLILoader::loaded(int code, QProcess::ExitStatus)
{
    if(code != 0)
       return emit finished(QJsonArray {});

    notams.setReadChannel(QProcess::StandardOutput);
    QByteArray output = notams.readAll();
    QJsonDocument doc = QJsonDocument::fromJson(output);
    emit finished(doc.array());
}

void NotamsCLILoader::loadNotams(QJsonArray icao)
{
    QStringList icaos;
    for(int i = 0; i < icao.count(); i++) {
        icaos.append(icao.at(i).toString());
    }
    QStringList arguments;
    arguments << "get" << "-i" << icaos.join(" ");
#ifdef RELEASE
    notams.start("./notams.exe", arguments);
#else
    notams.start("../notams.exe", arguments);
#endif
}
