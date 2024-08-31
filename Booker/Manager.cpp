#include "Manager.h"
#include <QDebug>

Manager::Manager(QObject *parent)
    : QObject{parent}
{}

void Manager::debug()
{
    qDebug() << "[DEBUG] Something happend";
}
