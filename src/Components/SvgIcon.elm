module Components.SvgIcon exposing (..)

import Html
import Svg
import Svg.Attributes as HA
import Svg.Events


warning : Html.Html msg
warning =
    Svg.svg
        [ HA.viewBox "0 0 24 24"
        , HA.fill "none"
        , HA.width "20px"
        ]
        [ Svg.path
            [ HA.d "M12 17.0001H12.01M12 10.0001V14.0001M6.41209 21.0001H17.588C19.3696 21.0001 20.2604 21.0001 20.783 20.6254C21.2389 20.2985 21.5365 19.7951 21.6033 19.238C21.6798 18.5996 21.2505 17.819 20.3918 16.2579L14.8039 6.09805C13.8897 4.4359 13.4326 3.60482 12.8286 3.32987C12.3022 3.09024 11.6978 3.09024 11.1714 3.32987C10.5674 3.60482 10.1103 4.4359 9.19614 6.09805L3.6082 16.2579C2.74959 17.819 2.32028 18.5996 2.39677 19.238C2.46351 19.7951 2.76116 20.2985 3.21709 20.6254C3.7396 21.0001 4.63043 21.0001 6.41209 21.0001Z"
            , HA.stroke "white"
            , HA.strokeWidth "2"
            , HA.strokeLinecap "round"
            , HA.strokeLinejoin "round"
            ]
            []
        ]


arrowDown : Html.Html msg
arrowDown =
    Svg.svg
        [ HA.viewBox "0 -4.5 20 20" ]
        [ Svg.g
            [ HA.stroke "none", HA.strokeWidth "1", HA.fill "currentColor", HA.fillRule "evenodd" ]
            [ Svg.g
                [ HA.transform "translate(-180.000000, -6684.000000)", HA.fill "currentColor" ]
                [ Svg.g
                    [ HA.transform "translate(56.000000, 160.000000)" ]
                    [ Svg.path
                        [ HA.d "M144,6525.39 L142.594,6524 L133.987,6532.261 L133.069,6531.38 L133.074,6531.385 L125.427,6524.045 L124,6525.414 C126.113,6527.443 132.014,6533.107 133.987,6535 C135.453,6533.594 134.024,6534.965 144,6525.39" ]
                        []
                    ]
                ]
            ]
        ]


eye : String -> Html.Html msg
eye overrideColor =
    Svg.svg
        [ HA.fill <|
            if overrideColor == "" then
                "currentColor"

            else
                overrideColor
        , HA.viewBox "0 0 442.04 442.04"
        , HA.xmlSpace "preserve"
        ]
        [ Svg.g
            []
            [ Svg.g []
                [ Svg.path [ HA.d "M221.02,341.304c-49.708,0-103.206-19.44-154.71-56.22C27.808,257.59,4.044,230.351,3.051,229.203\n\t\t\tc-4.068-4.697-4.068-11.669,0-16.367c0.993-1.146,24.756-28.387,63.259-55.881c51.505-36.777,105.003-56.219,154.71-56.219\n\t\t\tc49.708,0,103.207,19.441,154.71,56.219c38.502,27.494,62.266,54.734,63.259,55.881c4.068,4.697,4.068,11.669,0,16.367\n\t\t\tc-0.993,1.146-24.756,28.387-63.259,55.881C324.227,321.863,270.729,341.304,221.02,341.304z M29.638,221.021\n\t\t\tc9.61,9.799,27.747,27.03,51.694,44.071c32.83,23.361,83.714,51.212,139.688,51.212s106.859-27.851,139.688-51.212\n\t\t\tc23.944-17.038,42.082-34.271,51.694-44.071c-9.609-9.799-27.747-27.03-51.694-44.071\n\t\t\tc-32.829-23.362-83.714-51.212-139.688-51.212s-106.858,27.85-139.688,51.212C57.388,193.988,39.25,211.219,29.638,221.021z" ] []
                ]
            , Svg.g []
                [ Svg.path [ HA.d "M221.02,298.521c-42.734,0-77.5-34.767-77.5-77.5c0-42.733,34.766-77.5,77.5-77.5c18.794,0,36.924,6.814,51.048,19.188\n\t\t\tc5.193,4.549,5.715,12.446,1.166,17.639c-4.549,5.193-12.447,5.714-17.639,1.166c-9.564-8.379-21.844-12.993-34.576-12.993\n\t\t\tc-28.949,0-52.5,23.552-52.5,52.5s23.551,52.5,52.5,52.5c28.95,0,52.5-23.552,52.5-52.5c0-6.903,5.597-12.5,12.5-12.5\n\t\t\ts12.5,5.597,12.5,12.5C298.521,263.754,263.754,298.521,221.02,298.521z" ]
                    []
                , Svg.g []
                    [ Svg.path [ HA.d "M221.02,246.021c-13.785,0-25-11.215-25-25s11.215-25,25-25c13.786,0,25,11.215,25,25S234.806,246.021,221.02,246.021z" ] []
                    ]
                ]
            ]
        ]


