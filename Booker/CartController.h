#ifndef CARTCONTROLLER_H
#define CARTCONTROLLER_H

#include <QObject>
#include <QAbstractListModel>

class ElementInfo;

class CartController : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int idCount READ idCount WRITE setIdCount NOTIFY idCountChanged FINAL)

public:
    enum Roles {
        BookNameRole = Qt::UserRole + 1,
        BookLocationRole,
        BookPriceRole,
        BookPreviewImageSourceRole,
        BookNightsCountRole,
        BookIdRole
    };

    explicit CartController(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    int idCount() const;
    void setIdCount(int newIdCount);

public slots:
    void addElementToCart(const QString& name,
                          const QString& location,
                          const qreal& price,
                          const QUrl& imgSource,
                          const QString& nights);
    void removeElementFromCart(const int& idNumber);

signals:

    void idCountChanged();

private:
    //int idCount = 0;
    QList<ElementInfo*> m_elementList;

    int m_idCount = 0;
};

#endif // CARTCONTROLLER_H
