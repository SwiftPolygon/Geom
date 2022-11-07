public struct CrossResult {
    //    -2   intersection point is before segment's first point
    //    -1   intersection point is directly on segment's first point
    //     0   intersection point is between segment's first and second points (exclusive)
    //     1   intersection point is directly on segment's second point
    //     2   intersection point is after segment's second point
    
    public let a: Int
    public let b: Int
    
    public let isCross: Bool
    public let point: Point
}

public struct Geom {

    public let eps: Float
    
    public init(eps: Float = 0.00001) {
        self.eps = eps
    }

    @inlinable
    /// does a->b->c make a straight line?
    /// essentially this is just checking to see if the slope(a->b) === slope(b->c)
    /// if slopes are equal, then they must be collinear, because they share pt2
    /// - Parameters:
    ///   - a: Point a
    ///   - b: Point b
    ///   - c: Point c
    /// - Returns: ab || bc?
    public func arePointsCollinear(a: Point, b: Point, c: Point) -> Bool {
        let dx1 = a.x - b.x
        let dy1 = a.y - b.y
        let dx2 = b.x - c.x
        let dy2 = b.y - c.y
        
        return abs(dx1 * dy2 - dx2 * dy1) < eps
    }
    
    /// Are two sements crossing
    /// - Parameters:
    ///   - a0: first segment start
    ///   - a1: first segment end
    ///   - b0: second segment start
    ///   - b1: second segment end
    /// - Returns: cross result
    public func isCross(a0: Point, a1: Point, b0: Point, b1: Point) -> CrossResult {
        let adx = a1.x - a0.x
        let ady = a1.y - a0.y
        let bdx = b1.x - b0.x
        let bdy = b1.y - b0.y

        let axb = adx * bdy - ady * bdx
        guard abs(axb) >= eps else {
            return CrossResult(a: 0, b: 0, isCross: false, point: .zero) // lines are coincident
        }
            

        let dx = a0.x - b0.x
        let dy = a0.y - b0.y

        let A = (bdx * dy - bdy * dx) / axb
        let B = (adx * dy - ady * dx) / axb

        let pt = Point(
            x: a0.x + A * adx,
            y: a0.y + A * ady
        )

        // categorize where intersection point is along A and B

        let a: Int
        
        if A <= -eps {
            a = -2
        } else if A < eps {
            a = -1
        } else if (A - 1 <= -eps) {
            a = 0
        } else if (A - 1 < eps) {
            a = 1
        } else {
            a = 2
        }

        let b: Int
        
        if B <= -eps {
            b = -2
        } else if B < eps {
            b = -1
        } else if B - 1 <= -eps {
            b = 0
        } else if (B - 1 < eps) {
            b = 1
        } else {
            b = 2
        }

        return CrossResult(a: a, b: b, isCross: true, point: pt)
    }

    @inlinable
    func isInsideRegion(point pt: Point, region: [Point]) -> Bool {
        let x = pt.x
        let y = pt.y
        
        var p1 = region[region.count - 1]
        
        var inside = false
        for p0 in region {
            // if y is between curr_y and last_y, and
            // x is to the right of the boundary created by the line
            if ((p0.y - y > eps) != (p1.y - y > eps) && (p1.x - p0.x) * (y - p0.y) / (p1.y - p0.y) + p0.x - x > eps) {
                inside = !inside
            }

            p1 = p0
        }
        
        return inside
    }
    
}
