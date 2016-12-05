import Html exposing (Html, div, text, h1, ul, li, img, span, a, p, i)
import Html.Attributes exposing (class, src, href, placeholder)
import Html.Events exposing (onClick, onInput)
import SemanticUi exposing (..)
import HtmlResultParser exposing (..)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { searchText : String
  }


init : (Model, Cmd Msg)
init =
  (Model "", Cmd.none)


-- UPDATE

type Msg
  = SearchText String
  | Search

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SearchText text ->
      ({ model | searchText = text }, Cmd.none)
    Search ->
      (model, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [ class "ui center aligned header" ] [ text "The Libary of Babel" ]
    , container
        [ row
            [ col "twelve"
                [ input [ placeholder "search...", onInput SearchText ]
                    |> fluid
                    |> render
                ]
            , col "four"
                [  button "search"
                    |> render
                ]
            ]
        ]
    , container
      [ col "sixteen" [ showResultList (parse testHtml) ]
      ]
    ]


showResultList : List HtmlResultParser.Result -> Html Msg
showResultList list =
  items (List.map (\result -> showResult result ) list)


showResult : HtmlResultParser.Result -> Html Msg
showResult result =
  let
    thumbUrl = "http://72.191.219.159" ++ result.thumbUrl
    urls = List.map (\url -> "http://72.191.219.159" ++ url) result.urls
    actions =
      urls
        |> List.map
          (
            \url ->
              a [ class "ui right floated primary button", href url ]
                [ text (parseExtension url)
                ]
          )
  in
    item (itemImg thumbUrl) (itemContent result.title "" result.description actions)

parseExtension : String -> String
parseExtension url =
  let
    ext = url
      |> String.split "."
      |> List.reverse
      |> List.head
  in
    case ext of
      Just e -> e
      Nothing -> ""

