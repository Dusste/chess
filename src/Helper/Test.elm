module Helper.Test exposing (..)

import Types


opponentPositions : List Types.FigureState
opponentPositions =
    [ ( Types.Opponent, { figure = Types.Rook, moves = [ { x = 1, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Rook, moves = [ { x = 8, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 1, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 2, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 3, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 4, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 5, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 6, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 7, y = 7 } ] } )
    , ( Types.Opponent, { figure = Types.Pawn, moves = [ { x = 8, y = 2 } ] } )
    , ( Types.Opponent, { figure = Types.Knight, moves = [ { x = 2, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Knight, moves = [ { x = 7, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Bishop, moves = [ { x = 3, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Bishop, moves = [ { x = 6, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.King, moves = [ { x = 5, y = 1 } ] } )
    , ( Types.Opponent, { figure = Types.Queen, moves = [ { x = 4, y = 1 } ] } )
    ]



-- QUEEN starts


queenPossitionsTest1 : List Types.FigureState
queenPossitionsTest1 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


queenExpectedTestUnit1 : Types.NextMoves
queenExpectedTestUnit1 =
    { potentialCaptures = [ { x = 8, y = 2 }, { x = 7, y = 7 }, { x = 2, y = 2 } ]
    , potentialMoves =
        [ { x = 5, y = 4 }
        , { x = 4, y = 5 }
        , { x = 3, y = 5 }
        , { x = 2, y = 5 }
        , { x = 1, y = 5 }
        , { x = 6, y = 5 }
        , { x = 6, y = 4 }
        , { x = 7, y = 3 }
        , { x = 6, y = 6 }
        , { x = 4, y = 4 }
        , { x = 3, y = 3 }
        , { x = 4, y = 6 }
        , { x = 3, y = 7 }
        , { x = 2, y = 8 }
        ]
    }


queenPossitionsTest2 : List Types.FigureState
queenPossitionsTest2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 2, y = 8 } ] } )
    ]


queenExpectedTestUnit2 : Types.NextMoves
queenExpectedTestUnit2 =
    { potentialCaptures =
        [ { x = 2, y = 2 }
        , { x = 8, y = 2 }
        ]
    , potentialMoves =
        [ { x = 2, y = 7 }
        , { x = 2, y = 6 }
        , { x = 2, y = 5 }
        , { x = 2, y = 4 }
        , { x = 2, y = 3 }
        , { x = 1, y = 8 }
        , { x = 3, y = 8 }
        , { x = 4, y = 8 }
        , { x = 5, y = 8 }
        , { x = 3, y = 7 }
        , { x = 4, y = 6 }
        , { x = 5, y = 5 }
        , { x = 6, y = 4 }
        , { x = 7, y = 3 }
        , { x = 1, y = 7 }
        ]
    }


queenPossitionsTest3 : List Types.FigureState
queenPossitionsTest3 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 7, y = 3 } ] } )
    ]


queenExpectedTestUnit3 : Types.NextMoves
queenExpectedTestUnit3 =
    { potentialCaptures =
        [ { x = 7, y = 1 }
        , { x = 8, y = 2 }
        , { x = 6, y = 2 }
        ]
    , potentialMoves =
        [ { x = 7, y = 2 }
        , { x = 6, y = 3 }
        , { x = 8, y = 4 }
        , { x = 6, y = 4 }
        , { x = 5, y = 5 }
        , { x = 4, y = 6 }
        , { x = 3, y = 7 }
        , { x = 2, y = 8 }
        ]
    }



-- QUEEN ends
-- KING start


kingPossitionsTest1 : List Types.FigureState
kingPossitionsTest1 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


kingExpectedTestUnit1 : Types.NextMoves
kingExpectedTestUnit1 =
    { potentialCaptures = []
    , potentialMoves =
        [ { x = 5, y = 7 }
        , { x = 4, y = 6 }
        , { x = 6, y = 6 }
        , { x = 6, y = 7 }
        , { x = 4, y = 5 }
        , { x = 6, y = 5 }
        ]
    }


kingPossitionsTest2 : List Types.FigureState
kingPossitionsTest2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 6, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 2, y = 8 } ] } )
    ]


kingExpectedTestUnit2 : Types.NextMoves
kingExpectedTestUnit2 =
    { potentialCaptures =
        [ { x = 5, y = 2 }
        , { x = 6, y = 2 }
        ]
    , potentialMoves =
        [ { x = 6, y = 4 }
        , { x = 7, y = 3 }
        , { x = 7, y = 2 }
        , { x = 5, y = 4 }
        ]
    }


kingPossitionsTest3 : List Types.FigureState
kingPossitionsTest3 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 1, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 7, y = 3 } ] } )
    ]


kingExpectedTestUnit3 : Types.NextMoves
kingExpectedTestUnit3 =
    { potentialCaptures =
        [ { x = 1, y = 2 }, { x = 2, y = 2 } ]
    , potentialMoves =
        [ { x = 0, y = 3 }
        , { x = 2, y = 3 }
        , { x = 2, y = 4 }
        , { x = 0, y = 2 }
        , { x = 0, y = 4 }
        ]
    }



-- KING ends
-- ROOK starts


rookPossitionsTest1 : List Types.FigureState
rookPossitionsTest1 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


rookExpectedTestUnit1 : Types.NextMoves
rookExpectedTestUnit1 =
    { potentialCaptures =
        [ { x = 7, y = 7 } ]
    , potentialMoves =
        [ { x = 4, y = 6 }
        , { x = 4, y = 5 }
        , { x = 4, y = 4 }
        , { x = 4, y = 8 }
        , { x = 3, y = 7 }
        , { x = 2, y = 7 }
        , { x = 1, y = 7 }
        , { x = 5, y = 7 }
        , { x = 6, y = 7 }
        ]
    }


