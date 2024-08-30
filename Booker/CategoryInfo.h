#ifndef CATEGORYINFO_H
#define CATEGORYINFO_H

#include <QObject>

#include <QVariant>
#include <qqml.h>
#include "ElementModel.h"

class ElementModel;

class CategoryInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
    Q_PROPERTY(QString header READ header WRITE setHeader NOTIFY headerChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
    Q_PROPERTY(ElementModel* elements READ elements WRITE setElements NOTIFY elementsChanged FINAL)

public:
    explicit CategoryInfo(QObject *parent = nullptr);

    // QString name;
    // QString header;
    // QString description;
    // ElementModel* elements;

    QString name() const;
    void setName(const QString &newName);
    QString header() const;
    void setHeader(const QString &newHeader);

    QString description() const;
    void setDescription(const QString &newDescription);

    ElementModel *elements() const;
    void setElements(ElementModel *newElements);

signals:
    void nameChanged();
    void headerChanged();

    void descriptionChanged();

    void elementsChanged();

private:
    QString m_name;
    QString m_header;
    QString m_description;
    ElementModel *m_elements = new ElementModel(this);
};

#endif // CATEGORYINFO_H
