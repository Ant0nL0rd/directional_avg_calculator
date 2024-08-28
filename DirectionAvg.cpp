#include "DirectionAvg.h"
#include <cmath>

DirectionAvg::DirectionAvg(QObject *parent)
    : QObject{parent}
{}

void DirectionAvg::calculateDirectionalAVG(const QList<double>& directions_list) {
    /* Using coordinate approximation method. */
    double sum_x = 0;
    double sum_y = 0;

    // qDebug() << QString::number(directions_list.size());

    for (const double direction: directions_list) {
        double radians = direction * (M_PI / 180.0);
        sum_x += cos(radians);
        sum_y += sin(radians);
    }
    // calculating avg:
    sum_x /= directions_list.size();
    sum_y /= directions_list.size();

    double average_direction = atan2(sum_y, sum_x) * (180.0 / M_PI);

    average_direction = average_direction < 0 ? average_direction + 360.0 : average_direction;

    emit directionalAVGEmmited(average_direction);
}

