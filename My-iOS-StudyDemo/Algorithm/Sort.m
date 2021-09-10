//
//  Sort.m
//  My-iOS-StudyDemo
//
//  Created by Lingye Han on 2021/4/21.
//

#import "Sort.h"

@interface Sort ()

//- (void)swapA:(int *)a B:(int *)b;

@end

@implementation Sort

//public static void bubbleSort(int[] arr) {
//    int temp = 0;
//    for (int i = arr.length - 1; i > 0; i--) { // 每次需要排序的长度
//        for (int j = 0; j < i; j++) { // 从第一个元素到第i个元素
//            if (arr[j] > arr[j + 1]) {
//                temp = arr[j];
//                arr[j] = arr[j + 1];
//                arr[j + 1] = temp;
//            }
//        }//loop j
//    }//loop i
//}// method bubbleSort

/**
 冒泡排序（Bubble Sort），是一种计算机科学领域的较简单的排序算法。O(n2)
 基本思想:
 它重复地走访过要排序的元素列，依次比较两个相邻的元素，如果顺序（如从大到小、首字母从Z到A）错误就把他们交换过来。走访元素的工作是重复地进行直到没有相邻元素需要交换，也就是说该元素列已经排序完成。
 这个算法的名字由来是因为越小的元素会经由交换慢慢“浮”到数列的顶端（升序或降序排列），就如同碳酸饮料中二氧化碳的气泡最终会上浮到顶端一样，故名“冒泡排序”。
 适用场景:
 冒泡排序思路简单，代码也简单，特别适合小数据的排序。但是，由于算法复杂度较高，在数据量大的时候不适合使用。
 */
- (void)bubbleSort:(NSMutableArray *)array {
    int count = (int)[array count] - 1;
    for (int i = 0; i<count; i++) {
        bool swapFlag = false; // 优化改进
        for (int j = 0; j<count-i; j++) {
            NSInteger left = [array[j] integerValue];
            NSInteger right = [array[j+1] integerValue];
            if (left > right) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                swapFlag = true;
            }
        }
        if (swapFlag == false) {
            break;
        }
    }
    NSLog(@"[Bubble Sort] 从小到大排序: %@", [array componentsJoinedByString:@", "]);
    
    for (int i=count; i>=0; i--) { // 每次需要排序的长度
        for (int j=0; j<i; j++) { // 从第一个元素到第i个元素
            if (array[j] > array[j+1]) {
                [self swapArray:array low:j high:j+1];
            }
        }
    }
    NSLog(@"[Bubble Sort] 从大到小排序: [%@]", [array componentsJoinedByString:@", "]);
}

/**
 快速排序（Quicksort）是对冒泡排序算法的一种改进。
 基本思想：
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
 适用场景
 快速排序在大多数情况下都是适用的，尤其在数据量大的时候性能优越性更加明显。但是在必要的时候，需要考虑下优化以提高其在最坏情况下的性能。
 */
- (void)quickSort:(NSMutableArray *)array left:(int)left right:(int)right {
    if (left >= right) {
        return;
    }
    
    int i = left;
    int j = right;
    // 1. 基准(Pivot)数据(任选一个数作为关键数据)
    id key = array[i];
    // 2. 分区
    while (i < j) {
        // j 向前搜索：当key是目前最大的数时(array[j]的前面)，会出现i=j的情况
        while (i < j && [array[j] intValue] >= [key intValue]) {
            NSLog(@"i>>");
            j--;
        }
//        if (i == j) {
//            break;
//        }
        // i++ 会减少一次array[i]和key的比较
        array[i++] = array[j];
//        array[i] = array[j]; //交换比基准大的记录到左端
        
        // i 向后搜索：当key是目前最小的数时，会出现i=j的情况
        while (i < j && [array[i] intValue] <= [key intValue]) {
            i++;
            NSLog(@"j>>");
        }
//        if (i == j) {
//            break;
//        }
        // j-- 会减少一次array[j]和key的比较
        array[j--] = array[i];
//        array[j] = array[i]; //交换比基准小的记录到右端
    }
    array[i] = key;
    // 3. 递归
    [self quickSort:array left:left right:i-1];
    [self quickSort:array left:i+1 right:right];
}

/**
 选择排序
 选择排序是一种简单直观的排序算法，它也是一种交换排序算法，和冒泡排序有一定的相似度，可以认为选择排序是冒泡排序的一种改进。
 算法描述
 在未排序序列中找到最小（大）元素，存放到排序序列的起始位置
 从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 重复第二步，直到所有元素均排序完毕。
 */
- (void)selectionSort:(NSMutableArray *)array {
    for (int i=0; i<array.count-1; i++) {
        int min = i;
        for (int j=i+1; j<array.count; j++) {
            if (array[min] > array[j]) {
                min = j;
            }
        }
        [self swapArray:array low:min high:i];
    }
}

