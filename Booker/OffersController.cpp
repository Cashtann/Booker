#include "OffersController.h"
#include "CategoryInfo.h"
#include "ElementModel.h"
#include <QVariant>

OffersController::OffersController(QObject *parent)
    : QAbstractListModel{parent}
{
    ElementModel* element = new ElementModel(this);
    //element->name = "test";
    element->addElement("test", "test", "test", 12, 12);

    addCategory("Name", "Header", "Description", element);
    addCategory("Name", "Header", "Description");
}

int OffersController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_categoryList.length();
}

QVariant OffersController::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < m_categoryList.length())
    {
        CategoryInfo* category = m_categoryList[index.row()];

        switch((CategoryRoles) role){
        case CategoryNameRole:
            return category->name();
        case CategoryHeaderRole:
            return category->header();
        case CategoryDescriptionRole:
            return category->description();
        case CategoryElementsRole:
            return QVariant::fromValue(category->elements());
        default:
            return {};
        }
    }
    return {};
}

QHash<int, QByteArray> OffersController::roleNames() const
{
    QHash<int, QByteArray> result;

    result[CategoryNameRole] = "categoryName";
    result[CategoryHeaderRole] = "categoryHeader";
    result[CategoryDescriptionRole] = "categoryDescription";
    result[CategoryElementsRole] = "categoryElements";

    return result;
}

CategoryInfo* OffersController::addCategory(const QString &categoryName, const QString &categoryHeader, const QString &categoryDescription, ElementModel *categoryElements)
{
    beginInsertRows(QModelIndex(), m_categoryList.length(), m_categoryList.length());

    CategoryInfo* category = new CategoryInfo(this);

    category->setName(categoryName);
    category->setHeader(categoryHeader);
    category->setDescription(categoryDescription);
    category->setElements(categoryElements);

    m_categoryList << category;

    endInsertRows();
    return category;
}

CategoryInfo* OffersController::addCategory(const QString &categoryName, const QString &categoryHeader, const QString &categoryDescription)
{
    beginInsertRows(QModelIndex(), m_categoryList.length(), m_categoryList.length());

    CategoryInfo* category = new CategoryInfo(this);

    category->setName(categoryName);
    category->setHeader(categoryHeader);
    category->setDescription(categoryDescription);

    m_categoryList << category;

    endInsertRows();
    return category;
}

