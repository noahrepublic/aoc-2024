const fs = require("fs");
const content = fs.readFileSync(
    "src/inputs/day3.txt",
    { encoding: 'utf8', flag: 'r' }
)


const regexp = /do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\)/g;
const str = 'mul(232,323)';

let ans = 0
const array = [...content.matchAll(regexp)];

let allowed = true
let yes = 0
let no = 0
let mul = 0
for (let match of array) {

    let [m] = match

    if (m == "do()") {
         allowed = true
         yes += 1
    } else if (m == "don't()") {
        allowed = false
        no += 1
    } else if (allowed) {
        mul += 1
        let [n0, n1] = m.slice(4, m.length - 1).split(',')
        n0 = parseInt(n0)
        n1 = parseInt(n1)
    
        ans += n0 * n1
    }
}

console.log(ans)
console.log(yes)
console.log(no)
console.log(mul)