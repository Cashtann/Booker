#ifndef ELEMENTINFO_H
#define ELEMENTINFO_H

#include <QObject>
#include <qqml.h>

class ElementInfo : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
    Q_PROPERTY(QString header READ header WRITE setHeader NOTIFY headerChanged FINAL)
    Q_PROPERTY(QString location READ location WRITE setLocation NOTIFY locationChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
    Q_PROPERTY(qreal price READ price WRITE setPrice NOTIFY priceChanged FINAL)
    Q_PROPERTY(qreal averageRating READ averageRating WRITE setAverageRating NOTIFY averageRatingChanged FINAL)
    Q_PROPERTY(QUrl previewImageSource READ previewImageSource WRITE setPreviewImageSource NOTIFY previewImageSourceChanged FINAL)
    Q_PROPERTY(QList<int> ratings READ ratings WRITE setRatings NOTIFY ratingsChanged FINAL)
    Q_PROPERTY(QList<QUrl> imageSources READ imageSources WRITE setImageSources NOTIFY imageSourcesChanged FINAL)


public:
    explicit ElementInfo(QObject *parent = nullptr);

    QString name() const;
    void setName(const QString &newName);

    QString header() const;
    void setHeader(const QString &newHeader);

    QString location() const;
    void setLocation(const QString &newLocation);

    qreal price() const;
    void setPrice(qreal newPrice);

    qreal averageRating() const;
    void setAverageRating(qreal newAverageRating);
    void updateAverageRating();

    QList<QUrl> imageSources() const;
    void setImageSources(const QList<QUrl> &newImageSources);

    QList<int> ratings() const;
    void setRatings(const QList<int> &newRatings);

    QUrl previewImageSource() const;
    void setPreviewImageSource(const QUrl &newPreviewImageSource);

    QString description() const;
    void setDescription(const QString &newDescription);

signals:
    void nameChanged();
    void headerChanged();

    void locationChanged();

    void priceChanged();

    void averageRatingChanged();

    void imageSourcesChanged();

    void ratingsChanged();

    void previewImageSourceChanged();

    void descriptionChanged();

private:
    QString m_name;
    QString m_header;
    QString m_location;
    qreal m_price;
    qreal m_averageRating;
    QList<QUrl> m_imageSources;
    QList<int> m_ratings;
    QUrl m_previewImageSource;
    QString m_description;
};

#endif // ELEMENTINFO_H
