#include "backend.h"

BackEnd::BackEnd(QObject *parent)
    : QObject(parent)
    , m_playerSide(false)
    , m_moves(0)
{

}

bool BackEnd::playerSide()
{
    return m_playerSide;
}

void BackEnd::setPlayerSide(const bool pSide)
{
    if (m_playerSide == pSide)
        return;
    m_playerSide = pSide;
    emit playerSideChanged();
}


int BackEnd::moves() const
{
    return m_moves;
}

void BackEnd::setMoves(int newMoves)
{
    if (m_moves == newMoves)
        return;
    m_moves = newMoves;
    emit movesChanged();
}
