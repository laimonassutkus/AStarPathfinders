using UnityEngine;
using System.Collections;
using System;

public class Node : IHeapItem<Node>
{

    public bool walkable;
    public Vector3 worldPosition;
    public int gridX = 0;
    public int gridY = 0;

    public int gCost;
    public int hCost;
    public Node parent;
    int hpIndex;

    public Node(bool _walkable, Vector3 _worldPos)
    {
        walkable = _walkable;
        worldPosition = _worldPos;
    }

    public Node(bool _walkable, Vector3 _worldPos, int _gridX, int _gridY)
    {
        walkable = _walkable;
        worldPosition = _worldPos;
        gridX = _gridX;
        gridY = _gridY;
    }

    public int fCost
    {
        get
        {
            return gCost + hCost;
        }
    }

    public int heapIndex
    {
        get
        {
            return hpIndex;
        }

        set
        {
            hpIndex = value;
        }
    }

    public int CompareTo(Node other)
    {
        int compare = fCost.CompareTo(other.fCost);
        if (compare == 0)
        {
            compare = hCost.CompareTo(other.hCost);
        }
        return -compare;
    }
}
