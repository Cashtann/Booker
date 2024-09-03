#include "OffersController.h"
#include "CategoryInfo.h"
#include "LocationModel.h"
#include "ElementModel.h"
#include <QVariant>
#include <QUrl>
#include "Utilities.h"

OffersController::OffersController(QObject *parent)
    : QAbstractListModel{parent}
{
    ElementModel* element1 = new ElementModel(this);
    //element->name = "test";
    element1->addElement("Cracow", "Meet pigeons", "Poland", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/preview_cracow.jpg"), 12, 12);
    element1->addElement("Moscow", "Taste the strongest beverages", "Russia", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/preview_moscow.jpg"), 34, 34);
    element1->addElement("London", "Better learn to run", "Great Britain", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/preview_london.jpg"), 56, 56);
    element1->addElement("Copenhagen", "Not enough bikes?", "Denmark", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), 56, 56);

    LocationModel* location1 = new LocationModel(this);
    location1->addLocation("Poland", "The land of blooming onions", QUrl("qrc:/res/assets/images/preview_warsaw.jpg"), element1);

    addCategory("Europe",
                "Explore Europe",
                "Dive into beautiful and meaningful history of the old continent",
                location1);
    ElementModel* element2 = new ElementModel(this);
    element2->addElement("Cracow", "Meet pigeons", "Poland", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/preview_cracow.jpg"), 12, 12);
    element2->addElement("Copenhagen", "Not enough bikes?", "Denmark", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), 56, 56);
    addCategory("Name", "Header", "Description", location1);
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
        case CategoryLocationsRole:
            return QVariant::fromValue(category->locations());
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
    result[CategoryLocationsRole] = "categoryLocations";

    return result;
}

CategoryInfo* OffersController::addCategory(const QString &categoryName, const QString &categoryHeader, const QString &categoryDescription, LocationModel *categoryLocations)
{
    beginInsertRows(QModelIndex(), m_categoryList.length(), m_categoryList.length());

    CategoryInfo* category = new CategoryInfo(this);

    category->setName(categoryName);
    category->setHeader(categoryHeader);
    category->setDescription(categoryDescription);
    category->setLocations(categoryLocations);

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

