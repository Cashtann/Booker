#ifndef LOCATIONMODEL_H
#define LOCATIONMODEL_H

#include "ElementModel.h"

#include <QObject>
#include <QAbstractListModel>

class LocationInfo;

class LocationModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum LocationRoles {
        LocationNameRole = Qt::UserRole + 1,
        LocationDescriptionRole,
        LocationImageSourceRole,
        LocationElementsRole
    };

    explicit LocationModel(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:

    LocationInfo* addLocation(const QString& locationName,
                              const QString& locationDescription,
                              const QUrl& locationImageSource,
                              ElementModel* locationElements);

signals:

private:
    QList<LocationInfo*> m_locationList;

};

#endif // LOCATIONMODEL_H
