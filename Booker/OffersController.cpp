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
    element1->addElement("Great place", "", "Poland", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home1.jpg"), 12, 5.0);
    element1->addElement("Nice House", "", "Russia", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home2.jpg"), 34, 2.3);
    element1->addElement("Good for everyday", "", "Great Britain", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home3.jpg"), 23545, 4.5);
    element1->addElement("Best rest", "", "Denmark", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home4.jpg"), 56, 3.2);

    ElementModel* element2 = new ElementModel(this);
    //element->name = "test";
    element2->addElement("Great place", "", "Poland", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home1.jpg"), 12, 5.0);
    element2->addElement("Nice House", "", "Russia", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home2.jpg"), 34, 2.3);
    element2->addElement("Good for everyday", "", "Great Britain", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home3.jpg"), 23545, 4.5);
    element2->addElement("Best rest", "", "Denmark", Utilities::loremIpsum, QUrl("qrc:/res/assets/images/home4.jpg"), 56, 3.2);

    LocationModel* location1 = new LocationModel(this);
    location1->addLocation("Poland", "The land of blooming onions", QUrl("qrc:/res/assets/images/preview_warsaw.jpg"), element1);
    location1->addLocation("USA", "Feel the liberty", QUrl("qrc:/res/assets/images/preview_usa.jpg"), element1);
    location1->addLocation("Russia", "Good beverages", QUrl("qrc:/res/assets/images/preview_moscow.jpg"), element1);
    location1->addLocation("Copenhagen", "Watch out for bikes", QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), element1);
    location1->addLocation("Japan", "Yakuza good good", QUrl("qrc:/res/assets/images/preview_tokyo.jpg"), element1);

    LocationModel* location2 = new LocationModel(this);
    location2->addLocation("Las Vegas", "Gamble it all", QUrl("qrc:/res/assets/images/preview_las_vegas.jpg"), element2);
    location2->addLocation("San Francisco", "Watch your step", QUrl("qrc:/res/assets/images/preview_usa.jpg"), element2);
    location2->addLocation("Russia", "Good beverages", QUrl("qrc:/res/assets/images/preview_moscow.jpg"), element2);
    location2->addLocation("Copenhagen", "Watch out for bikes", QUrl("qrc:/res/assets/images/preview_copenhagen.jpg"), element2);

    addCategory("Major Cities",
                "Major Cities",
                //"Dive into beautiful and meaningful history of the old continent",
                "Explore biggest cities, explore world",
                location1);

    addCategory("USA I guess",
                "Freedom everywhere",
                "Don't get shot",
                location2);
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

