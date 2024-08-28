#include "OfferInfo.h"

OfferInfo::OfferInfo(QObject *parent)
    : QObject{parent}
{}

QString OfferInfo::header() const
{
    return m_header;
}

void OfferInfo::setHeader(const QString &newHeader)
{
    if (m_header == newHeader)
        return;
    m_header = newHeader;
    emit headerChanged();
}

int OfferInfo::index() const
{
    return m_index;
}

void OfferInfo::setIndex(int newIndex)
{
    if (m_index == newIndex)
        return;
    m_index = newIndex;
    emit indexChanged();
}

QList<QUrl> OfferInfo::images() const
{
    return m_images;
}

void OfferInfo::setImages(const QList<QUrl> &newImages)
{
    if (m_images == newImages)
        return;
    m_images = newImages;
    emit imagesChanged();
}

QString OfferInfo::description() const
{
    return m_description;
}

void OfferInfo::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}

QList<int> OfferInfo::ratings() const
{
    return m_ratings;
}

void OfferInfo::setRatings(const QList<int> &newRatings)
{
    if (m_ratings == newRatings)
        return;
    m_ratings = newRatings;
    emit ratingsChanged();
}

float OfferInfo::avgRating() const
{
    return m_avgRating;
}

void OfferInfo::setAvgRating(float newAvgRating)
{
    if (qFuzzyCompare(m_avgRating, newAvgRating))
        return;
    m_avgRating = newAvgRating;
    emit avgRatingChanged();
}
