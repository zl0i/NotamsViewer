#ifndef RECENTMODEL_H
#define RECENTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QModelIndex>
#include <QFile>

class RecentModel : public QAbstractListModel
{
    Q_OBJECT
public:
    RecentModel(QObject *parent = nullptr);
    ~RecentModel();

    enum Roles {
        NameRoles = Qt::UserRole+1,
        ICAOSRoles,
        FilterRoles
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    QJsonArray array;
    QFile file;

signals:

public slots:
    void add(QString name, QString icaos, QJsonObject filter);

};

#endif // RECENTMODEL_H
