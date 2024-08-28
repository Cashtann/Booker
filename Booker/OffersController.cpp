#include "OffersController.h"
#include "OfferInfo.h"

OffersController::OffersController(QObject *parent)
    : QAbstractListModel{parent}
{
    addCategory("TestName", "Header? Nah", "Lorem ipsum i do przodu");
    addCategory("dupa123", "another Header? Nah", "bajlando");
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
        CategoryInfo* categoryInfo = m_categoryList[index.row()];

        switch((CategoryRoles) role){
        case CategoryNameRole:
            return categoryInfo->categoryName();
        case CategoryHeaderRole:
            return categoryInfo->categoryHeader();
        case CategoryDescriptionRole:
            return categoryInfo->categoryDescription();
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

    return result;
}

void OffersController::addCategory(const QString &categoryName, const QString &categoryHeader, const QString &categoryDescription)
{
    beginInsertRows(QModelIndex(), m_categoryList.length(), m_categoryList.length());
    CategoryInfo* categoryInfo = new CategoryInfo(this);

    categoryInfo->setCategoryName(categoryName);
    categoryInfo->setCategoryHeader(categoryHeader);
    categoryInfo->setcategoryDescription(categoryDescription);
    //categoryInfo->setElements({});

    OfferInfo* test1 = new OfferInfo(this);
    test1->setHeader("test");
    test1->setIndex(2137);
    test1->setImages({QUrl("qrc:/res/assets/images/preview_cracow.jpg")});
    test1->setDescription("test lorem ipsum");
    test1->setRatings({0, 1, 2, 3});
    test1->setAvgRating(4.3);

    categoryInfo->setElements({test1});


    m_categoryList << categoryInfo;

    endInsertRows();
}
