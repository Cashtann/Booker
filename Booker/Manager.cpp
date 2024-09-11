#include "Manager.h"
#include <QDebug>

Manager::Manager(QObject *parent)
    : QObject{parent}
{}

void Manager::debug()
{
    qDebug() << "[DEBUG] Something happend";
}

void Manager::printString(const QString &text)
{
    qDebug() << "[DEBUG]" << text;
}

QString Manager::currentPage() const
{
    return m_currentPage;
}

void Manager::setCurrentPage(const QString &newCurrentPage)
{
    if (m_currentPage == newCurrentPage)
        return;
    m_currentPage = newCurrentPage;
    emit currentPageChanged();
}
