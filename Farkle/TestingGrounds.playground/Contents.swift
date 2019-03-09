class Die {
    
    var name: String = ""
    var count: Int = 0
    var selected: Bool = false
}

var die1 = Die()
die1.name = "Die1"
var die2 = Die()
die2.name = "Die2"
var die3 = Die()
die3.name = "Die3"
var die4 = Die()
die4.name = "Die4"
var die5 = Die()
die5.name = "Die5"
var die6 = Die()
die6.name = "Die6"

die1.selected = true
die3.selected = true
die6.selected = true

var currentDice = [die1, die2, die3, die4, die5, die6]

for die in currentDice {
    print("current Dice: \(die.name)")
    print("is selected: \(die.selected)")
}
print(currentDice.count)
currentDice = currentDice.filter { $0.selected == false }
print(currentDice.count)

for die in currentDice {
    print("current Dice: \(die.name)")
    print("is selected: \(die.selected)")
}

