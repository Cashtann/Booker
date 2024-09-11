#ifndef MANAGER_H
#define MANAGER_H

#include <QObject>

class Manager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged FINAL)
public:
    explicit Manager(QObject *parent = nullptr);


    QString currentPage() const;
    void setCurrentPage(const QString &newCurrentPage);

public slots:
    void debug();
    void printString(const QString& text);

signals:
    void currentPageChanged();
private:
    QString m_currentPage = "Home";
};

#endif // MANAGER_H
