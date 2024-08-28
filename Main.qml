import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import compas_direction_averaging

Window {
    property int application_width: 600;

    visible: true;
    width: application_width;
    height: 600;
    title: "Direction averaging"

    property double directional_average: 0;

    DirectionAvg {
        id: directional_averaging_tool;

        onDirectionalAVGEmmited: (directional_average_) => {
            directional_average = directional_average_;
        };
    }

    function recalculateAvgDirection(ingore_last_n=0) {
        let directions_list = [];

        let last_spinbox_index = direction_input_layout.children.length;
        for(let i = 0; i < last_spinbox_index - ingore_last_n; ++i) {
            directions_list.push(direction_input_layout.children[i].value / 10000)
        }

        directional_averaging_tool.calculateDirectionalAVG(directions_list)

        average_direction_display_text.text = "Average direction: " + directional_average + "°.";
    }

    ColumnLayout{
        RowLayout {
            width: application_width;
            Button {
                text: "Add direction"
                id: add_spinbox_button;
                implicitWidth: application_width / 4 - 5;
                implicitHeight: 40;
                onClicked: {
                    if (direction_input_layout.children.length < 48) {
                        // Create a new SpinBox
                        let spinBox = Qt.createQmlObject(
                            '
                            import QtQuick.Controls;
                            import QtQuick
                            SpinBox {
                                id: spinBox;
                                height: 30;
                                width: 150;
                                from: 0;
                                to: 3599999;
                                stepSize: 10000;
                                editable: true;

                                property int decimals: 4
                                property real realValue: value / decimalFactor
                                readonly property int decimalFactor: Math.pow(10, decimals)

                                function decimalToInt(decimal) {
                                    return decimal * decimalFactor
                                }

                                validator: DoubleValidator {
                                    bottom: Math.min(spinBox.from, spinBox.to);
                                    top:  Math.max(spinBox.from, spinBox.to);
                                    decimals: spinBox.decimals;
                                    notation: DoubleValidator.StandardNotation;
                                }

                                textFromValue: function(value, locale) {
                                    return Number(value / decimalFactor).toLocaleString(locale, \'f\', spinBox.decimals);
                                }

                                valueFromText: function(text, locale) {
                                    return Math.round(Number.fromLocaleString(locale, text) * decimalFactor);
                                }

                                onValueChanged: {
                                    recalculateAvgDirection();
                                }
                            }', direction_input_layout);

                        recalculateAvgDirection()

                        if (!remove_spinbox_button.enabled) {
                            remove_spinbox_button.enabled = true;
                        }
                    }

                    if (direction_input_layout.children.length === 48) {
                        add_spinbox_button.enabled = false;
                    }
                }
            }

            Button {
                text: "Remove direction"
                id: remove_spinbox_button;
                implicitWidth: application_width / 4 - 5;
                implicitHeight: 40;
                enabled: false;
                onClicked: {
                    if (direction_input_layout.children.length > 0) {
                        let last_spinbox_index = direction_input_layout.children.length;
                        direction_input_layout.children[last_spinbox_index - 1].destroy();
                        if (!add_spinbox_button.enabled) {
                            add_spinbox_button.enabled = true;
                        }
                        recalculateAvgDirection(1)
                    }
                    if (direction_input_layout.children.length === 1) {
                        remove_spinbox_button.enabled = false;
                    }


                }
            }

            Button {
                text: "Enter next"
                implicitWidth: application_width / 4 - 5;
                implicitHeight: 40;
                onClicked: {
                    let last_spinbox_index = direction_input_layout.children.length;
                    for(let i = last_spinbox_index - 1; i > 0; --i) {
                        direction_input_layout.children[i].value = direction_input_layout.children[i - 1].value;
                    }
                    direction_input_layout.children[0].value = 0;
                }
            }

            Button {
                text: "Enter prev"
                implicitWidth: application_width / 4 - 5;
                implicitHeight: 40;
                onClicked: {
                    let last_spinbox_index = direction_input_layout.children.length;
                    for(let i = 0; i < last_spinbox_index - 1; ++i) {
                        direction_input_layout.children[i].value = direction_input_layout.children[i + 1].value;
                    }
                    direction_input_layout.children[last_spinbox_index - 1].value = 0;
                }
            }

        }

        Frame{
            implicitWidth: application_width;
            implicitHeight: 400;
            GridLayout {
                id: direction_input_layout;
                anchors.fill: parent;
                columns: 4;
            }
        }
        RowLayout {
            Text {
                id: average_direction_display_text;
                text: qsTr("Average direction: NaN°.");
            }

        }
    }


}
