using UnityEngine;
using System.Collections;
using System;

public class Heap<T> where T : IHeapItem<T> {

    T[] items;
    int currentItemCount;

    public Heap(int maxHeapSize)
    {
        items = new T[maxHeapSize];
    }

    public void Add(T item)
    {
        item.heapIndex = currentItemCount;
        items[currentItemCount] = item;
        SortUP(item);
        currentItemCount++;
    }

    public void UpdateItem(T item)
    {
        SortUP(item);

    }

    public int Count
    {
        get
        {
            return currentItemCount;
        }
    }

    public bool Contains(T item)
    {
        return Equals(items[item.heapIndex], item);
    }

    public T removeFirst()
    {
        T firstItem = items[0];
        currentItemCount--;
        items[0] = items[currentItemCount];
        items[0].heapIndex = 0;
        SortDOWN(items[0]);
        return firstItem;
    }

    void SortUP(T item)
    {
        int parentIndex = (item.heapIndex - 1) / 2;

        while(true)
        {
            T parentItem = items[parentIndex];
            if (item.CompareTo(parentItem) > 0)
            {
                Swap(item, parentItem);
            }
            else
            {
                break;
            }
            parentIndex = (item.heapIndex - 1) / 2;
        }
    }

    void SortDOWN(T item)
    {
        while (true)
        {
            int childIndexLeft = item.heapIndex * 2 + 1;
            int childInedxRight = item.heapIndex * 2 + 2;
            int swapIndex = 0;

            if (childIndexLeft < currentItemCount)
            {
                swapIndex = childIndexLeft;

                if (childInedxRight < currentItemCount)
                {
                    if (items[childIndexLeft].CompareTo(items[childInedxRight]) < 0)
                        swapIndex = childInedxRight;
                }
                if (item.CompareTo(items[swapIndex]) < 0)
                    Swap(item, items[swapIndex]);
                else
                    return;
            }
            else
                return;
        }
    }

    void Swap (T itemA, T itemB)
    {
        items[itemA.heapIndex] = itemB;
        items[itemB.heapIndex] = itemA;

        int itemAindex = itemA.heapIndex;
        itemA.heapIndex = itemB.heapIndex;
        itemB.heapIndex = itemAindex;
    }

}


