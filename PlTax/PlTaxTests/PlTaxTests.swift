import XCTest
@testable import PlTax

class PlTaxTests: XCTestCase {
    
    var viewControler: ViewController!
    
    override func setUp() {
        super.setUp()
        self.viewControler = ViewController()
    }
    
    override func tearDown() {
        self.viewControler = nil
        super.tearDown()
    }
    
    func testOne() {
        let strRevenue = String(5000.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 45.0)
        
    }
    
    func testTwo() {
        let strRevenue = String(8000.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 345.0)
    }
    
    func testThree() {
        let strRevenue = String(12500.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 1245.0)
    }
    
    func testFour() {
        let strRevenue = String(38500.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 7745.0)
    }
    
    func testFive() {
        let strRevenue = String(58500.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 13745.0)
    }
    
    func testSix() {
        let strRevenue = String(83500.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 22495.0)
    }
    
    func testSeven() {
        let strRevenue = String(103500.0)
        let strTax = self.viewControler.calculate(revenue: strRevenue)
        XCTAssertEqual(Double(strTax), 31495.0)
    }
}
