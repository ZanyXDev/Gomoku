#include "backend.h"

BackEnd::BackEnd(QObject *parent)
    : QObject(parent),
      m_gameOn(false),
      m_playerSide(false),
      m_moves(0),
      m_gameTimeSeconds(0),
      m_time(QString("00:00")),
      m_gameTime(0, 0),
      m_score(QString("000000")){
    m_gameTimer = new QTimer(this);
    m_gameTimer->setInterval(1000);
    connect(m_gameTimer, &QTimer::timeout, this, &BackEnd::updateTime);
}

bool BackEnd::playerSide() { return m_playerSide; }

void BackEnd::setPlayerSide(const bool pSide) {
    if (m_playerSide == pSide) return;
    m_playerSide = pSide;
    emit playerSideChanged();
}

int BackEnd::moves() const { return m_moves; }

void BackEnd::setMoves(int newMoves) {
    if (m_moves == newMoves) return;
    m_moves = newMoves;
    emit movesChanged();
}

QString BackEnd::gameTime() const { return m_time; }

bool BackEnd::gameOn() const { return m_gameOn; }

void BackEnd::setGameTime(const QString &gameTime) {
    if (m_time == gameTime) return;

    m_time = gameTime;
    emit gameTimeChanged(m_time);
}

void BackEnd::setGameOn(bool gameOn) {
    if (m_gameOn == gameOn) return;

    m_gameOn = gameOn;
    (m_gameOn) ? m_gameTimer->start() : m_gameTimer->stop();
    emit gameOnChanged(m_gameOn);
}

void BackEnd::updateTime() {
    if (m_gameOn) {
        m_gameTimeSeconds++;
        qDebug() << "time" << m_gameTimeSeconds;
        setGameTime(m_gameTime.addSecs(m_gameTimeSeconds).toString("m:ss"));
    }
}

const QString &BackEnd::score() const
{
    return m_score;
}

void BackEnd::setScore(const QString &newScore)
{
    if (m_score == newScore)
        return;
    m_score = newScore;
    emit scoreChanged();
}
