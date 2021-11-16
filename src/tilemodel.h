#pragma once

#include <QAbstractListModel>
#include <QList>

#ifdef QT_DEBUG
#include <QDebug>
#endif

struct TileItem
{
    bool whiteStone;
    bool blackStone;
    bool emptyStone;
    QString testString;
};

class TileModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        WhiteStoneRole = Qt::UserRole + 1,
        BlackStoneRole,
        EmptyStoneRole,
        TestStringRole
    };
    Q_ENUM(Roles)
    explicit TileModel(QObject *parent = nullptr);

    // QAbstractListModel interface
    virtual int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &/*parent*/ = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index,
                          int role= Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    // inserts a TileItem at the index (0 at begining, count-1 at end)
    Q_INVOKABLE void insert(int index, const TileItem& tileItem);
    // uses insert to insert a TileItem to end
    Q_INVOKABLE void append(const TileItem& tileItem);
    // removes a color from the index
    Q_INVOKABLE void remove(int index);
    // clear the whole model (e.g. reset)
    Q_INVOKABLE void clear();

protected:
    // return the roles mapping to be used by QML
    virtual QHash<int, QByteArray> roleNames() const override;

private:
    QHash<int, QByteArray> m_roleNames;
    QList<TileItem> m_tiles;

};

