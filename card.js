//创建card属性 point：牌面 suit：花色
//花色 每一项有唯一的整数值
/*const CardSuit={
    Diamond:1,//菱形
    Club:2, //梅花
    Heart:3, //红心
    Spade:4,//黑桃
    Joker:5
}*/
/*//图片命名第一个就是卡牌的花色
function getSuit(card) {
    return parseInt(card.substring(0, 1));
}*/
//图片第二个命名就是卡牌的大小1-13：A-k 5-1：小王 5-2：大王
/*function getPoint(card) {
    let i = parseInt(card.substring(2));//2
    if (card.name.substring(2) === "2")
        i += 13;
    if (card.name.substring(2)=== "1")//A
        i += 13;
    if (card.name.substring(0,1) === "5")
        i += 2; // 是王
    return i;
}*/
function getSuitName(suit) {
    switch (suit) {
        case 1:
            return '1'; // 菱形
        case 2:
            return '2'; // 梅花
        case 3:
            return '3'; // 红心
        case 4:
            return '4'; // 黑桃
        case 5:
            return '5'; // 鬼
        default:
            return '';
    }
}
//简单粗暴的将所有牌举例出来，以免混乱
let all = [
    {
        suit: '👻',
        pname: '大王',
        rank: 15
    },
    {
        suit: '👻',
        pname: '小王',
        rank: 14
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '2',
        rank: 13
    },
    {
        suit: '♥',
        pname: '2',
        rank: 13
    },
    {
        suit: '♣',
        pname: '2',
        rank: 13
    },
    {
        suit: '♦',
        pname: '2',
        rank: 13
    },
    // ----------------------------
    {
        suit: '♠',
        pname: 'A',
        rank: 12
    },
    {
        suit: '♥',
        pname: 'A',
        rank: 12
    },
    {
        suit: '♣',
        pname: 'A',
        rank: 12
    },
    {
        suit: '♦',
        pname: 'A',
        rank: 12
    },
    // ----------------------------
    {
        suit: '♠',
        pname: 'K',
        rank: 11
    },
    {
        suit: '♥',
        pname: 'K',
        rank: 11
    },
    {
        suit: '♣',
        pname: 'K',
        rank: 11
    },
    {
        suit: '♦',
        pname: 'K',
        rank: 11
    },
    // ----------------------------
    {
        suit: '♠',
        pname: 'Q',
        rank: 10
    },
    {
        suit: '♥',
        pname: 'Q',
        rank: 10
    },
    {
        suit: '♣',
        pname: 'Q',
        rank: 10
    },
    {
        suit: '♦',
        pname: 'Q',
        rank: 10
    },
    // ----------------------------
    {
        suit: '♠',
        pname: 'J',
        rank: 9
    },
    {
        suit: '♥',
        pname: 'J',
        rank: 9
    },
    {
        suit: '♣',
        pname: 'J',
        rank: 9
    },
    {
        suit: '♦',
        pname: 'J',
        rank: 9
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '10',
        rank: 8
    },
    {
        suit: '♥',
        pname: '10',
        rank: 8
    },
    {
        suit: '♣',
        pname: '10',
        rank: 8
    },
    {
        suit: '♦',
        pname: '10',
        rank: 8
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '9',
        rank: 7
    },
    {
        suit: '♥',
        pname: '9',
        rank: 7
    },
    {
        suit: '♣',
        pname: '9',
        rank: 7
    },
    {
        suit: '♦',
        pname: '9',
        rank: 7
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '8',
        rank: 6
    },
    {
        suit: '♥',
        pname: '8',
        rank: 6
    },
    {
        suit: '♣',
        pname: '8',
        rank: 6
    },
    {
        suit: '♦',
        pname: '8',
        rank: 6
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '7',
        rank: 5
    },
    {
        suit: '♥',
        pname: '7',
        rank: 5
    },
    {
        suit: '♣',
        pname: '7',
        rank: 5
    },
    {
        suit: '♦',
        pname: '7',
        rank: 5
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '6',
        rank: 4
    },
    {
        suit: '♥',
        pname: '6',
        rank: 4
    },
    {
        suit: '♣',
        pname: '6',
        rank: 4
    },
    {
        suit: '♦',
        pname: '6',
        rank: 4
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '5',
        rank: 3
    },
    {
        suit: '♥',
        pname: '5',
        rank: 3
    },
    {
        suit: '♣',
        pname: '5',
        rank: 3
    },
    {
        suit: '♦',
        pname: '5',
        rank: 3
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '4',
        rank: 2
    },
    {
        suit: '♥',
        pname: '4',
        rank: 2
    },
    {
        suit: '♣',
        pname: '4',
        rank: 2
    },
    {
        suit: '♦',
        pname: '4',
        rank: 2
    },
    // ----------------------------
    {
        suit: '♠',
        pname: '3',
        rank: 1
    },
    {
        suit: '♥',
        pname: '3',
        rank: 1
    },
    {
        suit: '♣',
        pname: '3',
        rank: 1
    },
    {
        suit: '♦',
        pname: '3',
        rank: 1
    },
];
const CardType={
            Single:"Single", //单
            Pair: "Pair",   //对子

            Triple: "Triple",           //三
            TripleWithSingle: "TripleWithSingle", //三带一
            TripleWithPair: "TripleWithPair",   //三带一对

            Plane: "Plane",              //飞机
            PlaneWithTwo: "PlaneWithTwoSingle", //飞机带两单/一对
            PlaneWithTwoPair: "PlaneWithTwoPair",   //飞机带两队

            Straight: "Straight",         //顺子
            StraightWithPair: "StraightWithPair", //连对

            Bomb: "Bomb",            //炸弹
            BombWithTow: "BombWithTwo",     //炸弹带一对或两单
            BombWithTwoPair: "BombWithPair", //炸弹带两对

            Jokers: "Jokers", //王炸

            Unknown: "Unknown", //未知 14
            Pass: "Pass"     //过
}
//洗牌
function washCard(arr) {
    arr = [...arr];
    for (const key in arr) {
        let index = parseInt(Math.random() * arr.length);
        [arr[key], arr[index]] = [arr[index], arr[key]];
    }
    // arr.reverse();
    return arr;
}
let newAll = washCard(all);//创建新的牌堆
// 发牌  直接给玩家发牌而不创建牌堆
// 发牌
function dealCard(arr) {
    let player1 = arr.slice(0,17);
    let player2 = arr.slice(17,34);
    let player3 = arr.slice(34,51);//34
    let diPai = arr.slice(51,54);
    return { player1, player2, player3, diPai };
}
let { player1, player2, player3, diPai } = dealCard(newAll);//创建玩家
//排序
function sortCard(arr){ // 这里会改变原数组（栈内引用地址复制），后面不用返回值
    // 排大小
    arr.sort((a, b) => b.rank - a.rank);
    // 排花色
    function setSuitCompare(suit) {
        switch (suit) {
            case '♠':
                return 4;
            case '♥':
                return 3;
            case '♣':
                return 2;
            case '♦':
                return 1;
            default:
                break;
        }
    }
    for (let i = 0; i < 4; i++) {
        for (const key in arr) {
            if (key !== arr.length - 1) { // 不用遍历最后一次
                let sc1 = setSuitCompare(arr[key].suit);
                let sc2 = setSuitCompare(arr[+key + 1].suit);
                if (arr[key].pname === arr[+key + 1].pname && sc1 < sc2) {
                    [arr[key], arr[+key + 1]] = [arr[+key + 1], arr[key]];
                }
            }
        }
    }
}
//判断胜利判断
function canGameOver() {
        if (player1.length === 0 || player2.length === 0) {
            gameOverShuaXinPlayerShouPai();
            // to do 刷新分数
            return true
        }else if (player3.length === 0) {
            gameOverShuaXinPlayerShouPai();
            return true;
        }
        return false
}

