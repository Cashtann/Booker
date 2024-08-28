#include "CategoryInfo.h"
#include "OfferInfo.h"
#include <vector>
#include <QUrl>

CategoryInfo::CategoryInfo(QObject *parent)
    : QObject{parent}
{

}

QString CategoryInfo::categoryName() const
{
    return m_categoryName;
}

void CategoryInfo::setCategoryName(const QString &newCategoryName)
{
    if (m_categoryName == newCategoryName)
        return;
    m_categoryName = newCategoryName;
    emit categoryNameChanged();
}

QList<OfferInfo *> CategoryInfo::elements() const
{
    return m_elements;
}

void CategoryInfo::setElements(const QList<OfferInfo *> &newElements)
{
    if (m_elements == newElements)
        return;
    m_elements = newElements;
    emit elementsChanged();
}

QString CategoryInfo::categoryHeader() const
{
    return m_categoryHeader;
}

void CategoryInfo::setCategoryHeader(const QString &newCategoryHeader)
{
    if (m_categoryHeader == newCategoryHeader)
        return;
    m_categoryHeader = newCategoryHeader;
    emit categoryHeaderChanged();
}

QString CategoryInfo::categoryDescription() const
{
    return m_categoryDescription;
}

void CategoryInfo::setcategoryDescription(const QString &newCategoryDescription)
{
    if (m_categoryDescription == newCategoryDescription)
        return;
    m_categoryDescription = newCategoryDescription;
    emit categoryDescriptionChanged();
}
