#ifndef CATEGORYINFO_H
#define CATEGORYINFO_H

#include <QObject>
#include <qqml.h>
//#include "OfferInfo.h"

class OfferInfo;

class CategoryInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString categoryName READ categoryName WRITE setCategoryName NOTIFY categoryNameChanged FINAL)
    Q_PROPERTY(QString categoryHeader READ categoryHeader WRITE setCategoryHeader NOTIFY categoryHeaderChanged FINAL)
    Q_PROPERTY(QString categoryDescription READ categoryDescription WRITE setcategoryDescription NOTIFY categoryDescriptionChanged FINAL)

    Q_PROPERTY(QList<OfferInfo*> elements READ elements WRITE setElements NOTIFY elementsChanged FINAL)

public:
    explicit CategoryInfo(QObject *parent = nullptr);

    QString categoryName() const;
    void setCategoryName(const QString &newCategoryName);

    QList<OfferInfo *> elements() const;
    void setElements(const QList<OfferInfo *> &newElements);

    QString categoryHeader() const;
    void setCategoryHeader(const QString &newCategoryHeader);

    QString categoryDescription() const;
    void setcategoryDescription(const QString &newCategoryDescription);

signals:
    void categoryNameChanged();
    void elementsChanged();

    void categoryHeaderChanged();

    void categoryDescriptionChanged();

private:
    QString m_categoryName;
    QList<OfferInfo *> m_elements;
    QString m_categoryHeader;
    QString m_categoryDescription;
};

#endif // CATEGORYINFO_H
