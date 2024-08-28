#include "directionavgtest.h"

DirectionAvgTest::DirectionAvgTest(QObject *parent)
    : QObject{parent}
{}

void DirectionAvgTest::static_result_test() {
    DirectionAvg direction_avg;

    connect(&direction_avg, &DirectionAvg::directionalAVGEmmited, this, &DirectionAvgTest::get_case_result);

    QList<double> first_case = {50., 80.};
    current_result_match = 65;
    direction_avg.calculateDirectionalAVG(first_case);

    QCoreApplication::processEvents();


    QList<double> second_case = {180., 0., 30., 50., 80.};
    current_result_match = 53.3333;
    direction_avg.calculateDirectionalAVG(second_case);

    QCoreApplication::processEvents();

}


void DirectionAvgTest::get_case_result(double result) {
    QCOMPARE(result - current_result_match < 0.1, true);
}
