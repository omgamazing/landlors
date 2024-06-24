//对整副牌初始化和洗牌、对玩家发牌、对玩家手中的牌排序

import QtQuick 2.0
Item {


    // 发牌动画
    //Repeater 仅用于生成多个元素的实例，而不是为每个元素创建独立的对象,需要通过元素本身或者与元素关联的数据模型来控制每个动画的启动
    Repeater{
        id: cardList
        model: 7
        delegate: AnimatedSprite {
            id: ani
            width: 61
            height: 96
            source: "qrc:/poker/rear.png"
            x: window.centercard.x
            y: window.centercard.y


            Sprite {
                source: "qrc:/poker/rear.png"
                frameWidth: 61
                frameHeight: 96
                frameCount: 10
                frameDuration: 300
            }



            PropertyAnimation on opacity {
                from: 0
                to: 1
                duration: 300
            }

            SequentialAnimation on x {
                id: moveCardX
                running:false
                NumberAnimation {
                    from: window.centercard.x
                    to: {
                        if (index % 3 === 0) return x;//window.width / 2 - window.centercard.width / 2
                        else if (index % 3 === 1) return window.centercard.x + (window.width / 2.8) - window.centercard.width / 2;
                        else return window.centercard.x - (window.width / 2.8) + window.centercard.width / 2;
                    }
                    duration: 300
                    loops:17
                }


            }

            SequentialAnimation on y {
                id: moveCardY
                running:false
                NumberAnimation {
                    from: window.centercard.y
                    to: {
                        if (index % 3 === 0) return window.centercard.y + window.height /2.5 - window.centercard.height / 2;
                        else if (index % 3 === 1) return y;
                        else return  y ;
                    }
                    duration: 300
                    loops:17
                }


            }
        }
    }




            Timer{
                id: delayTimer
                interval: 1000
                running:false
                repeat:false
                onTriggered: {
                    //console.log("Timer triggered for card", index);
                    moveCardX.start();
                    moveCardY.start();

                }
            }

            function startAnimation() {
                console.log("Starting animation for card", index);
                delayTimer.start()
            }







    function startDealing() {

        console.log("-------Starting dealing animation-------");
        for (let i = 0; i < cardList.count; ++i) {
            console.log("i:",i)
            ani.startAnimation()
        }



        console.log("-----Ending dealing animation------");
        }

}