/**
 堆排序(Heapsort)是指利用堆积树（相当于一个特殊的完全二叉树）这种数据结构所设计的一种排序算法，它是选择排序的一种。可以利用数组的特点快速定位指定索引的元素。堆排序就是把最大堆堆顶的最大数取出，将剩余的堆继续调整为最大堆，再次将堆顶的最大数取出，这个过程持续到剩余数只有一个时结束。
 适用场景
 堆排序在建立堆和调整堆的过程中会产生比较大的开销，在元素少的时候并不适用。但是，在元素比较多的情况下，还是不错的一个选择。尤其是在解决诸如“前n大的数”一类问题时，几乎是首选算法。
 */
- (void)heapSort:(NSMutableArray *)array {
    int last = (int)(array.count - 1);// 从最后一个节点开始 4
    // 初始化最大堆
    int parentIndex = (last - 1) / 2; // 取得last的父节点下标 1->3
    for (int i = parentIndex; i >= 0; --i) {
        [self heapAdjust:array parent:i length:last];
    }
    // 堆调整
    while (last >= 0) {
        // 元素交换,作用是去掉大顶堆
        //把大顶堆的根元素，放到数组的最后；换句话说，就是每一次的堆调整之后，都会有一个元素到达自己的最终位置
        [self swapArray:array low:0 high:last--];
        // 元素交换之后，毫无疑问，最后一个元素无需再考虑排序问题了。
        // 接下来我们需要排序的，就是已经去掉了部分元素的堆了，这也是为什么此方法放在循环里的原因
        // 而这里，实质上是自上而下，自左向右进行调整的
        [self heapAdjust:array parent:0 length:last];
    }
}
- (void)heapAdjust:(NSMutableArray *)array parent:(int)p length:(int)len {
    int leftChildIndex = 2 * p + 1; // 左子节点下标
    while (leftChildIndex <= len) {
        int r = leftChildIndex + 1;
        int j = leftChildIndex;
        if (j < len && array[leftChildIndex] < array[r]) {
            j++;
        }
        if (array[p] < array[j]) {
            [self swapArray:array low:p high:j];
            leftChildIndex = 2 * j + 1;
        } else {
            break; // 停止筛选
        }
    }
}

- (void)swapArray:(NSMutableArray *)array low:(int)l high:(int)h {
    id temp = array[l];
    array[l] = array[h];
    array[h] = temp;
}

//====== 插入
/**
 插入排序是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。
 算法描述
 把待排序的数组分成已排序和未排序两部分，初始的时候把第一个元素认为是已排好序的。
 从第二个元素开始，在已排好序的子数组中寻找到该元素合适的位置并插入该位置。
 重复上述过程直到最后一个元素被插入有序子数组中。
 适用场景
 插入排序由于O(n2)的复杂度，在数组较大的时候不适用。但是，在数据比较少的时候，是一个不错的选择，一般做为快速排序的扩充。例如，在STL的sort算法和stdlib的qsort算法中，都将插入排序作为快速排序的补充，用于少量元素的排序。又如，在JDK 7 java.util.Arrays所用的sort方法的实现中，当待排数组长度小于47时，会使用插入排序。
 */
- (void)insertionSort:(NSMutableArray *)array {
    for (int i=1; i<array.count; i++){
        // 将a[i]插入到a[i-1]，a[i-2]，a[i-3]……之中
        for(int j=i; j>0; j--) {
            if (array[j] < array[j-1]) {
                [self swapArray:array low:j-1 high:j];
            }
        }
    }
}

/**
 归并排序是建立在归并操作上的一种有效的排序算法。该算法是采用分治法的一个非常典型的应用。将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。若将两个有序表合并成一个有序表，称为二路归并。速度仅次于快速排序，为稳定排序算法。

 算法描述
 两种方法
 递归法（Top-down）
 申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
 设定两个指针，最初位置分别为两个已经排序序列的起始位置
 比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
 重复步骤3直到某一指针到达序列尾
 将另一序列剩下的所有元素直接复制到合并序列尾
 迭代法（Bottom-up）
 原理如下（假设序列共有n个元素）：
 将序列每相邻两个数字进行归并操作，形成ceil(n/2)个序列，排序后每个序列包含两/一个元素
 若此时序列数不是1个则将上述序列再次归并，形成ceil(n/4)个序列，每个序列包含四/三个元素
 重复步骤2，直到所有元素排序完毕，即序列数为1
 */
/*
- (void)mergeSort:(NSMutableArray *)array left:(int)l right:(int)r {
    if (l == r) {
        return;
    }
    int mid = l + (r - l) / 2;//(l+r)/2
    int[] leftArr = mergeSort(nums, l, mid); //左有序数组
    int[] rightArr = mergeSort(nums, mid + 1, h); //右有序数组
    int[] newNum = new int[leftArr.length + rightArr.length]; //新有序数组
    
    int m = 0, i = 0, j = 0;
    while (i < leftArr.length && j < rightArr.length) {
        newNum[m++] = leftArr[i] < rightArr[j] ? leftArr[i++] : rightArr[j++];
    }
    while (i < leftArr.length)
        newNum[m++] = leftArr[i++];
    while (j < rightArr.length)
        newNum[m++] = rightArr[j++];
    return newNum;
}
*/
@end
