# Book-Functional-Web-Dev-W-Elixir

https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix

[Original Source Code from Author](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/2371009)

[To setup Continuous testing with mix_test_watch](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/e404877)

## 0 Mapping Our Route

### Lay The Foundation With Elixir

Domain in native  Elixir instead of ORM

Maintain state with Agents

Interface to wrap agents in GenServer

Finite state machine to manage transition

Supervision tree for fault tolerance

### Add a Web Interface With Phoenix

UI in Phoenix (without Ecto)

### Functional Web Development

Functional => composition at every layer scaled to application. :w

### The Game of Islands

Similar to Battleship
- 10x10 grid: A-J, 1-10
- player sets islands
- other player "forests" island by guessing location
- winner forests all opponents islands

		C = Coordinate		I = Island
		%{} = Map					%A{} = Struct		[] = List

									Game --> State Machine
									/  \
							 	 /    \
								P1		P2

		Player --> Board %{C,C,C,..}
		       --> Island Set %IslandSet{I,I,I,I,I}

		I --> [C...][C...]...

## 1 Define the Functional Core in Elixir

### The Benefits

(Web) frameworks imply a certain domain and make business domain fuzzy

DB also distorts the domain

### Let’s Build It

[$ mix new islands_engine --sup](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/f32bc8c)

`mix new` create skeleton
```
$ tree
  .
  ├── README.md
  ├── config
  │   └── config.exs
  ├── lib
  │   ├── islands_engine
  │   │   └── application.ex
  │   └── islands_engine.ex
  ├── mix.exs
  └── test
      ├── islands_engine_test.exs
      └── test_helper.exs
```

### Discover the Entities, Model the Domain

- Players need to be able to position islands on their own boards.
- Players need to be able to guess coordinates on their opponent’s boards.
- The game needs to determine if a guess results in a hit or a miss.
- The game needs to determine if a guess results in a forested island.
- The game needs to determine if a guess results in a win.

#### Coordinates

3 data struct options:
- tuple `{1, 1}` but cannot be encoded as JSON
- map `%{row: 1, col: 1}`
- structs are like maps but they offer compile time checks on keys and runtime 
  checks on type

[Initial Coordinate module](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/20e75eb)
- [alias Coordinate](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/27709c4)
- [defstruct :row, :col  with @enforce_keys to ensure both attributes are present](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/38ef880)
- [Coordinate.new with row/col validation they are within 1..10](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/351c021)

[CoordinateTest](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/496da46)

`$ iex -S mix` to play with Coordinate

```elixir
iex(2)> alias IslandsEngine.Coordinate
IslandsEngine.Coordinate

iex(3)> Coordinate.new(1, 1)
{:ok, %IslandsEngine.Coordinate{col: 1, row: 1}}

iex(4)> Coordinate.new(-1, 1)
{:error, :invalid_coordinate}

iex(5)> %Coordinate{row: 5}
** (ArgumentError) the following keys must also be given when building struct IslandsEngine.Coordinate: [:col]
   (islands_engine) expanding struct: IslandsEngine.Coordinate.__struct__/1
                             iex:5: (file)
```

#### Guesses

Guess == :hits + :misses

Use [MapSet](https://hexdocs.pm/elixir/MapSet.html) to ensure uniqueness

[IslandsEngine.Guesses](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/c01c20a)

#### Islands

Islands
- come in five different shapes, `:atoll`, `:dot`, `:l_shape`, `:s_shape`, and `:square`.
- made up of group of coordinates
- determine if island is forested

List comparison:
- `[1,2] == [2,1]` is false
-  `MapSet.equal?(MapSet.new([1, 2]), MapSet.new([2, 1]))` is true

[IslandsEngine.Island](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/d7217ec)

Islands can be thought of as an origin coordinate with offsets.

e.g. `:square` = `Origin{row,col} + Offset{1,0} + Offset{0,1} + Offset{1,1}`

We can use [Enum.reduce/2](https://hexdocs.pm/elixir/Enum.html#reduce/2) to 
iterate over the offsets in building the island

:boom: We have to check that the offsets are valid, better is 
[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)

[IslandsEngine.Island create Islands with defined shapes](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/12efc40)

#### Boards

[IslandsEngine.Board](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/6e2ff84)
is simple. For now just return empty map
- will hold player islands
- broker messages
- check forests
- etc

### Transforming Data

#### Guesses

- track guesses. don't need to remove them, only write
- add guessed coord to Guesses map
- ^ calculate if hit or miss

[IslandsEngine.Guesses add :hit or :miss](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/a9d41ae)

#### Island

3 roles:
1. positioning islands
2. guessing coordinates
3. checking for a forested island.

Need to check for overlaps when placing islands. We can use
[MapSet.disjoint/2](https://hexdocs.pm/elixir/MapSet.html#disjoint?/2)

[Island.overlap?](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/6b5902f)

Next we use [MapSet.member?/2](https://hexdocs.pm/elixir/MapSet.html#member?/2)
to check if a coordinate is a member of a set

[Island.guess(island, coordinate)](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/6eb0dd9)

Check if [Island.forested?(island)](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/fff2b61)

Add a function to return list of valid island types

Check that we can get [Island.types](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/bab1b7c)

#### Board

Board roles:
- knows about and addresses all islands
- delegate function calls to islands

[Board.overlaps_existing_island?](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/cb7061e)

[Board.all_islands_positioned?](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/736c2c3)

Use [Enum.find_value/3](https://hexdocs.pm/elixir/Enum.html#find_value/3) to
find a hit island based on coordinate. Otherwise return `:miss`

[Board.check_all_islands(board, coordinate)](https://github.com/arafatm/Book-Functional-Web-Dev-W-Elixir/commit/e93d0b9)


### Putting the Pieces Together
### Wrapping Up
## 2 Add OTP for Concurrency and Fault Tolerance
### Services, A Fuller Picture
### OTP Solutions
### Introducing OTP Behaviours
### Getting Started With GenServer
### Initializing GenServer State
### Customizing GenServer Behavior
### Pipelines to Handle Complexity
### Naming GenServer Processes
### Stopping GenServer Processes
### Wrapping Up
### A Bit of History
### State Machines and :gen_statem
### Getting Started with :gen _statem
### Adding New Behavior
### Fully Customizing Our State Machine
### Integrate the :gen_statem with the GenServer
### Seeing the GenServer and :gen_statem in Action
### Wrapping Up
## 3 Add a Web Interface With Phoenix
### Frameworks
### OTP Applications
### Generate a New Phoenix Application
### Adding a New Dependency
### Call the Logic from the Interface
### Wrapping Up
### The Beauty of Channels
### The Pieces That Make a Channel
### Lets Build It
### Establish a Client Connection
### Converse Over a Channel
### Connect the Channel to the Game
### Phoenix Presence
### Authorization
### Wrapping Up
## Appendix 1: Testing
## Appendix 2: Installing System Dependencies