upload : Html.Html msg
upload =
    Svg.svg
        [ HA.viewBox "0 0 24 24", HA.fill "currentColor" ]
        [ Svg.path
            [ HA.d "M12.5535 2.49392C12.4114 2.33852 12.2106 2.25 12 2.25C11.7894 2.25 11.5886 2.33852 11.4465 2.49392L7.44648 6.86892C7.16698 7.17462 7.18822 7.64902 7.49392 7.92852C7.79963 8.20802 8.27402 8.18678 8.55352 7.88108L11.25 4.9318V16C11.25 16.4142 11.5858 16.75 12 16.75C12.4142 16.75 12.75 16.4142 12.75 16V4.9318L15.4465 7.88108C15.726 8.18678 16.2004 8.20802 16.5061 7.92852C16.8118 7.64902 16.833 7.17462 16.5535 6.86892L12.5535 2.49392Z"
            , HA.fill "currentColor"
            ]
            []
        , Svg.path
            [ HA.d "M3.75 15C3.75 14.5858 3.41422 14.25 3 14.25C2.58579 14.25 2.25 14.5858 2.25 15V15.0549C2.24998 16.4225 2.24996 17.5248 2.36652 18.3918C2.48754 19.2919 2.74643 20.0497 3.34835 20.6516C3.95027 21.2536 4.70814 21.5125 5.60825 21.6335C6.47522 21.75 7.57754 21.75 8.94513 21.75H15.0549C16.4225 21.75 17.5248 21.75 18.3918 21.6335C19.2919 21.5125 20.0497 21.2536 20.6517 20.6516C21.2536 20.0497 21.5125 19.2919 21.6335 18.3918C21.75 17.5248 21.75 16.4225 21.75 15.0549V15C21.75 14.5858 21.4142 14.25 21 14.25C20.5858 14.25 20.25 14.5858 20.25 15C20.25 16.4354 20.2484 17.4365 20.1469 18.1919C20.0482 18.9257 19.8678 19.3142 19.591 19.591C19.3142 19.8678 18.9257 20.0482 18.1919 20.1469C17.4365 20.2484 16.4354 20.25 15 20.25H9C7.56459 20.25 6.56347 20.2484 5.80812 20.1469C5.07435 20.0482 4.68577 19.8678 4.40901 19.591C4.13225 19.3142 3.9518 18.9257 3.85315 18.1919C3.75159 17.4365 3.75 16.4354 3.75 15Z"
            , HA.fill "currentColor"
            ]
            []
        ]


defaultUser : Html.Html msg
defaultUser =
    Svg.svg
        [ HA.viewBox "0 0 24 24"
        , HA.fill "currentColor"
        ]
        [ Svg.path
            [ HA.d "M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z"
            , HA.stroke "currentColor"
            , HA.strokeWidth "2"
            , HA.strokeLinecap "round"
            , HA.strokeLinejoin "round"
            ]
            []
        , Svg.path
            [ HA.d "M12 14C8.13401 14 5 17.134 5 21H19C19 17.134 15.866 14 12 14Z"
            , HA.stroke "currentColor"
            , HA.strokeWidth "2"
            , HA.strokeLinecap "round"
            , HA.strokeLinejoin "round"
            ]
            []
        ]
