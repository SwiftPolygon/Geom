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
    
    public init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
    
}

public extension Geom {

    @inlinable
    func isEqual(a: Point, b: Point) -> Bool {
        let sameX = abs(a.x - b.x) < eps
        let sameY = abs(a.y - b.y) < eps
        return sameX && sameY
    }
}
