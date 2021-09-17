require 'squib'
require 'game_icons'


data = Squib.csv file: 'cartes.csv', col_sep: ",", quote_char: '"'

DEFAULT_ICON = "empty-chessboard"

Squib::Deck.new(cards: data["Type"].size, layout: 'layout.yml', width: "68mm", height: "93mm") do
  background color: '#800080'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  
  rect layout: "border"
  rect layout: "background"
  
  #hint text: "lightgray"
  
  data["Type"].each_with_index do |type, r|
    case type
    when "Titre"
      rect range: r, layout: "border"
      svg range: r, file: "logo_cube_seul.svg", layout: "icone", mask: "white"
      text range: r, str: "Gratti\nCartes", layout: "text", color: "white", valign: "middle", font_size: 24
      
    when "Règles"
      rect range: r, layout: "border", fill_color: "white"
      txt = data["Texte"][r].gsub("\\n", "\n").gsub(/\*\*(.*?)\*\*/, '<span weight="bold" foreground="#800080" font_desc="Code Pro Light 12">\1</span>')
      txt = txt.gsub(/\*(.*?)\*/, '<span foreground="#800080">\1</span>')
      text range: r, layout: "background", str: txt, font: "Sinkin Sans, 10", markup: true do |embed|
        embed.svg key: ":CC-BY:", file: "CC-BY_icon.svg", width: "9mm", height: :scale
      end
      
    when "Carte"
     
      text range: r, str: 'GrattiCartes · www.holygames.ch', layout: "footer"
      text range: r, str: "Donnez cette carte à quelqu'un en lui expliquant pourquoi", layout: "help"
      
      #rect layout: "logo", fill_color: "#777777"
      svg range: r, file: "logo_cube_seul.svg", layout: "logo"
      
      #Icone
      svg range: r, data: data["Icone"].map{ |i| GameIcons.get(i || DEFAULT_ICON).recolor(fg: '800080', bg: 'fff').string }, layout: "icone", width: :scale
      #text str: " :img: ", layout: "icone" do |embed|
          #embed.svg key: ":img:", data: data["Icone"].map{ |i| GameIcons.get(i || DEFAULT_ICON).recolor(fg: '800080', bg: 'fff').string }, layout: "icone", height: "24mm", width: "24mm"
      #end
      
      #Text
      text range: r, str: data["Texte"].map {|t| t.gsub(", ", ",\n")}, layout: "text"
      
    end
  end
  
  #save format: :png
  save_pdf file: "cards.pdf", trim: "2mm", height: "297mm", width: "210mm"
end
