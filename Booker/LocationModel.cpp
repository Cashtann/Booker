#include "LocationModel.h"
#include "LocationInfo.h"

LocationModel::LocationModel(QObject *parent)
    : QAbstractListModel{parent}
{}

int LocationModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_locationList.length();
}

QVariant LocationModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < m_locationList.length())
    {
        LocationInfo* location = m_locationList[index.row()];

        switch((LocationRoles) role){
        case LocationNameRole:
            return location->locationName();
        case LocationDescriptionRole:
            return location->locationDescription();
        case LocationImageSourceRole:
            return location->locationImageSource();
        case LocationElementsRole:
            return QVariant::fromValue(location->locationElements());
        default:
            return {};
        }
    }
    return {};
}

QHash<int, QByteArray> LocationModel::roleNames() const
{
    QHash<int, QByteArray> result;

    result[LocationNameRole] = "locationName";
    result[LocationDescriptionRole] = "locationDescription";
    result[LocationImageSourceRole] = "locationImageSource";
    result[LocationElementsRole] = "locationElements";

    return result;
}

LocationInfo *LocationModel::addLocation(const QString &locationName, const QString &locationDescription, const QUrl &locationImageSource, ElementModel *locationElements)
{
    beginInsertRows(QModelIndex(), m_locationList.length(), m_locationList.length());

    LocationInfo* location = new LocationInfo(this);

    location->setLocationName(locationName);
    location->setLocationDescription(locationDescription);
    location->setLocationImageSource(locationImageSource);
    location->setLocationElements(locationElements);

    m_locationList << location;

    endInsertRows();
    return location;
}