testHtml = """
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>calibre Library</title>
  <link type="image/x-icon" href="//calibre-ebook.com/favicon.ico" rel="icon">
  <link type="text/css" href="/mobile/style.css" rel="stylesheet">
  <link rel="apple-touch-icon" href="/static/calibre.png">
  <meta name="robots" content="noindex">
</head>

<body>
  <div id="logo"><img src="/static/calibre.png" alt="calibre"></div>
  <div id="search_box">
    <form action="/mobile" method="get" accept-charset="UTF-8">Show <select name="num"><option value="5">5</option>
<option value="10">10</option>
<option value="25" SELECTED>25</option>
<option value="100">100</option></select> books matching <input name="search" value="cyberpunk" id="s"> sorted by
      <select
        name="sort">
        <option value="date">date</option>
        <option value="author">author</option>
        <option value="title" SELECTED>title</option>
        <option value="rating">rating</option>
        <option value="size">size</option>
        <option value="tags">tags</option>
        <option value="series">series</option>
        </select><select name="order"><option value="ascending" SELECTED>ascending</option>
<option value="descending">descending</option></select><input value="Search" id="go" type="submit">
    </form>
  </div>
  <div class="navigation">
    <span style="display: block; text-align: center;">Books 1 to 15 of 15</span>
    <table class="buttons">
      <tr>
        <td style="text-align:left" class="button"></td>
        <td style="text-align:right" class="button"></td>
      </tr>
    </table>
  </div>
  <hr class="spacer">
  <table id="listing">
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3855" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/William%20Gibson-All%20Tomorrow%27s%20Parties_3855.epub">epub</a></span>
        <span
          class="button"><a href="/get/LRF/William%20Gibson-All%20Tomorrow%27s%20Parties_3855.lrf">lrf</a></span>
          <div class="data-container">
            <span class="first-line"> All Tomorrow's Parties  by William Gibson</span><span class="second-line">590.2 KB - 13 Jul, 2011 Tags=[Adventure, Cyberspace, Fiction, General, General Interest, ...] Fixed=[Yes] ISBN=[9780425190449] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/4898" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Neal%20Stephenson-Anathem_4898.epub">epub</a></span>
        <div class="data-container">
          <span class="first-line"> Anathem  by Neal Stephenson</span><span class="second-line">759.6 KB - 05 Jul, 2012 Tags=[Fiction, General] Fixed=[Yes] ISBN=[9780061474101] </span>
        </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/2353" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Greg%20Bear-Blood%20Music_2353.epub">epub</a></span><span class="button"><a href="/get/LRF/Greg%20Bear-Blood%20Music_2353.lrf">lrf</a></span>
        <div
          class="data-container">
          <span class="first-line"> Blood Music  by Greg Bear</span><span class="second-line">436.8 KB - 13 Jul, 2011 Tags=[Fiction, General, General Interest, Science Fiction] Fixed=[Yes] ISBN=[9780759241749] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/4999" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Neal%20Stephenson-Cryptonomicon_4999.epub">epub</a></span><span class="button"><a href="/get/LRF/Neal%20Stephenson-Cryptonomicon_4999.lrf">lrf</a></span>
        <span
          class="button"><a href="/get/MOBI/Neal%20Stephenson-Cryptonomicon_4999.mobi">mobi</a></span>
          <div class="data-container">
            <span class="first-line"> Cryptonomicon  by Neal Stephenson</span><span class="second-line">1.7 MB - 13 Jul, 2011 Tags=[Adventure fiction, Data encryption (Computer science), Espionage, Fiction, General, ...] Fixed=[Yes] ISBN=[9780060512804] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3785" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/William%20Gibson%20%26%20Bruce%20Sterling-The%20Difference%20Engine_3785.epub">epub</a></span>
        <span
          class="button"><a href="/get/LRF/William%20Gibson%20%26%20Bruce%20Sterling-The%20Difference%20Engine_3785.lrf">lrf</a></span>
          <div
            class="data-container">
            <span class="first-line"> The Difference Engine  by William Gibson &amp; Bruce Sterling</span><span class="second-line">543 KB - 13 Jul, 2011 Tags=[Fiction, General, General Interest, Science Fiction] Fixed=[Yes] ISBN=[9780440423621] </span>
            </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/180" border="0"></td>
      <td>
        <span class="button"><a href="/get/PDF/Chris%20Moriarty-Ghost%20Spin_180.pdf">pdf</a></span>
        <div class="data-container">
          <span class="first-line"> Ghost Spin  by Chris Moriarty</span><span class="second-line">7.1 MB - 03 Jul, 2014 Tags=[Action &amp; Adventure, Fiction, Hard Science Fiction, Science Fiction, Technological, ...] Fixed=[Yes] ISBN=[9780553384949] </span>
        </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3854" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/William%20Gibson-Idoru_3854.epub">epub</a></span><span class="button"><a href="/get/LRF/William%20Gibson-Idoru_3854.lrf">lrf</a></span>
        <div
          class="data-container">
          <span class="first-line"> Idoru  by William Gibson</span><span class="second-line">467.5 KB - 13 Jul, 2011 Tags=[Americans, Americans - Japan, Fiction, General, General Interest, ...] Fixed=[Yes] ISBN=[9780425190456] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/4043" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Rudy%20Rucker-Live%20robots_%202%20in%201%20volume%20of%20Software_Wetware_4043.epub">epub</a></span>
        <span
          class="button"><a href="/get/LRF/Rudy%20Rucker-Live%20robots_%202%20in%201%20volume%20of%20Software_Wetware_4043.lrf">lrf</a></span>
          <div
            class="data-container">
            <span class="first-line"> Live robots: 2 in 1 volume of Software/Wetware  by Rudy Rucker</span><span class="second-line">137.9 KB - 12 Jun, 2010 Tags=[Fiction - Science Fiction, Science Fiction - General, Sociology] Fixed=[Yes] ISBN=[9780380775439] Read=[No] </span>
            </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/4556" border="0"></td>
      <td>
        <span class="button"><a href="/get/MOBI/Peter%20Watts-Maelstrom_4556.mobi">mobi</a></span><span class="button"><a href="/get/PDF/Peter%20Watts-Maelstrom_4556.pdf">pdf</a></span>
        <div
          class="data-container">
          <span class="first-line"> Maelstrom [Rifters Trilogy - 2] by Peter Watts</span><span class="second-line">1.5 MB - 21 Jul, 2010 Tags=[Fiction, Fiction - Science Fiction, General, Revenge, Science Fiction, ...] Fixed=[Yes] ISBN=[9780312878061] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3110" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/William%20Gibson-Mona%20Lisa%20Overdrive_3110.epub">epub</a></span>
        <span
          class="button"><a href="/get/LIT/William%20Gibson-Mona%20Lisa%20Overdrive_3110.lit">lit</a></span><span class="button"><a href="/get/LRF/William%20Gibson-Mona%20Lisa%20Overdrive_3110.lrf">lrf</a></span>
          <span
            class="button"><a href="/get/MOBI/William%20Gibson-Mona%20Lisa%20Overdrive_3110.mobi">mobi</a></span>
            <div class="data-container">
              <span class="first-line"> Mona Lisa Overdrive  by William Gibson</span><span class="second-line">377.9 KB - 13 Jul, 2011 Tags=[Fiction, General, General Interest, Science Fiction, Science fiction; Canadian] Fixed=[Yes] ISBN=[9780553281743] </span>
            </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3849" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/William%20Gibson-Pattern%20Recognition_3849.epub">epub</a></span><span class="button"><a href="/get/LIT/William%20Gibson-Pattern%20Recognition_3849.lit">lit</a></span>
        <span
          class="button"><a href="/get/LRF/William%20Gibson-Pattern%20Recognition_3849.lrf">lrf</a></span>
          <div class="data-container">
            <span class="first-line"> Pattern Recognition  by William Gibson</span><span class="second-line">516 KB - 13 Jul, 2011 Tags=[Business Intelligence, Espionage, Fiction, General, General Interest, ...] Fixed=[Yes] ISBN=[9780425198681] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/784" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Marianne%20De%20Pierres-PP%201%20-%20Nylon%20Angel_784.epub">epub</a></span>
        <span
          class="button"><a href="/get/MOBI/Marianne%20De%20Pierres-PP%201%20-%20Nylon%20Angel_784.mobi">mobi</a></span>
          <div class="data-container">
            <span class="first-line"> PP 1 - Nylon Angel  by Marianne De Pierres</span><span class="second-line">511.6 KB - 10 Jun, 2011  Fixed=[Yes] ISBN=[9781841492537] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3080" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Neal%20Stephenson-Snow%20Crash_3080.epub">epub</a></span><span class="button"><a href="/get/LRF/Neal%20Stephenson-Snow%20Crash_3080.lrf">lrf</a></span>
        <div
          class="data-container">
          <span class="first-line"> Snow Crash  by Neal Stephenson</span><span class="second-line">672.4 KB - 13 Jul, 2011 Tags=[20th century, American fiction, Fiction, General, General Interest, ...] Fixed=[Yes] ISBN=[9780553380958] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/3051" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/William%20Gibson-Virtual%20Light_3051.epub">epub</a></span><span class="button"><a href="/get/LRF/William%20Gibson-Virtual%20Light_3051.lrf">lrf</a></span>
        <div
          class="data-container">
          <span class="first-line"> Virtual Light  by William Gibson</span><span class="second-line">386.9 KB - 13 Jul, 2011 Tags=[California, California - Fiction, Fantasy, Fiction, General, ...] Fixed=[Yes] ISBN=[9780553566062] </span>
          </div>
      </td>
    </tr>
    <tr>
      <td class="thumbnail"><img type="image/jpeg" src="/get/thumb/1883" border="0"></td>
      <td>
        <span class="button"><a href="/get/EPUB/Neal%20Stephenson-Zodiac_%20The%20Eco%20Thriller_1883.epub">epub</a></span>
        <span
          class="button"><a href="/get/LRF/Neal%20Stephenson-Zodiac_%20The%20Eco%20Thriller_1883.lrf">lrf</a></span><span class="button"><a href="/get/MOBI/Neal%20Stephenson-Zodiac_%20The%20Eco%20Thriller_1883.mobi">mobi</a></span>
          <div
            class="data-container">
            <span class="first-line"> Zodiac: The Eco Thriller  by Neal Stephenson</span><span class="second-line">535.4 KB - 13 Jul, 2011 Tags=[Fiction, General, General Interest, Science Fiction, Thrillers] Fixed=[Yes] ISBN=[9780871131812] </span>
            </div>
      </td>
    </tr>
  </table>
  <hr class="spacer">
  <div class="navigation">
    <span style="display: block; text-align: center;">Books 1 to 15 of 15</span>
    <table class="buttons">
      <tr>
        <td style="text-align:left" class="button"></td>
        <td style="text-align:right" class="button"></td>
      </tr>
    </table>
  </div>
  <div style="text-align:center"><a title="The full interface gives you many more features, but it may not work well on a small screen" href="/browse" style="text-decoration: none; color: blue">Switch to the full interface (non-mobile interface)</a></div>
</body>
</html>
"""