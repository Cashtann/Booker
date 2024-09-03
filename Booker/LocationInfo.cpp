#include "LocationInfo.h"


LocationInfo::LocationInfo(QObject *parent)
    : QObject{parent}
{}

QString LocationInfo::locationName() const
{
    return m_locationName;
}

void LocationInfo::setLocationName(const QString &newLocationName)
{
    if (m_locationName == newLocationName)
        return;
    m_locationName = newLocationName;
    emit locationNameChanged();
}

QString LocationInfo::locationDescription() const
{
    return m_locationDescription;
}

void LocationInfo::setLocationDescription(const QString &newLocationDescription)
{
    if (m_locationDescription == newLocationDescription)
        return;
    m_locationDescription = newLocationDescription;
    emit locationDescriptionChanged();
}

QUrl LocationInfo::locationImageSource() const
{
    return m_locationImageSource;
}

void LocationInfo::setLocationImageSource(const QUrl &newLocationImageSource)
{
    if (m_locationImageSource == newLocationImageSource)
        return;
    m_locationImageSource = newLocationImageSource;
    emit locationImageSourceChanged();
}

ElementModel *LocationInfo::locationElements() const
{
    return m_locationElements;
}

void LocationInfo::setLocationElements(ElementModel *newLocationElements)
{
    if (m_locationElements == newLocationElements)
        return;
    m_locationElements = newLocationElements;
    emit locationElementsChanged();
}
