#pragma once

#include <QDebug>
#include <QObject>
#include <QString>
#include <QTime>
#include <QTimer>

class BackEnd : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool playerSide READ playerSide WRITE setPlayerSide NOTIFY
               playerSideChanged)
    Q_PROPERTY(int moves READ moves WRITE setMoves NOTIFY movesChanged);
    Q_PROPERTY(
            QString gameTime READ gameTime WRITE setGameTime NOTIFY gameTimeChanged);
    Q_PROPERTY(bool gameOn READ gameOn WRITE setGameOn NOTIFY gameOnChanged);
    Q_PROPERTY(QString score READ score WRITE setScore NOTIFY scoreChanged)

public:
    explicit BackEnd(QObject *parent = nullptr);
    bool playerSide();
    void setPlayerSide(const bool pSide);

    int moves() const;
    void setMoves(int newMoves);

    QString gameTime() const;

    bool gameOn() const;

    const QString &score() const;


public slots:
    void setGameTime(const QString &gameTime);

    void setGameOn(bool gameOn);
    void setScore(const QString &newScore);
    void updateTime();

signals:
    void playerSideChanged();
    void testStringChanged();

    void movesChanged();

    void gameTimeChanged(QString gameTime);

    void gameOnChanged(bool gameOn);

    void scoreChanged();

private:
    bool m_gameOn;
    bool m_playerSide;

    int m_moves;
    int m_gameTimeSeconds;

    QString m_time;
    QTime m_gameTime;
    QTimer *m_gameTimer;
    QString m_score;
};
