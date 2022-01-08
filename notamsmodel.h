#ifndef NOTAMSMODEL_H
#define NOTAMSMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QModelIndex>

class NotamsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit NotamsModel(QObject *parent = nullptr);

    enum Roles {
        StartDateRole,
        EndDateRole,
        CreateDateRole,
        TextRole,
        FLStartRole,
        FLEndRole,
        PointsRole,
        DurationSecRole,
        DurationStrRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    QJsonArray array;

signals:

public slots:
    void parse(QJsonArray array);

};

#endif // NOTAMSMODEL_H
