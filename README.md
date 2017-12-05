# A multiplayer game in WebVR

![Game](https://i.imgur.com/rF49zyF.jpg)

#### 1. Install NodeJS & npm
    sudo apt-get update
    sudo apt-get install nodejs
    sudo apt-get install nodejs-legacy 
    sudo apt-get install npm
    sudo apt-get install curl
  
#### 2. Install Crystal
    curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash 
    sudo apt-get install crystal

#### 3. Install Elm & Webpack
    sudo npm install -g elm 
    sudo npm install -g webpack

#### 4. Install npm libraries & shards
    npm install
    shards install

#### 5. Set envorinmental variables
    cp .env-example .env

#### 6. Run the game
    npm start
    open http://localhost:3000
