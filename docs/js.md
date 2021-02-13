## Java Script cheatsheet
### Basic
Variable assignment
```js
// Old style, hoisted
var a = "Hello world!";
// New style, not hoisted
let foo = 3;
// same as let but cannot be modified
const bar = "baz";
```
Data types

Basic
```js
// Number
let a = 1; // Integer
let a1 = 1.0; // Float
// String
let b = "letters";
// Boolean
let c = false;
// Array of [Numbers]. Arrays in js is heterogeneous (can hold values of different types, so [2, true, 'Foo'] is valid array)
let d = [3, 7];
// Object (dictionary, map, hash, etc)
let e = { foo: 'Bar', baz: 4 }
console.log(e.foo); // Outputs: "Bar"
e.baz = 5; // change existing value
e.isValuable = false; // add new value under key
console.log(e.buz, e.isValuable); // Outputs: 5, false
// Function
let cube = function(base) { // Same as function cube(base) {
  return base ** 2;
}
cube(7); // Outputs: 49
```
Operations
```js
// Addition
let a = 5;
let b = 7.6;
let c = "10.2";
console.log(a + b); // Outputs: 12.6
console.log(a + c); // Outputs: "510.2" 
console.log(b + 3); // Outputs: 10.6

```

Control structures

Conditionals
```js
let isFriday = true;

if (isFriday) {
  console.log("Party hard!");
} else {
  console.log("Work hard!");
}
```
Loops
```js
// Classic c-style for loop
for (var i = 0; i < 5; i++) {
  console.log(i**2);
}
```
