#ifndef OFFERINFO_H
#define OFFERINFO_H

#include <QObject>
#include <qqml.h>
#include <QUrl>


class OfferInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString header READ header WRITE setHeader NOTIFY headerChanged FINAL)
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged FINAL)
    Q_PROPERTY(QList<QUrl> images READ images WRITE setImages NOTIFY imagesChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
    Q_PROPERTY(QList<int> ratings READ ratings WRITE setRatings NOTIFY ratingsChanged FINAL)
    Q_PROPERTY(float avgRating READ avgRating WRITE setAvgRating NOTIFY avgRatingChanged FINAL)
public:
    explicit OfferInfo(QObject *parent = nullptr);

    QString header() const;
    void setHeader(const QString &newHeader);

    int index() const;
    void setIndex(int newIndex);

    QList<QUrl> images() const;
    void setImages(const QList<QUrl> &newImages);

    QString description() const;
    void setDescription(const QString &newDescription);

    QList<int> ratings() const;
    void setRatings(const QList<int> &newRatings);

    float avgRating() const;
    void setAvgRating(float newAvgRating);

signals:
    void headerChanged();
    void indexChanged();

    void imagesChanged();

    void descriptionChanged();

    void ratingsChanged();

    void avgRatingChanged();

private:
    QString m_header;
    int m_index;
    QList<QUrl> m_images;
    QString m_description;
    QList<int> m_ratings;
    float m_avgRating;
};

#endif // OFFERINFO_H
