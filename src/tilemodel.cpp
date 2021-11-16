#include "tilemodel.h"

TileModel::TileModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Set names to the role name hash container (QHash<int, QByteArray>)
    // model.whitestone, model.blackstone, model.emptystone, model.highlighted
    m_roleNames[WhiteStoneRole] = "whitestone";
    m_roleNames[BlackStoneRole] = "blackstone";
    m_roleNames[EmptyStoneRole] = "emptystone";
    m_roleNames[TestStringRole] = "teststring";
}


int TileModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    // return our m_tiles count
    return m_tiles.count();
}

int TileModel::columnCount(const QModelIndex &) const
{
    return 1;
}


QVariant TileModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()){
        return QVariant();
    }

    int row = index.row();
    if(row < 0 || row >= m_tiles.count()) {
        return QVariant();
    }

    const TileItem& tItem = m_tiles.at(row);

#ifdef QT_DEBUG
    qDebug() << Q_FUNC_INFO << row << role;
    qDebug() << tItem.whiteStone
             << tItem.blackStone
             << tItem.emptyStone
             << tItem.testString;
#endif

    switch (role) {
    case WhiteStoneRole:
        return tItem.whiteStone;
    case BlackStoneRole:
        return tItem.blackStone;
    case EmptyStoneRole:
        return tItem.emptyStone;
    case TestStringRole:
        return tItem.testString;
    default:
        break;
    }
    return QVariant();
}

bool TileModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()) {
        return false;
    }
    int row = index.row();
    if(row < 0 || row >= m_tiles.count()) {
        return false;
    }

    TileItem& tItem = m_tiles[row];
    switch (role) {
    case WhiteStoneRole:
        tItem.whiteStone = value.toBool();
        break;
    case BlackStoneRole:
        tItem.blackStone = value.toBool();
        break;
    case EmptyStoneRole:
        tItem.emptyStone = value.toBool();
        break;
    case TestStringRole:
        tItem.testString = value.toString();
        break;
    default:
        return false;
    }
    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags TileModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;
    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

void TileModel::insert(int index, const TileItem &tileItem)
{
    if(index < 0 || index > m_tiles.count()) {
        return;
    }
    TileItem tItem = tileItem;

    // view protocol (begin => manipulate => end]
    beginInsertRows(QModelIndex(), index, index);
    m_tiles.insert(index, tItem);
    endInsertRows();
}

void TileModel::clear()
{
    beginResetModel();
    m_tiles.clear();
    endResetModel();
}

void TileModel::append(const TileItem &tileItem)
{
    insert(m_tiles.count(), tileItem);
}

void TileModel::remove(int index)
{
    if(index < 0 || index >= m_tiles.count()) {
        return;
    }
    beginRemoveRows(QModelIndex(), index, index);
    m_tiles.removeAt(index);
    endRemoveRows();
}

QHash<int, QByteArray> TileModel::roleNames() const
{
    return m_roleNames;
}
