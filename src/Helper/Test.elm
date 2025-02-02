module Helper.Test exposing (..)

import Chess


opponentPositions : List Chess.FigureState
opponentPositions =
    [ ( Chess.Opponent, { figure = Chess.Rook, moves = [ { x = 1, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.Rook, moves = [ { x = 8, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 1, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 2, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 3, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 4, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 5, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 6, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 7, y = 7 } ] } )
    , ( Chess.Opponent, { figure = Chess.Pawn, moves = [ { x = 8, y = 2 } ] } )
    , ( Chess.Opponent, { figure = Chess.Knight, moves = [ { x = 2, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.Knight, moves = [ { x = 7, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.Bishop, moves = [ { x = 3, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.Bishop, moves = [ { x = 6, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.King, moves = [ { x = 5, y = 1 } ] } )
    , ( Chess.Opponent, { figure = Chess.Queen, moves = [ { x = 4, y = 1 } ] } )
    ]



-- QUEEN starts


queenPossitionsTest1 : List Chess.FigureState
queenPossitionsTest1 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


queenExpectedTestUnit1 : Chess.NextMoves
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


queenPossitionsTest2 : List Chess.FigureState
queenPossitionsTest2 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 2, y = 8 } ] } )
    ]


queenExpectedTestUnit2 : Chess.NextMoves
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


queenPossitionsTest3 : List Chess.FigureState
queenPossitionsTest3 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 7, y = 3 } ] } )
    ]


queenExpectedTestUnit3 : Chess.NextMoves
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


kingPossitionsTest1 : List Chess.FigureState
kingPossitionsTest1 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


kingExpectedTestUnit1 : Chess.NextMoves
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


kingPossitionsTest2 : List Chess.FigureState
kingPossitionsTest2 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 6, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 2, y = 8 } ] } )
    ]


kingExpectedTestUnit2 : Chess.NextMoves
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


kingPossitionsTest3 : List Chess.FigureState
kingPossitionsTest3 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 1, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 7, y = 3 } ] } )
    ]


kingExpectedTestUnit3 : Chess.NextMoves
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


rookPossitionsTest1 : List Chess.FigureState
rookPossitionsTest1 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


rookExpectedTestUnit1 : Chess.NextMoves
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


rookPossitionsTest2 : List Chess.FigureState
rookPossitionsTest2 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


rookExpectedTestUnit2 : Chess.NextMoves
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


rookPossitionsTest3 : List Chess.FigureState
rookPossitionsTest3 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 8, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


rookExpectedTestUnit3 : Chess.NextMoves
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


knightPossitionsTest1 : List Chess.FigureState
knightPossitionsTest1 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 6, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


knightExpectedTestUnit1 : Chess.NextMoves
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


knightPossitionsTest2 : List Chess.FigureState
knightPossitionsTest2 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 5, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


knightExpectedTestUnit2 : Chess.NextMoves
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


knightPossitionsTest3 : List Chess.FigureState
knightPossitionsTest3 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 3, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


knightExpectedTestUnit3 : Chess.NextMoves
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


bishopPossitionsTest1 : List Chess.FigureState
bishopPossitionsTest1 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 4, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 6, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


bishopExpectedTestUnit1 : Chess.NextMoves
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


bishopPossitionsTest2 : List Chess.FigureState
bishopPossitionsTest2 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 5, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 6, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


bishopExpectedTestUnit2 : Chess.NextMoves
bishopExpectedTestUnit2 =
    { potentialCaptures =
        [ { x = 8, y = 1 }
        , { x = 5, y = 2 }
        ]
    , potentialMoves =
        [ { x = 7, y = 2 }
        ]
    }


bishopPossitionsTest3 : List Chess.FigureState
bishopPossitionsTest3 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 2, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 3, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


bishopExpectedTestUnit3 : Chess.NextMoves
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


pawnPossitionsTest1 : List Chess.FigureState
pawnPossitionsTest1 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 4, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 4, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 6, y = 7 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


pawnExpectedTestUnit1 : Chess.NextMoves
pawnExpectedTestUnit1 =
    { potentialCaptures = [], potentialMoves = [ { x = 7, y = 3 } ] }


pawnPossitionsTest2 : List Chess.FigureState
pawnPossitionsTest2 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 6, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 3, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 5, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 6, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


pawnExpectedTestUnit2 : Chess.NextMoves
pawnExpectedTestUnit2 =
    { potentialCaptures = [ { x = 8, y = 2 }, { x = 6, y = 2 } ], potentialMoves = [ { x = 7, y = 2 } ] }


pawnPossitionsTest3 : List Chess.FigureState
pawnPossitionsTest3 =
    [ ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 1, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Rook, moves = [ { x = 7, y = 5 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 6, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 4, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 8, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 5, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 1, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 8 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 7, y = 2 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 1, y = 4 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 2, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Knight, moves = [ { x = 3, y = 3 } ] } )
    , ( Chess.Me, { figure = Chess.Pawn, moves = [ { x = 3, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Bishop, moves = [ { x = 7, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.King, moves = [ { x = 5, y = 6 } ] } )
    , ( Chess.Me, { figure = Chess.Queen, moves = [ { x = 5, y = 5 } ] } )
    ]


pawnExpectedTestUnit3 : Chess.NextMoves
pawnExpectedTestUnit3 =
    { potentialCaptures = [ { x = 6, y = 1 }, { x = 8, y = 1 } ], potentialMoves = [] }



-- PAWN ends
