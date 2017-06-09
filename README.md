# Book-Functional-Web-Dev-W-Elixir

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

## Part I — Build a Game Engine in Pure Elixir

### 2. Model State With Agents .

#### Embracing Stateful Servers

#### Agents

#### Let’s Build It

#### Model A Simple Entity

#### Model a Relationship With a List

#### Model a Relationship With a Map

#### Model Relationships With a Struct

#### A Single Representation

#### Wrapping Up

### 3. Wrap It Up In a GenServer

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

### 4. Manage State with gen_statem

#### A Bit of History

#### State Machines and :gen_statem

#### Getting Started with :gen_statem

#### Adding New Behavior

#### Fully Customizing Our State Machine

#### Integrate the :gen_statem with the GenServer

#### Seeing the GenServer and :gen_statem in Action

#### Wrapping Up

### 5. Process Supervision For Recovery

## Part II — Add a Web Interface With Phoenix

### 6. Generate a New Web Interface With Phoenix

#### Frameworks

#### OTP Applications

#### Generate a New Phoenix Application

#### Adding a New Dependency

#### Call the Logic from the Interface

#### Wrapping Up

### 7. Create Persistent Connections With Phoenix Channels

#### The Beauty of Channels

#### The Pieces That Make a Channel

#### Let’s Build It

#### Establish a Client Connection

#### Converse Over a Channel

#### Connect the Channel to the Game

#### Phoenix Presence

#### Authorization

#### Wrapping Up

## Appendix

### Testing



