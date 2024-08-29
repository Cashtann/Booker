#include "ElementModel.h"
#include "ElementInfo.h"

ElementModel::ElementModel(QObject *parent)
    : QAbstractListModel{parent}
{
    addElement("testName", "testHeader", "testLocation", 420.69, 6.9);
}

int ElementModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_elementList.length();
}

QVariant ElementModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < m_elementList.length())
    {
        ElementInfo* element = m_elementList[index.row()];

        switch((ElementRoles) role){
        case ElementNameRole:
            return element->name();
        case ElementHeaderRole:
            return element->header();
        case ElementLocationRole:
            return element->location();
        case ElementPriceRole:
            return element->price();
        case ElementAverageRatingRole:
            return element->averageRating();
        default:
            return {};
        }
    }
    return {};
}

QHash<int, QByteArray> ElementModel::roleNames() const
{
    QHash<int, QByteArray> result;

    result[ElementNameRole] = "elementName";
    result[ElementHeaderRole] = "elementHeader";
    result[ElementLocationRole] = "elementLocation";
    result[ElementPriceRole] = "elementPrice";
    result[ElementAverageRatingRole] = "elementAverageRating";

    return result;
}

void ElementModel::addElement(const QString &elementName, const QString &elementHeader, const QString &elementLocation, const qreal &elementPrice, const qreal &elementAverageRating)
{
    beginInsertRows(QModelIndex(), m_elementList.length(), m_elementList.length());

    ElementInfo* element = new ElementInfo(this);

    element->setName(elementName);
    element->setHeader(elementHeader);
    element->setLocation(elementLocation);
    element->setPrice(elementPrice);
    element->setAverageRating(elementAverageRating);

    m_elementList << element;

    endInsertRows();
}
