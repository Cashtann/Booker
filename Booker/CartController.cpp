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
        case BookIdRole:
            return element->id();
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
    result[BookIdRole] = "bookId";


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
    element->setId(m_idCount);

    m_elementList << element;

    endInsertRows();


    qDebug() << "Added element with id:" << m_idCount;
    setIdCount(m_idCount + 1);
}

void CartController::removeElementFromCart(const int &idNumber)
{
    for (int i = 0; i < m_elementList.size(); i++)
    {
        if (m_elementList[i]->id() == idNumber)
        {
            beginRemoveRows(QModelIndex(), i, i);

            m_elementList[i]->deleteLater();
            m_elementList.removeAt(i);

            endRemoveRows();
            return;
        }
    }
    qDebug() << "Failed to delete element with id:" << idNumber;
}

int CartController::idCount() const
{
    return m_idCount;
}

void CartController::setIdCount(int newIdCount)
{
    if (m_idCount == newIdCount)
        return;
    m_idCount = newIdCount;
    emit idCountChanged();
}
