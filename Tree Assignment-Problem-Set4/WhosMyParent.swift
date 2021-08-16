//
//  WhosMyParent.swift
//  Tree Assignment-Problem-Set4
//
//  Created by Dylan Park on 2021-08-15.
//

import Foundation

func whosMyParent() {
  let n = Int(readLine()!)!
  var adj = [[Int]](repeating: [], count: n + 1)
  var visited = [Bool](repeating: false, count: n + 1)
  var parent = [Int](repeating: 0, count: n + 1)
  
  for _ in 0..<n-1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    adj[u].append(v)
    adj[v].append(u)
  }
  
  let q = Queue<Int>()
  q.enqueue(item: 1)  // root
  visited[1] = true
  while !q.isEmpty() {
    let u = q.dequeue()!
    for v in adj[u] {
      if !visited[v] {
        visited[v] = true
        parent[v] = u
        q.enqueue(item: v)
      }
    }
  }
  
  for i in 2...n {
    print(parent[i])
  }
}
