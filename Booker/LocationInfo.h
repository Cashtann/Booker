#ifndef LOCATIONINFO_H
#define LOCATIONINFO_H

#include <QObject>
#include "ElementModel.h"
#include <QUrl>

class LocationInfo : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString locationName READ locationName WRITE setLocationName NOTIFY locationNameChanged FINAL)
    Q_PROPERTY(QString locationDescription READ locationDescription WRITE setLocationDescription NOTIFY locationDescriptionChanged FINAL)
    Q_PROPERTY(QUrl locationImageSource READ locationImageSource WRITE setLocationImageSource NOTIFY locationImageSourceChanged FINAL)
    Q_PROPERTY(ElementModel* locationElements READ locationElements WRITE setLocationElements NOTIFY locationElementsChanged FINAL)
public:
    explicit LocationInfo(QObject *parent = nullptr);

    QString locationName() const;
    void setLocationName(const QString &newLocationName);

    QString locationDescription() const;
    void setLocationDescription(const QString &newLocationDescription);

    QUrl locationImageSource() const;
    void setLocationImageSource(const QUrl &newLocationImageSource);

    ElementModel *locationElements() const;
    void setLocationElements(ElementModel *newLocationElements);

signals:
    void locationNameChanged();
    void locationDescriptionChanged();

    void locationImageSourceChanged();

    void locationElementsChanged();

private:
    QString m_locationName;
    QString m_locationDescription;
    QUrl m_locationImageSource;
    ElementModel *m_locationElements = nullptr;
};

#endif // LOCATIONINFO_H
