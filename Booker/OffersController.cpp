#include "OffersController.h"
#include "CategoryInfo.h"
#include "ElementModel.h"
#include <QVariant>
#include <QUrl>

OffersController::OffersController(QObject *parent)
    : QAbstractListModel{parent}
{
    ElementModel* element1 = new ElementModel(this);
    //element->name = "test";
    element1->addElement("Cracow", "Meet pigeons", "Polan", QUrl("qrc:/res/assets/images/preview_cracow.jpg"), 12, 12);
    element1->addElement("Moscow", "Taste the strongest beverages", "Russia", QUrl("qrc:/res/assets/images/preview_moscow.jpg"), 34, 34);
    element1->addElement("London", "Better learn to run", "Great Britain", QUrl("qrc:/res/assets/images/preview_london.jpg"), 56, 56);
    element1->addElement("Copenhagen", "Not enough bikes?", "Denmark", QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), 56, 56);
    element1->addElement("Copenhagen", "Not enough bikes?", "Denmark", QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), 56, 56);

    addCategory("Europe",
                "Explore Europe",
                "Dive into beautiful and meaningful history of the old continent",
                element1);
    ElementModel* element2 = new ElementModel(this);
    element2->addElement("Cracow", "Meet pigeons", "Polan", QUrl("qrc:/res/assets/images/preview_cracow.jpg"), 12, 12);
    element1->addElement("Copenhagen", "Not enough bikes?", "Denmark", QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), 56, 56);
    addCategory("Name", "Header", "Description", element2);
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

