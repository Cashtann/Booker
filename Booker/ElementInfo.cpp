#include "ElementInfo.h"

ElementInfo::ElementInfo(QObject *parent)
    : QObject{parent}
{
    updateAverageRating(); // to update averageRating
}

QString ElementInfo::name() const
{
    return m_name;
}

void ElementInfo::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

QString ElementInfo::header() const
{
    return m_header;
}

void ElementInfo::setHeader(const QString &newHeader)
{
    if (m_header == newHeader)
        return;
    m_header = newHeader;
    emit headerChanged();
}

QString ElementInfo::location() const
{
    return m_location;
}

void ElementInfo::setLocation(const QString &newLocation)
{
    if (m_location == newLocation)
        return;
    m_location = newLocation;
    emit locationChanged();
}

qreal ElementInfo::price() const
{
    return m_price;
}

void ElementInfo::setPrice(qreal newPrice)
{
    if (m_price == newPrice)
        return;
    m_price = newPrice;
    emit priceChanged();
}

qreal ElementInfo::averageRating() const
{
    return m_averageRating;
}

void ElementInfo::setAverageRating(qreal newAverageRating)
{
    if (qFuzzyCompare(m_averageRating, newAverageRating))
        return;
    m_averageRating = newAverageRating;
    emit averageRatingChanged();
}

void ElementInfo::updateAverageRating()
{
    int count = 0;
    int sum = 0;
    for (const auto& rating : m_ratings)
    {
        count++;
        sum += rating;
    }
    if (count != 0)
        setAverageRating(sum / count);
    else
        setAverageRating(0);
}

QList<QUrl> ElementInfo::imageSources() const
{
    return m_imageSources;
}

void ElementInfo::setImageSources(const QList<QUrl> &newImageSources)
{
    if (m_imageSources == newImageSources)
        return;
    m_imageSources = newImageSources;
    emit imageSourcesChanged();
}

QList<int> ElementInfo::ratings() const
{
    return m_ratings;
}

void ElementInfo::setRatings(const QList<int> &newRatings)
{
    if (m_ratings == newRatings)
        return;
    m_ratings = newRatings;
    updateAverageRating(); // to update averageRating
    emit ratingsChanged();
}

QUrl ElementInfo::previewImageSource() const
{
    return m_previewImageSource;
}

void ElementInfo::setPreviewImageSource(const QUrl &newPreviewImageSource)
{
    if (m_previewImageSource == newPreviewImageSource)
        return;
    m_previewImageSource = newPreviewImageSource;
    emit previewImageSourceChanged();
}

QString ElementInfo::description() const
{
    return m_description;
}

void ElementInfo::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}
