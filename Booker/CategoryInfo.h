#ifndef CATEGORYINFO_H
#define CATEGORYINFO_H

#include <QObject>

#include <QVariant>
#include <qqml.h>
#include "LocationModel.h"

class ElementModel;

class CategoryInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
    Q_PROPERTY(QString header READ header WRITE setHeader NOTIFY headerChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
    Q_PROPERTY(LocationModel* locations READ locations WRITE setLocations NOTIFY locationsChanged FINAL)

public:
    explicit CategoryInfo(QObject *parent = nullptr);

    QString name() const;
    void setName(const QString &newName);
    QString header() const;
    void setHeader(const QString &newHeader);

    QString description() const;
    void setDescription(const QString &newDescription);


    LocationModel *locations() const;
    void setLocations(LocationModel *newLocations);

signals:
    void nameChanged();
    void headerChanged();

    void descriptionChanged();

    void locationsChanged();

private:
    QString m_name;
    QString m_header;
    QString m_description;
    LocationModel *m_locations = nullptr;
};

#endif // CATEGORYINFO_H
