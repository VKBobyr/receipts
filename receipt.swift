import Foundation

struct Item {
    let name: String
    let price: Double
    var portion = 1

    var total: Double {
        price * (1 / Double(portion))
    }

    // override division
    static func / (lhs: Item, rhs: Int) -> Item {
        var result = lhs
        result.portion = result.portion * rhs
        return result
    }
}

extension Item: CustomStringConvertible {
    var description: String {
        let portion = portion == 1 ? "" : "1/\(portion) "
        return "\(portion)\(name): \(total.asPrice)"
    }
}

extension Double {
    var asPrice: String {
        String(format: "$%.2f", self)
    }
}

struct Payer {
    let name: String
    let items: [Item]

    var total: Double {
        items.reduce(0) { $0 + $1.total }
    }

    func printReceipt() {
        let itemReceipt = items.map(\.description).joined(separator: "\n")
        let tax = total * 0.102
        let tip = total * 0.2

        let receipt = """
        =============================
        
        # \(name)

        ## Items:
        \(itemReceipt)

        ## Subtotal: \(total.asPrice)
        ## Tax (10.2%): \(tax.asPrice)
        ## Tip (20%): \(tip.asPrice)

        ## Total: 
        \((total + tax + tip).asPrice)

-
        """

        print(receipt)
    }
}

let takoyaki = Item(name: "Takoyaki", price: 8)
let sushiDinner = Item(name: "Deluxe Sushi Dinner", price: 28)
let salmonKing = Item(name: "Salmon King", price: 17)
let salmonLover = Item(name: "Salmon Lover", price: 17)
let tonkotsuRamen = Item(name: "Tonkotsu Ramen", price: 16)
let prawnRamen = Item(name: "Prawn Ramen", price: 22)
let blueFinTuna = Item(name: "Blue Fin Tuna", price: 9.50)
let crispyCalamari = Item(name: "Crispy Calamari", price: 11)
let teaPot = Item(name: "Tea Pot", price: 5)

let alan = Payer(
    name: "Alan",
    items: [
        crispyCalamari / 4,
        takoyaki / 4,
        blueFinTuna,
        prawnRamen,
        teaPot / 4,
    ]
)

let andrew = Payer(
    name: "Andrew",
    items: [
        tonkotsuRamen,
        teaPot / 4,
        takoyaki / 4,
        salmonKing,
    ]
)

let kristinVova = Payer(
    name: "Kristin & Vova",
    items: [
        sushiDinner,
        salmonKing,
        takoyaki / 2,
        teaPot / 2,
        salmonLover,
    ]
)

alan.printReceipt()
kristinVova.printReceipt()
andrew.printReceipt()