//判断牌的类型
function jugdeType(list){
    sortDeck(list);//排序
    let len=list.length;//card的集合

    //判断 单排 对子 三带 炸弹
    if(len<=4){
        if (len > 0 && getPoint(list[0]) === getPoint(list[len - 1])) {
        switch(len){
        case 1:return CardType.Single;//单排
        case 2:return CardType.Pair;//对子
        case 3:return CardType.Triple;//三不带
        case 4:return CardType.Bomb;   }//炸弹
        }
        //双王,炸弹
        if(len === 2 && getSuit(list[1]) === 5 && getSuit(list[0]) === 5)
                return CardType.Jokers;//wangzha
        //3带1
        if (len === 4 && ((getPoint(list[0]) === getPoint(list[len - 2])) ||
                getPoint(list[1]) === getPoint(list[len - 1]))) {
                    return CardType.TripleWithSingle;
                } else {
                    return CardType.Unknown;
                }
    }
    //获取相同的牌的次数
    let card_index = { a: [[], [], [], []] };
    getMax(card_index, list);//获取最大牌  a[0,1,2,3]分别表示重复1,2,3,4次的牌
    ////当5张以上时，连字，3带2，飞机，2顺，4带2
    if(len>=5){
        //3带2
        if (card_index.a[2].length === 1 && card_index.a[1].length === 1 && len === 5) {
                    return CardType.TripleWithPair;
        }
        //4带2(单/双)
        if (card_index.a[3].length === 1 && len === 6) {
                    return CardType.BombWithTow;
        }
        //4带2对
        if (card_index.a[3].length === 1 && card_index.a[1].length === 2 && len === 8) {
                    return CardType.BombWithTwoPair;
        }
          //顺子 保证没有王 小王point：16
        if (getSuit(list[0]) !== 5 && card_index.a[0].length === len &&
                    (getPoint(list[0]) - getPoint(list[len - 1]) === len - 1)) {
                    return CardType.Straight;
        }
      //连对
        if (card_index.a[1].length === len / 2 && len % 2 === 0 && len / 2 >= 3 &&
                    (getPoint(list[0]) - getPoint(list[len - 1]) === (len / 2 - 1))) {
                    return CardType.StraightWithPair;
        }
           //飞机
        if (card_index.a[2].length === len / 3 && (len % 3 === 0) &&
                    (getPoint(list[0]) - getPoint(list[len - 1]) === (len / 3 - 1))) {
                    return CardType.Plane;
        }
       //飞机带n单
        if (card_index.a[2].length === len / 4 &&
                    ((card_index.a[2][len / 4 - 1] - card_index.a[2][0]) === (len / 4 - 1))) {
                    return CardType.PlaneWithTwo;
        }
         //飞机带n双
        if (card_index.a[2].length === len / 5 && card_index.a[2].length === len / 5 &&
                    ((card_index.a[2][len / 5 - 1] - card_index.a[2][0]) === (len / 5 - 1))) {
                    return CardType.PlaneWithTwoPair;
        }
    }
    return CardType.Unknown;

}
// 排序函数
function sortDeck(cards) {
    cards.sort((a, b) =>{
               let pointA = getPoint(a); // 获取牌 A 的点数
               let pointB = getPoint(b); // 获取牌 B 的点数); // 按牌点数从大到小排序
               return pointB - pointA;
                });
             return cards;
}
/*function getPoint(card){
    return card.point;
}
function getSuit(card){
    return card.suit;
}*/
function getMax(card_index, list) {

    let count = new Array(14).fill(0); // 创建一个长度为14的数组，初始值都为0
        // 遍历牌列表，统计每种牌的数量
        for (let i = 0; i < list.length; i++) {
            if (getSuit(list[i]) === 5) {
                count[13]++; // 王的颜色为5，对应数组的最后一个元素
            } else {
                count[getSuit(list[i]) - 1]++; // 其他牌按值放置在数组中
            }
        }

        // 根据统计结果将各类牌分别添加到 card_index.a 数组中的不同位置
        for (let i = 0; i < 14; i++) {
            switch (count[i]) {
                case 1:
                    card_index.a[0].push(i + 1);
                    break;
                case 2:
                    card_index.a[1].push(i + 1);
                    break;
                case 3:
                    card_index.a[2].push(i + 1);
                    break;
                case 4:
                    card_index.a[3].push(i + 1);
                    break;
            }
        }

    //let frequencyMap = new Map();
        // 计算频率
        /*for (const card of list) {
            let point = getPoint(card); // 牌的牌值都是从A开始
            if (frequencyMap.has(point)) {
                frequencyMap.set(point, frequencyMap.get(point) + 1);
            } else {
                frequencyMap.set(point, 1);
            }
        }

        // 将数据放入 card_index
        frequencyMap.forEach((count, value) => {
            if (count >= 1 && count <= 4) {
                card_index.a[count - 1].push(value);
            }
        });*/
}
//查看地主牌权值，判断是否抢地主 查看2||鬼的个数
function getScore(list){
    let count=0;
    for(let i=0,len=list.length;i<len;i++){
        let card=list[i];
        if(card.name.substring(0, 1)==="5")//王炸 获取牌面名字
            count+=5;
        if(card.name.substring(2)==="2")//2
            count+=5;
    }
    return count;
}
//model
let Model={
       value: 0,// 权值
        num: 0,// 手数
        a1: [], // 单张
        a2: [],// 对子
        a3: [], // 3带
        a123: [],// 连子
        a112233: [], // 连牌
        a111222: [], // 飞机
        a4: [] // 炸弹
};
//拆牌  将手中的牌按照一定的规则或策略分成不同的组合
function getModel(list){
    // 先复制一个列表
    let list2 = list.slice();

    let model = new Model();//创建模型
    //先拆炸弹
    Common.getBoomb(list2, model);
    // 拆3带
    Common.getThree(list2, model);
    // 拆飞机
    Common.getPlane(list2, model);
    // 拆对子
    Common.getTwo(list2, model);
    // 拆连队
    Common.getTwoTwo(list2, model);
    // 拆顺子
    Common.get123(list2, model);
    // 拆单
    Common.getSingle(list2, model);
        return model;
}
const Common={
       // 拆炸弹
       getBoomb: function(list, model) {
           let del = []; // 要删除的Cards

               // 王炸
               if (list.length >= 2 && getSuit(list[0]) === 5 && getSuit(list[1]) === 5) {
                   model.a4.push(list[0].name + "," + list[1].name); // 按名字加入
                   del.push(list[0], list[1]);
               }

               // 如果王不构成炸弹则拆单
               if (list.length >= 2 && getSuit(list[0]) === 5 && getSuit(list[1]) !== 5) {
                   del.push(list[0]);
                   model.a1.push(list[0].name);
               }

               // 一般的炸弹
               for (let i = 0, len = list.length; i < len; i++) {
                   if (i + 3 < len && list[i].value === list[i + 3].value) {
                       let s = list[i].name + ",";
                       s += list[i + 1].name + ",";
                       s += list[i + 2].name + ",";
                       s += list[i + 3].name;
                       model.a4.push(s);
                       del.push(list[i], list[i + 1], list[i + 2], list[i + 3]);
                       i = i + 3;
                   }
               }

               // 从 list 中移除所有的 del
               list = list.filter(item => !del.includes(item));
       },

       // 拆3带
       getThree: function(list, model) {
           let del = []; // 要删除的Cards

               // 连续3张相同
               for (let i = 0, len = list.length; i < len; i++) {
                   if (i + 2 < len && list[i].value === list[i + 2].value) {
                       let s = list[i].name + ",";
                       s += list[i + 1].name + ",";
                       s += list[i + 2].name;
                       model.a3.push(s);
                       for (let j = i; j <= i + 2; j++) {
                           del.push(list[j]);
                       }
                       i = i + 2;
                   }
               }

               // 从 list 中移除所有的 del
               list = list.filter(item => !del.includes(item));
       },
       // 拆飞机
       getPlane: function(list, model) {
           let del = []; // 要删除的Cards

               // 从 model 的3带中查找
               let l = model.a3;
               if (l.length < 2) {
                   return;
               }
               let s = l.map(item => parseInt(item.split(",")[0].substring(2)));

               for (let i = 0, len = l.length; i < len; i++) {
                   let k = i;
                   for (let j = i; j < len; j++) {
                       if (s[i] - s[j] === j - i) {
                           k = j;
                       }
                   }
                   if (k !== i) {
                       //  i 到 k 是飞机
                       let ss = "";
                       for (let j = i; j <= k; j++) {
                           ss += l[j] + ",";
                           del.push(l[j]);
                       }
                       model.a111222.push(ss.slice(0, -1)); // 去除最后一个逗号并添加到 a111222 中
                       i = k;
                   }
               }

               // 从 l 中移除所有的 del
               del.forEach(item => {
                   let index = l.indexOf(item);
                   if (index !== -1) {
                       l.splice(index, 1);
                   }
               });
       },
       // 拆对子
       getTwo: function(list, model) {
           let del = []; // 要删除的Cards
       for (let i = 0, len = list.length - 1; i < len; i++) {
           if (list[i].name === list[i + 1].name) {
                       model.a2.push([list[i].name, list[i + 1].name]); // 使用数组来存放对子牌
                       del.push(list[i]);
                       del.push(list[i + 1]);
                       i++; // 跳过下一张牌，因为已经处理了一对
                   }
               }
               // 从 list 中移除所有的 del
               list = list.filter(item => !del.includes(item));
       },
       // 拆连队
       getTwoTwo: function(list, model) {
           let del = []; // 要删除的Cards

               // 从 model 的对子中查找
               let l = model.a2;
               if (l.length < 4) {
                   return;
               }
               let s = l.map(item => parseInt(item.split(",")[0].substring(2)));
               for (let i = 0, len = l.length; i < len; i++) {
                   let k = i;
                   for (let j = i; j < len; j++) {
                       if (s[i] - s[j] === j - i) {
                           k = j;
                       }
                   }
                   if (k - i >= 3) {
                       // 说明从 i 到 k 是连队
                       let ss = "";
                       for (let j = i; j <= k; j++) {
                           ss += l[j] + ",";
                           del.push(l[j]);
                       }
                       model.a112233.push(ss.slice(0, -1)); // 去除最后一个逗号并添加到 a112233 中
                       i = k;
                   }
               }

               model.a2 = l.filter(item => !del.includes(item));
       },
       // 拆顺子
       get123: function(list, model) {
           let del = []; // 要删除的Cards
           //第一张牌的值小于 7 或者最后一张牌的值大于 10
           if (list.length > 0 && (getPoint(list[0]) < 7 || getPoint(list[list.length - 1]) > 10)) {
                   return;
            }
            if (list.length < 5) {
                   return;
            }
            for (let i = 0, len = list.length; i < len; i++) {
                let k = i;
                for (let j = i; j < len; j++) {
                  if (getPoint(list[i]) - getPoint(list[j]) === j - i) {
                           k = j;}}
                   if (k - i >= 4) {
                       let s = "";
                       for (let j = i; j <= k; j++) {
                           s += list[j].name + ",";//构建顺子的名称字符串
                           del.push(list[j]);
                       }
                       model.a123.push(s.slice(0, -1)); // 去掉末尾的逗号
                       i = k;
                   }
               }
               // 从原始列表中删除已提取的牌
               for (let card of del) {
                   let index = list.indexOf(card);
                   if (index !== -1) {
                       list.splice(index, 1);
                   }
               }
       },
       // 拆单
       getSingle: function(list, model) {
           /*let del = []; // 要删除的Cards

               // 单张牌
               for (let i = 0, len = list.length; i < len; i++) {
                   model.a1.push(list[i].name);
                   del.push(list[i]);
               }

               // 从 list 中移除所有的 del
               list = list.filter(item => !del.includes(item));*/
           let singles = [];
               let countMap = {};

               // 统计每张牌出现的次数
               list.forEach(card => {
                   let name = card.name;
                   if (countMap[name]) {
                       countMap[name]++;
                   } else {
                       countMap[name] = 1;
                   }
               });

               // 找出只出现一次的牌
               list.forEach(card => {
                   let name = card.name;
                   if (countMap[name] === 1) {
                       singles.push(name);
                   }
               });

               // 更新 model.a1
               singles.forEach(name => model.a1.push(name));

               // 从原始列表中移除所有单牌
               list = list.filter(card => countMap[card.name] !== 1);

               return list; // 返回更新后的列表，不再包含单牌
       }
}
//隐藏牌
function hideCards(list) {
    for (let i = 0, len = list.length; i < len; i++) {
        list[i].setVisible(false);
    }
}
//检查当前的牌是否能出
function checkCards(c,current){
    let currentlist = (current[0].length > 0) ? current[0] : current[2];
        let cType = jugdeType(c);

        if (cType !== CardType.Bomb && c.length !== currentlist.length) {
            return 0;
        }

        if (jugdeType(c) !== jugdeType(currentlist)) {
            return 0;
        }
        //王炸弹
        if (cType === CardType.Bomb) {
            if (c.length === 2)
                return 1;
            if (currentlist.length === 2)
                return 0;
        }
        //单牌对子三带炸弹
        if (cType === CardType.Single || cType === CardType.Pair || cType === CardType.Triple || cType === CardType.Bomb) {
            if (getPoint(c[0]) <= getPoint(currentlist[0])) {
                return 0;
            } else {
                return 1;
            }
        }
        //连队顺子飞机
        if (cType === CardType.Straight || cType === CardType.StraightWithPair || cType === CardType.Plane) {
            if (getPoint(c[0]) <= getPoint(currentlist[0])) {
                return 0;
            } else {
                return 1;
            }
        }
         //按照重复次数排序
        if (cType === CardType.TripleWithSingle || cType === CardType.TripleWithPair || cType === CardType.BombWithTow || cType === CardType.BombWithTowPair
            || cType === CardType.PlaneWithTwo || cType === CardType.PlaneWithTwoPair) {
            let a1 = getOrder2(c);//我的牌
            let a2 = getOrder2(currentlist);//当前最大牌
            if (getPoint(a1[0]) < getPoint(a2[0])) {
                return 0;
            }
        }
}
//按照重复次数给卡牌排序
function getOrder2(list) {
    let list2 = [...list]; // 复制列表
    let list3 = [];
    let a = new Array(20).fill(0); // 初始化计数数组

    list2.forEach(card => {
        a[getPoint(card)]++;
    });

    for (let i = 0; i < 20; i++) {
        let max = 0;
        for (let j = 19; j >= 0; j--) {
            if (a[j] > a[max])
                max = j;
        }

        list2.forEach(card => {
            if (getPoint(card) === max) {
                list3.push(card);
            }
        });
        // 移除已处理的元素
        list2 = list2.filter(card => getPoint(card) !== max);
        a[max] = 0;
    }
    return list3;
}
//测试牌型
function test(){
    // 测试用例
    //let testCases = [
        // 单张牌
        //[new Card(3, 1)],

        // 对子
        //[new Card(2, 2), new Card(2, 4)],

        // 三张牌
        //[new Card(5, 3), new Card(5, 4), new Card(5, 1)],
        //三带一
        //[new Card(5, 3), new Card(5, 4), new Card(5, 1), new Card(4, 1)],
        //三带对
        //[new Card(5, 3), new Card(5, 4), new Card(5, 1), new Card(4, 1), new Card(4, 3)],

        // 四张牌
        //[new Card(1, 2), new Card(1, 4), new Card(1, 3), new Card(1, 1)],

        // 炸弹
        //[new Card(2, 1), new Card(2, 2), new Card(2, 3), new Card(2, 4)],

        // 顺子  被检测为三带一对
        //[new Card(1, 3), new Card(2, 4), new Card(3, 1), new Card(4, 2), new Card(5, 3)],
        // 连队
        //[new Card(1, 3), new Card(1, 4), new Card(2, 1), new Card(2, 2), new Card(3, 3), new Card(3, 4)],
        //飞机不带
        //[new Card(1, 3), new Card(1, 4), new Card(1, 2),new Card(2, 1), new Card(2, 2), new Card(2, 3)],
        //飞机带两对  为检测
        //[new Card(1, 3), new Card(1, 4), new Card(1, 2),new Card(2, 1), new Card(2, 2), new Card(2, 3), new Card(5, 4), new Card(5, 1), new Card(4, 1), new Card(4, 3)],
        //飞机带两单  未检查到
        //[new Card(1, 3), new Card(1, 4), new Card(1, 2),new Card(2, 1), new Card(2, 2), new Card(2, 3), new Card(5, 1), new Card(4, 1)],
        //炸弹带两单  为检测到
        //[new Card(2, 1), new Card(2, 2), new Card(2, 3), new Card(2, 4), new Card(4, 2)],
        //炸弹带一对
        //[new Card(2, 1), new Card(2, 2), new Card(2, 3), new Card(2, 4), new Card(4, 2), new Card(4, 3)],
        // 王炸
        //[new Card(16, 5), new Card(17, 5)],
      //];

    //testCases.forEach(function(cards) {
        //let result = jugdeType(cards);
        //console.log(`牌型为${result}`);
    //});

    //name
    /*let aceOfDiamonds = new Card(1, 1); // Ace of Diamonds (菱形)
    console.log(aceOfDiamonds.name); // Outputs: '1-1.png'

    let kingOfHearts = new Card(13, 3); // King of Hearts (红心)
    console.log(kingOfHearts.name); // Outputs: '3-K.png'

    let joker1 = new Card(14, 5); // 小王
    console.log(joker1.name); // 输出: '5-15.png'

    let joker2 = new Card(15, 5); // 大王
    console.log(joker2.name); // 输出: '5-16.png'
*/

    /*let list = [
        { name: 'A' },
        { name: '2' },
        { name: '3' },
        { name: '3' },
        { name: '4' },
        { name: '4' },
        { name: '4' },
        { name: '5' },
        { name: '6' },
        { name: '6' },
        { name: '7' },
        { name: '8' },
        { name: '8' },
        { name: '9' },
        { name: '9' }
    ];*/
    //let model = { a1: [] };
    /*let model = {
        a1: [], // 存放单牌的数组
        a2: []  // 存放对子牌的数组
    };*/
    /*console.log("Before getTwo:", list);
    Common.getTwo(list, model);
    console.log("Pairs:", model.a2);*/
    /*let model={
           //value: 0,// 权值
            //num: 0,// 手数
            a1: [], // 单张
            a2: [],// 对子
            a3: [], // 3带
            a123: [],// 连子
            a112233: [], // 连牌
            a111222: [], // 飞机
            a4: [] // 炸弹
    };*/

    //model
    //console.log("Before:", list);
    /*Common.getSingle(list, model);
    console.log("Single cards:", model.a1);*/

    /*Common.getThree(list, model);
    console.log("getthree:",model.a3);

    Common.getBoomb(list, model);
    console.log("getBoomb",model.a4);

    Common.getTwo(list, model);
    console.log("Pairs:", model.a2);

    Common.get123(list, model);
    console.log("get123:",model.a123);

    Common.getTwoTwo(list, model);
    console.log("gettwotwo:",model.a112233);

    Common.getPlane(list, model);
    console.log("getplane",model.a111222);*/

}
//test();
//module.exports = {
  //Card,
  //CardSuit
//};
