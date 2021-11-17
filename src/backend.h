#pragma once

#include <QObject>
#include <QString>

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool playerSide READ playerSide WRITE setPlayerSide NOTIFY playerSideChanged)
    Q_PROPERTY(int moves READ moves WRITE setMoves NOTIFY movesChanged);

public:
    explicit BackEnd(QObject *parent = nullptr);
    bool playerSide();
    void setPlayerSide(const bool pSide);


    int moves() const;
    void setMoves(int newMoves);

signals:
    void playerSideChanged();
    void testStringChanged();

    void movesChanged();

private:
    bool m_playerSide;
    int m_moves;
};

