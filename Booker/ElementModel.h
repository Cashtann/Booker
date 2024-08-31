#ifndef ELEMENTMODEL_H
#define ELEMENTMODEL_H

#include <QObject>
#include <QAbstractListModel>


class ElementInfo;

class ElementModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ElementRoles {
        ElementNameRole = Qt::UserRole + 1,
        ElementHeaderRole,
        ElementLocationRole,
        ElementPriceRole,
        ElementAverageRatingRole,
        ElementPreviewImageSourceRole
        // todo: img sources in another qabstractlistmodel so there can be multiple (weird, i know)
        // something similar with ratings
    };

    explicit ElementModel(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:

    void addElement(const QString& elementName,
                    const QString& elementHeader,
                    const QString& elementLocation,
                    const QUrl& elementPreviewImageSource,
                    const qreal& elementPrice,
                    const qreal& elementAverageRating);

private:
    QList<ElementInfo*> m_elementList;
};

#endif // ELEMENTMODEL_H
