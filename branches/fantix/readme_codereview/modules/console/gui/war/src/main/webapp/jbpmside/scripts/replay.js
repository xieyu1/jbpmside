
var index = 0;
var x = 0;
var y = 0;

var dom = null;

var path = [];
var num = 0;
var running = false;

var step = 10;

function prev() {
    init();

    if (index > 0) {
        index--;
        pushNextNode();
    }
}

function next() {
    init();

    if (index < array.length - 1) {
        index++;
        pushNextNode();
    }
}

function replay() {
    if (!running) {
        init();

        for (var i = 0; i < array.length; i++) {
            index = i;
            pushNextNode();
        }
        x = path[path.length - 3].x;
        y = path[path.length - 3].y;
        num = path.length - 3;
    }
}

function init() {
    if (dom == null) {
        var node = array[0];
        x = node.x + node.w / 2;
        y = node.y + node.h / 2;
        path.push({
            count: step,
            x: x,
            y: y
        });

        dom = document.createElement('img');
        document.body.appendChild(dom);
        dom.style.position = 'absolute';
        dom.src = 'images/icons/user.png';
        dom.style.left = x + 'px';
        dom.style.top = y + 'px';
    }
}

function pushNextNode() {
    var node = array[index];
    var lastNode = path[path.length - 1];
    var nextNode = {
        count: 0,
        x: node.x + node.w / 2,
        y: node.y + node.h / 2
    };
    nextNode.dx = (nextNode.x - lastNode.x) / step;
    nextNode.dy = (nextNode.y - lastNode.y) / step;

    path.push(nextNode);
    setTimeout('execute()', 1000 / step);
}

function execute() {
    if (num < path.length - 1) {
        running = true;
        var nextNode = path[num + 1];
        if (nextNode.count < step) {
            nextNode.count++;
            x += nextNode.dx;
            y += nextNode.dy;
            dom.style.left = (x - 10) + 'px';
            dom.style.top = (y - 10) + 'px';
            setTimeout('execute()', 1000 / step);
        } else {
            if (num == path.length - 2) {
                num++;
                running = false;
            } else {
                num++;
                setTimeout('execute()', 1000 / step);
            }
        }
    } else {
        running = false;
    }
}
