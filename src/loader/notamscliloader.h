#ifndef NOTAMSCLILOADER_H
#define NOTAMSCLILOADER_H

#include <QObject>
#include <QtGlobal>
#include <QProcess>


#include "abstractnotamsloader.h"


class NotamsCLILoader : public AbstractNotamsLoader
{
    Q_OBJECT
public:
    explicit NotamsCLILoader(QObject *parent = nullptr);

private:
    QProcess notams;

signals:
    void newOutputData(QByteArray line);
    void newErrorData(QByteArray line);

private slots:
    void slotReadChanel();
    void loaded(int, QProcess::ExitStatus status) ;

public slots:
    void loadNotams(QJsonArray icao) override;
};

#endif // NOTAMSCLILOADER_H
