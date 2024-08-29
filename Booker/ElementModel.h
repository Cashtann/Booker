#ifndef ELEMENTMODEL_H
#define ELEMENTMODEL_H

#include <QObject>

class ElementModel : public QObject
{
    Q_OBJECT

public:
    explicit ElementModel(QObject *parent = nullptr);

signals:
};

#endif // ELEMENTMODEL_H
