import QtQuick 2.13
import QtQuick.Layouts 1.3

// FlickablePage already contains an AppFlickable and ScrollIndicator
Item{
    width: dp(28)
    height: dp(28)
    property var durationAnimation: [1000, 700]
    Rectangle{
        id: outherRect
        width: dp(34)
        height: dp(34)
        color: bp.red_line_color
        radius: height/2
        opacity: 0.4
        anchors.centerIn: parent
        
        Rectangle{
            id: innerRect
            anchors.centerIn: parent
            height: parent.height/2
            width: height
            radius: height/2
            color: parent.color
            
            transformOrigin: Item.Center
            
            SequentialAnimation{
                running: true
                loops: Animation.Infinite
                ScaleAnimator{
                    id: scaleanim_up
                    target: innerRect
                    from: 0.5
                    to: 1
                    duration: durationAnimation[0]
                }
                ScaleAnimator{
                    id: scaleanim_down
                    target: innerRect
                    from: 1
                    to: 0.5
                    duration: durationAnimation[0]
                }
            }
        }
        
        SequentialAnimation{
            running: true
            loops: Animation.Infinite
            ScaleAnimator{
                target: outherRect
                from: 0.5
                to: 1
                duration: durationAnimation[0]
            }
            ScaleAnimator{
                target: outherRect
                from: 1
                to: 0.5
                duration: durationAnimation[0]
            }
        }
    }
}
