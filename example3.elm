import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex

main = Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = 
 { name : String
 , password : String
 , passwordAgain : String
 , age : Int
 }

model : Model
model = Model "" "" "" 0

-- UPDATE
type Msg = Name String | Password String | PasswordAgain String | Age String

update : Msg -> Model -> Model
update msg model = 
 case msg of 
  Name name -> { model | name = name }
  Password password -> { model | password = password }
  PasswordAgain password -> { model | passwordAgain = password }
  Age age -> { model | age = Result.withDefault 0 (String.toInt age)}

-- VIEW
view : Model -> Html Msg
view model =
 div []
  [ input [ type_ "text", placeholder "Name", onInput Name ] []
  , input [ type_ "password", placeholder "Password", onInput Password ] []
  , input [ type_ "password", placeholder "Re Password", onInput PasswordAgain ] []
  , input [ type_ "int", placeholder "Age", onInput Age ] []
  , viewValidation model
  ]

viewValidation : Model -> Html msg
viewValidation model =
 let (color, message) = 
  if Regex.contains (Regex.regex "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$") model.password == False then ("red", "Password should contains upper string, lower string, special charector and length at least 8 ")
  else if model.password /= model.passwordAgain then ("red", "Passwords do not match!")
  else ("green", "OK")
 in
  div [ style [("color", color)] ] [ text message ]
