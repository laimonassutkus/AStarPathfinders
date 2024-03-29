var debug = false;

ds_list_add(C, getKey(curX, curY));
var distFromStartToCurrent = ds_map_find_value(G, getKey(curX, curY));

for (var i = max(0, curX - 1); i <= min(oAstar.fieldWidth - 1, curX + 1); i++) {
    for (var j = max(0, curY - 1); j <= min(oAstar.fieldHeight - 1, curY + 1); j++) {
        if (i == curX && j == curY)
            continue;
        var closed = ds_list_find_index(C, getKey(i,j)) != -1;
        var diagonal = (i + j) % 2 == (curX + curY) % 2;
        var canWalk = false;
        var distFromCurrentToIJ = 0;
        if (diagonal) { 
            if (debug) show_message("diagonal: " + "i: " + string(i) + " j: " + string(j) + " curX: " + string(curX) + " curY " + string(curY));
            canWalk = oAstar.walkable[i,j] && oAstar.walkable[curX, j] && oAstar.walkable[i, curY]; 
            distFromCurrentToIJ = 1.414;
        } else {
            if (debug) show_message("non-diagonal" + "i: " + string(i) + " j: " + string(j) + " curX: " + string(curX) + " curY " + string(curY));
            canWalk = oAstar.walkable[i,j]; 
            distFromCurrentToIJ = 1;  
        }
        if (!closed && canWalk) {
            var tempG = distFromCurrentToIJ + distFromStartToCurrent;
            var tempH = abs(i - endX) + abs(j - endY);
            var tempF = tempG + tempH;
            var processed = ds_map_exists(G, getKey(i,j));
            if (processed) {    
                if(ds_map_find_value(G,getKey(i,j)) > tempG) {
                    ds_map_replace(G, getKey(i,j), tempG);
                    ds_map_replace(H, getKey(i,j), tempH);
                    ds_priority_change_priority(F, getKey(i,j), tempF);
                    ds_map_replace(P, getKey(i,j), getKey(curX, curY));
                }
            } else {
                ds_map_add(G, getKey(i,j), tempG);
                ds_map_add(H, getKey(i,j), tempH);
                ds_priority_add(F, getKey(i,j), tempF);
                ds_map_add(P, getKey(i,j), getKey(curX, curY));
            }
        }
    }
}

var minF = -1;
var empty = ds_priority_empty(F);
if (!empty) {
    var minF = ds_priority_delete_min(F)
}
if (minF == -1) {
    searching = false;
    found = false;
} else {
    curX = getKeyX(minF);
    curY = getKeyY(minF);
}

if (curX == endX && curY == endY) {
    searching = false;
    found = true;
}






























;
