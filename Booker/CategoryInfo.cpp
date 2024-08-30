#include "CategoryInfo.h"

CategoryInfo::CategoryInfo(QObject *parent)
    : QObject{parent}
{}


QString CategoryInfo::name() const
{
    return m_name;
}

void CategoryInfo::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

QString CategoryInfo::header() const
{
    return m_header;
}

void CategoryInfo::setHeader(const QString &newHeader)
{
    if (m_header == newHeader)
        return;
    m_header = newHeader;
    emit headerChanged();
}

QString CategoryInfo::description() const
{
    return m_description;
}

void CategoryInfo::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}

ElementModel *CategoryInfo::elements() const
{
    return m_elements;
}

void CategoryInfo::setElements(ElementModel *newElements)
{
    if (m_elements == newElements)
        return;
    m_elements = newElements;
    emit elementsChanged();
}
