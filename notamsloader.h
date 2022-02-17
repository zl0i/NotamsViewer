#ifndef NOTAMSLOADER_H
#define NOTAMSLOADER_H

#include <QObject>
#include <QtGlobal>
#include <QProcess>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>


class NotamsLoader : public QObject
{
    Q_OBJECT
public:
    explicit NotamsLoader(QObject *parent = nullptr);private:
    QProcess notams;

signals:
    void newOutputData(QByteArray line);
    void newErrorData(QByteArray line);
    void finished(QJsonArray notams);

private slots:
    void slotReadChanel();
    void loaded(int, QProcess::ExitStatus status);

public slots:
    void loadNotams(QJsonArray icao);
};

#endif // NOTAMSLOADER_H
