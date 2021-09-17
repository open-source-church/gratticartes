require 'squib'
require 'game_icons'


data = Squib.csv file: 'cartes.csv', col_sep: ",", quote_char: '"'

DEFAULT_ICON = "empty-chessboard"
puts data["Texte"]

Squib::Deck.new(cards: data["Texte"].size, layout: 'layout.yml', width: "68mm", height: "93mm") do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  
  rect layout: "border"
  rect layout: "background"
  
  #hint text: "lightgray"
  
  text str: 'GrattiCartes · www.holygames.ch', layout: "footer"
  text str: "Donnez cette carte à quelqu'un en lui expliquant pourquoi", layout: "help"
  
  #rect layout: "logo", fill_color: "#777777"
  svg file: "logo_cube_seul.svg", layout: "logo"
  
  #Icone
  svg data: data["Icone"].map{ |i| GameIcons.get(i || DEFAULT_ICON).recolor(fg: '800080', bg: 'fff').string }, layout: "icone", width: :scale
  #text str: " :img: ", layout: "icone" do |embed|
      #embed.svg key: ":img:", data: data["Icone"].map{ |i| GameIcons.get(i || DEFAULT_ICON).recolor(fg: '800080', bg: 'fff').string }, layout: "icone", height: "24mm", width: "24mm"
  #end
  text str: data["Texte"], layout: "text"
  
  #save format: :png
  save_pdf file: "cards.pdf", trim: "2mm", height: "297mm", width: "210mm"
end
