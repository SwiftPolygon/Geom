//
//  Point.swift
//  
//
//  Created by Nail Sharipov on 02.11.2022.
//

public struct Point {
    
    public static let zero = Point(x: 0, y: 0)
    
    public let x: Float
    public let y: Float
    
}

public extension Geom {

    @inlinable
    func isEqual(a: Point, b: Point) -> Bool {
        (abs(a.x - b.y) < eps) && abs(a.y - b.y) < eps
    }
}