rookPossitionsTest2 : List Types.FigureState
rookPossitionsTest2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


rookExpectedTestUnit2 : Types.NextMoves
rookExpectedTestUnit2 =
    { potentialCaptures = [ { x = 6, y = 2 } ]
    , potentialMoves =
        [ { x = 6, y = 3 }
        , { x = 6, y = 5 }
        , { x = 6, y = 6 }
        , { x = 6, y = 7 }
        , { x = 5, y = 4 }
        , { x = 4, y = 4 }
        ]
    }


rookPossitionsTest3 : List Types.FigureState
rookPossitionsTest3 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


rookExpectedTestUnit3 : Types.NextMoves
rookExpectedTestUnit3 =
    { potentialCaptures = []
    , potentialMoves =
        [ { x = 1, y = 7 }
        , { x = 2, y = 8 }
        , { x = 3, y = 8 }
        , { x = 4, y = 8 }
        , { x = 5, y = 8 }
        ]
    }



-- ROOK ends
-- KNIGHT starts


knightPossitionsTest1 : List Types.FigureState
knightPossitionsTest1 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 6, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


knightExpectedTestUnit1 : Types.NextMoves
knightExpectedTestUnit1 =
    { potentialCaptures = []
    , potentialMoves =
        [ { x = 7, y = 9 }
        , { x = 5, y = 9 }
        , { x = 4, y = 6 }
        , { x = 4, y = 8 }
        , { x = 8, y = 6 }
        , { x = 8, y = 8 }
        ]
    }


knightPossitionsTest2 : List Types.FigureState
knightPossitionsTest2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 5, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


knightExpectedTestUnit2 : Types.NextMoves
knightExpectedTestUnit2 =
    { potentialCaptures = [ { x = 4, y = 2 }, { x = 6, y = 2 } ]
    , potentialMoves =
        [ { x = 6, y = 6 }
        , { x = 4, y = 6 }
        , { x = 3, y = 3 }
        , { x = 3, y = 5 }
        , { x = 7, y = 3 }
        ]
    }


knightPossitionsTest3 : List Types.FigureState
knightPossitionsTest3 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 3, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


knightExpectedTestUnit3 : Types.NextMoves
knightExpectedTestUnit3 =
    { potentialCaptures =
        [ { x = 1, y = 2 }
        , { x = 5, y = 2 }
        , { x = 2, y = 1 }
        , { x = 4, y = 1 }
        ]
    , potentialMoves =
        [ { x = 4, y = 5 }
        , { x = 2, y = 5 }
        , { x = 5, y = 4 }
        ]
    }



-- KNIGHT ends
-- BISHOP start


bishopPossitionsTest1 : List Types.FigureState
bishopPossitionsTest1 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 4, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 6, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


bishopExpectedTestUnit1 : Types.NextMoves
bishopExpectedTestUnit1 =
    { potentialCaptures =
        [ { x = 8, y = 1 }
        , { x = 1, y = 2 }
        ]
    , potentialMoves =
        [ { x = 5, y = 4 }
        , { x = 6, y = 3 }
        , { x = 7, y = 2 }
        , { x = 3, y = 4 }
        , { x = 2, y = 3 }
        ]
    }


bishopPossitionsTest2 : List Types.FigureState
bishopPossitionsTest2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 5, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 6, y = 3 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


bishopExpectedTestUnit2 : Types.NextMoves
bishopExpectedTestUnit2 =
    { potentialCaptures =
        [ { x = 8, y = 1 }
        , { x = 5, y = 2 }
        ]
    , potentialMoves =
        [ { x = 7, y = 2 }
        ]
    }


bishopPossitionsTest3 : List Types.FigureState
bishopPossitionsTest3 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 2, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 3, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


bishopExpectedTestUnit3 : Types.NextMoves
bishopExpectedTestUnit3 =
    { potentialCaptures =
        [ { x = 3, y = 2 }
        , { x = 1, y = 2 }
        ]
    , potentialMoves =
        [ { x = 3, y = 4 }
        , { x = 4, y = 5 }
        ]
    }



-- BISHOP ends
-- PAWN start


pawnPossitionsTest1 : List Types.FigureState
pawnPossitionsTest1 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 4, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 6, y = 7 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


pawnExpectedTestUnit1 : Types.NextMoves
pawnExpectedTestUnit1 =
    { potentialCaptures = [], potentialMoves = [ { x = 7, y = 3 } ] }


pawnPossitionsTest2 : List Types.FigureState
pawnPossitionsTest2 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 5, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 6, y = 3 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


pawnExpectedTestUnit2 : Types.NextMoves
pawnExpectedTestUnit2 =
    { potentialCaptures = [ { x = 8, y = 2 }, { x = 6, y = 2 } ], potentialMoves = [ { x = 7, y = 2 } ] }


pawnPossitionsTest3 : List Types.FigureState
pawnPossitionsTest3 =
    [ ( Types.Me, { figure = Types.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 7, y = 2 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 2, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Knight, moves = [ { x = 3, y = 3 } ] } )
    , ( Types.Me, { figure = Types.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Types.Me, { figure = Types.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Types.Me, { figure = Types.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


pawnExpectedTestUnit3 : Types.NextMoves
pawnExpectedTestUnit3 =
    { potentialCaptures = [ { x = 6, y = 1 }, { x = 8, y = 1 } ], potentialMoves = [] }



-- PAWN ends
