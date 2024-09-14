#include "CartController.h"
#include "ElementInfo.h"
#include <QDebug>

CartController::CartController(QObject *parent)
    : QAbstractListModel{parent}
{

}

int CartController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_elementList.length();
}

QVariant CartController::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < m_elementList.length())
    {
        ElementInfo* element = m_elementList[index.row()];

        switch((Roles) role){
        case BookNameRole:
            return element->name();
        case BookLocationRole:
            return element->location();
        case BookPriceRole:
            return element->price();
        case BookPreviewImageSourceRole:
            return element->previewImageSource();
        case BookNightsCountRole:
            return element->nightsCount();
        default:
            return {};
        }
    }
    return {};
}

QHash<int, QByteArray> CartController::roleNames() const
{
    QHash<int, QByteArray> result;

    result[BookNameRole] = "bookName";
    result[BookLocationRole] = "bookLocation";
    result[BookPriceRole] = "bookPrice";
    result[BookPreviewImageSourceRole] = "bookPreviewImageSource";
    result[BookNightsCountRole] = "bookNightsCount";


    return result;
}

void CartController::addElementToCart(const QString &name, const QString &location, const qreal &price, const QUrl &imgSource, const QString &nights)
{
    beginInsertRows(QModelIndex(), m_elementList.length(), m_elementList.length());

    ElementInfo* element = new ElementInfo(this);

    element->setName(name);
    element->setLocation(location);
    element->setPreviewImageSource(imgSource);
    element->setPrice(price);
    element->setNightsCount(nights.toInt());

    m_elementList << element;

    endInsertRows();

    qDebug() << "Book added!";
}

void CartController::addElementToCart(ElementInfo* newElement)
{
    beginInsertRows(QModelIndex(), m_elementList.length(), m_elementList.length());

    ElementInfo* element = new ElementInfo(this);
    element->setName(newElement->name());

    m_elementList << element;

    qDebug() << "Book added!";
    endInsertRows();
}





void CartController::removeElementFromCart(const ElementInfo &element)
{

}
