#pragma once

#include <QObject>
#include <QtCore>
#include <QTest>
#include "DirectionAvg.h"

class DirectionAvgTest : public QObject
{
    Q_OBJECT
public:
    explicit DirectionAvgTest(QObject *parent = nullptr);

    double current_result_match = 0;

private slots:
    void static_result_test();

    void get_case_result(double result);


};

