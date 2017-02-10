// creates a path from (startX, startY) to (endX, endY)

var  startRoomX = argument0;
var  startRoomY = argument1;
var  endRoomX = argument2;
var  endRoomY = argument3;

startX = startRoomX div oAstar.blockSize;
startY = startRoomY div oAstar.blockSize;
endX = endRoomX div oAstar.blockSize;
endY = endRoomY div oAstar.blockSize;

G = ds_map_create();
H = ds_map_create();
F = ds_priority_create();
P = ds_map_create();
C = ds_list_create();

ds_map_add(G, getKey(startX, startY), 0);

searching = true;
found = false;
curX = startX;
curY = startY;
while(searching) {
    processCurrentNode();
}

var path = -1;
if (found) {
    path = path_add();
    var curNode = getKey(endX, endY);
    while(curNode != getKey(startX, startY)) {
        path_add_point(path, getKeyX(curNode) * oAstar.blockSize, getKeyY(curNode) * oAstar.blockSize, 100);
        curNode = ds_map_find_value(P, curNode);
    }
    path_add_point(path, startX * oAstar.blockSize, startY * oAstar.blockSize, 100);
    path_reverse(path);
    path_set_closed(path, false);
}

ds_map_destroy(G);
ds_map_destroy(H);
ds_priority_destroy(F);
ds_map_destroy(P);
ds_list_destroy(C);

return path;


