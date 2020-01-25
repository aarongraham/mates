## Mates

A novelty project used to decide how the days pairs will be assigned. 
The project is in no way useful to anybody outside the group of people that I work with, and honestly, hardly useful to them either. 

Pull requests welcome. 

### Running the app locally
```
asdf install
mix deps.get
npm i --prefix assets

iex -S mix phx.server
```

[http://localhost:4000]()

### Running locally in docker
Scripts to create releases and run in docker can be found in the bin folder

### Running the tests
Sorry, there are none 😲

### Adding new shuffle algorithms
The important function can be found at `Mates.Devs.shuffle/1` this could be re-written to do something more interesting. 
It accepts an enumerable of Dev structs and should return an enumerable of Dev structs, in any order, but with their position attribute updated. 
The front end will then render each person using the position, grouping them from left to right, i.e. \[0 1] \[2 3] \[4 5]
