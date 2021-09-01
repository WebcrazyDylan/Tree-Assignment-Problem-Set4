//
//  main.swift
//  Tree Assignment-Problem-Set4
//
//  Created by Dylan Park on 2021-08-15.
//

import Foundation

// Who’s my parent?
func findMyParent() {
    print("Please input tree for Who’s my parent")
    var parents = [Int:Int]()
    var alreadyExist = [Int:Bool]()
    let preN = readLine()!.split(separator: " ").map { Int($0) }
    let n = preN[0]!
    alreadyExist[1] = true
    for i in 2...n {
        alreadyExist[i] = false
    }
    
    for _ in 0..<n-1 {
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        if alreadyExist[nodeInfo[0]!] == false {
            parents[nodeInfo[0]!] = nodeInfo[1]
            alreadyExist[nodeInfo[0]!] = true
        }
        if alreadyExist[nodeInfo[1]!] == false {
            parents[nodeInfo[1]!] = nodeInfo[0]
            alreadyExist[nodeInfo[1]!] = true
        }
    }
    print("Output")
    for i in 2...n {
        print(parents[i]!)
    }
}


// Diameter
var alreadyPassed = [Int:Bool]()
var tempDistance: Int = 0
var longestDistanceValue: Int = 0

func longestDistance() {
    print("Please input tree for Diameter")
    var distanceArray: [Dictionary<Int, Int>] = []
    var distance = [Int:Int]()
    var paths = [Int:[Dictionary<Int, Int>]]()
    
    let preN = readLine()!.split(separator: " ").map { Int($0) }
    let n = preN[0]!
    for i in 1...n {
        alreadyPassed[i] = false
    }
    for _ in 0..<n {
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        var oddIndex = 1
        var evenIndex = 2
        while nodeInfo[oddIndex] != -1 {
            distance[nodeInfo[oddIndex]!] = nodeInfo[evenIndex]
            distanceArray.append(distance)
            distance.removeAll()
            oddIndex += 2
            evenIndex += 2
        }
        paths[nodeInfo[0]!] = distanceArray
        distanceArray.removeAll()
    }
    
    for i in 1...n {
        diameterHelper(startPoint: i, paths: paths)
        tempDistance = 0
        for i in 1...n {
            alreadyPassed[i] = false
        }
    }
    print("Output \(longestDistanceValue)")
}


func diameterHelper(startPoint: Int, paths: [Int:[Dictionary<Int, Int>]]) {
    alreadyPassed[startPoint] = true
    var nextPoints = [Int]()
    var distanceOfCurrentPath = 0
    for eachDic in paths[startPoint]! {
        nextPoints.append(eachDic.keys.first!)
    }
    if isEndPoint(intArray: nextPoints) {
        if tempDistance > longestDistanceValue {
            longestDistanceValue = tempDistance
        }
    }
    
    // iterate possible nodes from one node
    for eachDic in paths[startPoint]! {
        if !alreadyPassed[eachDic.keys.first!]! {
            // the distance of the current choice
            distanceOfCurrentPath = eachDic.values.first!
            tempDistance += distanceOfCurrentPath
            diameterHelper(startPoint: eachDic.keys.first!, paths: paths)
            // before proceed to other choces, subtract the distance of the current choice
            tempDistance -= distanceOfCurrentPath
            
        }
    }
    
}

func isEndPoint(intArray: [Int]) -> Bool {
    for i in intArray {
        if alreadyPassed[i] == false {
            return false
        }
    }
    return true
}



print("Who’s my parent?")
findMyParent()
/*
Sample Input1
7
1 6
6 3
3 5
4 1
2 4
4 7
Sample Output1
4
6
1
3
1
4
*/



print("Diameter")
longestDistance()

/*
 Sample Input1
 5
 1 3 2 -1
 2 4 4 -1
 3 1 2 4 3 -1
 4 2 4 3 3 5 6 -1
 5 4 6 -1
 Sample Output1
 11
 */



