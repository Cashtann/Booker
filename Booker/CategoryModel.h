#ifndef CATEGORYMODEL_H
#define CATEGORYMODEL_H

#include <QObject>

#include <QVariant>
#include <qqml.h>

class ElementModel;

class CategoryModel : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit CategoryModel(QObject *parent = nullptr);

    QString name;
    QString header;
    QString description;
    ElementModel* elements;

};

#endif // CATEGORYMODEL_H
