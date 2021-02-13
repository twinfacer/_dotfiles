### regexp
Regular expressions (aka __regexp's__) is powerful tool for text analysis/text manipulation.
Common examples are checking text for specific _pattern_ or replacing one with another.

Regexp commonly written as
```ruby
/<regexp-body>/[<flags,>]
```
regexp body is bread and butter of regexp.
``` 

flags are optional
- i - Case insensitive, means
```ruby
/hype/ == /HyPe/
```

```javascript
// lang:js

// replace takes string|regexp and a string|function as arguments.
"Hello world!".replace(/hello/i, "Goodbye")
=> "Goodbye world!"
```
