import 'package:flutter/material.dart';
import 'dart:ui';
class CreateGame extends StatefulWidget {
 

 @override
 State<CreateGame> createState()=> _CreateGameState();
}


class _CreateGameState extends State<CreateGame>{

    static const String PLAYER_X = "X";
    static const String PLAYER_Y = "O";
    
    late String currentPlayer;
    late bool endGame;
    late List<String> occupied;

    @override
    void initState(){
        startGame();
        super.initState();
    }



    void startGame(){
        currentPlayer=PLAYER_X;
        endGame=false;
        occupied=["","","","","","","","",""];
                
    }
    
    



    @override
    Widget build(BuildContext context){
        return Scaffold(
            body:Center(
                child: Column(
                  
                    
                    mainAxisAlignment: MainAxisAlignment.center,                    
                   
                    children:[
                        _header_(),
                        _container_(),
                        _restartButton_(),

                    ],
                ),
            ),
        );

    }
    _restartButton_() {
        return ElevatedButton(
            onPressed: () {
            setState(() {
                startGame();
            });
            },
            child: const Text("Restart Game"));
  }
    Widget _header_(){
        return Column(
            children: [
                    const Text(
                        "Jogo da Velha", 
                        style: TextStyle
                        (
                            color: Colors.white,
                            
                            fontSize:32,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                Text(
                    "$currentPlayer turn",
                    style: const TextStyle(
                        color:   Colors.white,
                        fontSize:32,
                        fontWeight: FontWeight.bold,

                    ),
                ),
            ],
        );
    }
    Widget _container_(){
        return Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.height/2,
            
            margin:const EdgeInsets.all(8),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
                itemCount: 9,
             itemBuilder: (context, int index){
              return _box_(index);
            }),

        );

    }
    Widget _box_(int index){
        return InkWell(
            onTap: (){
                if(endGame||occupied[index].isNotEmpty){
                    return;
                }
                setState((){
                    occupied[index] = currentPlayer;
                    changeTurn();
                    checkForWinner();
                    checkForDraw();

                });
            },
            child:Container(
                
                color: occupied[index].isEmpty
                    ? Colors.black26
                    : occupied[index] == PLAYER_X
                        ? const Color(0xFF6200EA)
                        : Color(0xFF004D40),
                margin: const EdgeInsets.all(8),
                child: Center(
                    child: Text(
                        occupied[index],
                        style: const TextStyle(
                            fontSize: 50,
                            color:Colors.white,

                        ),
                    ),
                ),
                
            ),
        );
        

    }
    changeTurn(){
        if(currentPlayer == PLAYER_X) {
            currentPlayer = PLAYER_Y;
        }else{
            currentPlayer = PLAYER_X;
        }
    }

    checkForWinner() 
    {
        List<List<int>>winnerList = [
            [0,1,2],
            [3,4,5],
            [6,7,8],
            [0,3,6],
            [1,4,7],
            [2,5,8],
            [0,4,8],
            [2,4,6],

        ];
            for(var winningPosition in winnerList) {
                String playerPos0 = occupied[winningPosition[0]];
                String playerPos1 = occupied[winningPosition[1]];
                String playerPos2= occupied[winningPosition[2]];
            
            if(playerPos0.isNotEmpty)
            {   if(playerPos0 == playerPos1 &&
                playerPos0 == playerPos2) 
                {
                    showGameOverMessage("Player $playerPos0 won");
                    endGame = true;
                    return;
                }
            }
        }
    }
    checkForDraw() {
        if(endGame){
            return;

        }
        bool draw = true;
        for(var occupiedPlayer in occupied){
            if(occupiedPlayer.isEmpty){
                draw=false;
            }
        }
        if(draw){
            showGameOverMessage("Draw");
            endGame=true;
        }
    }
    showGameOverMessage(String message){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
          backgroundColor:Color(0xFF2979FF),
          content: Text(
            "Game Over \n $message",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          )),
        );
    }
}

    

