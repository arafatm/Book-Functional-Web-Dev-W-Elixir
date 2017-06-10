# Book-Functional-Web-Dev-W-Elixir

https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix

Source Code: https://github.com/functional-web-dev

### 1. Mapping Our Route

#### Lay The Foundation With Elixir

Domain in native  Elixir instead of ORM

Maintain state with Agents

Interface to wrap agents in GenServer

Finite state machine to manage transition

Supervision tree for fault tolerance

#### Add a Web Interface With Phoenix

UI in Phoenix (without Ecto)

#### Functional Web Development

Functional => composition at every layer scaled to application. :w

#### The Game of Islands

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

## Part I. Define the Functional Core in Elixir

### 2. Model Data and Behavior

- model domain elements as Elixir datatypes
- define behavior as data transformation

#### The Benefits

(Web) frameworks imply a certain domain and make business domain fuzzy

DB also distorts the domain

#### Let’s Build It



#### Discover the Entities, Model the Domain

#### Transforming Data

#### Putting the Pieces Together

#### Wrapping Up

### 3. From Data To State

## Part II. Add OTP for Concurrency and Fault Tolerance

### 4. Wrap It Up In a GenServer

#### Services, A Fuller Picture

#### OTP Solutions

#### Introducing OTP Behaviours

#### Getting Started With GenServer

#### Initializing GenServer State

#### Customizing GenServer Behavior

#### Pipelines to Handle Complexity

#### Naming GenServer Processes

#### Stopping GenServer Processes

#### Wrapping Up

### 5. Manage State with gen_statem

#### A Bit of History

#### State Machines and :gen_statem

#### Getting Started with :gen_statem

#### Adding New Behavior

#### Fully Customizing Our State Machine

#### Integrate the :gen_statem with the GenServer

#### Seeing the GenServer and :gen_statem in Action

#### Wrapping Up

### 6. Process Supervision For Recovery

## Part III. Add a Web Interface With Phoenix

### 7. Generate a New Web Interface With Phoenix

#### Frameworks

#### OTP Applications

#### Generate a New Phoenix Application

#### Adding a New Dependency

#### Call the Logic from the Interface

#### Wrapping Up

### 8. Create Persistent Connections With Phoenix Channels

#### The Beauty of Channels

#### The Pieces That Make a Channel

#### Let’s Build It

#### Establish a Client Connection

#### Converse Over a Channel

#### Connect the Channel to the Game

#### Phoenix Presence

#### Authorization

#### Wrapping Up

## A1. Testing

## A2. Installing System Dependencies
