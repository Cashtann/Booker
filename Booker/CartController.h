#ifndef CARTCONTROLLER_H
#define CARTCONTROLLER_H

#include <QObject>
#include <QAbstractListModel>

class ElementInfo;

class CartController : public QAbstractListModel
{
    Q_OBJECT


public:
    enum Roles {
        BookNameRole = Qt::UserRole + 1,
        BookLocationRole,
        BookPriceRole,
        BookPreviewImageSourceRole,
        BookNightsCountRole
    };

    explicit CartController(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void addElementToCart(const QString& name,
                          const QString& location,
                          const qreal& price,
                          const QUrl& imgSource,
                          const QString& nights);
    void addElementToCart(ElementInfo* newElement);
    void removeElementFromCart(const ElementInfo& element);

signals:

private:
    QList<ElementInfo*> m_elementList;

};

#endif // CARTCONTROLLER_H
