#ifndef OFFERSCONTROLLER_H
#define OFFERSCONTROLLER_H

#include <QObject>
#include <QAbstractListModel>

class CategoryModel;

class ElementModel;

class OffersController : public QAbstractListModel
{
    Q_OBJECT
public:
    enum CategoryRoles {
        CategoryNameRole = Qt::UserRole + 1,
        CategoryHeaderRole,
        CategoryDescriptionRole,
        CategoryElementsRole
    };

    explicit OffersController(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;


public slots:

    void addCategory(const QString& categoryName,
                     const QString& categoryHeader,
                     const QString& categoryDescription,
                     ElementModel* categoryElements);
signals:

private:

    QList<CategoryModel*> m_categoryList;

};

#endif // OFFERSCONTROLLER_H
