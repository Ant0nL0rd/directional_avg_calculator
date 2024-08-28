#pragma once

#include <QObject>
#include <QtQml>
#include <QtCore/QList>
#include <QDebug>

class DirectionAvg : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit DirectionAvg(QObject *parent = nullptr);

    // args and return in degrees!
    Q_INVOKABLE void calculateDirectionalAVG(const QList<double>& directions_list);

signals:
    // value in degrees!
    void directionalAVGEmmited(double dicetional_avg);
};
