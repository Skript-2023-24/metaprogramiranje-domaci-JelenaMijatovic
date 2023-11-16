require "google_drive"
require_relative "custom_table"

session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1F-uBXMTr5mJpF4VQOQlQAvdrzNlD71yG3vKnrcYJWCM").worksheets[0]

t = CustomTable.new(ws)

p t.table

p t.row(2)[1]

t.each {|cell| puts cell}

p t["Prva Kolona"]
p t["Prva Kolona"][2]
p t["Prva Kolona"][2]= "42"

p t.prvaKolona
p t.prvaKolona.sum
p t.kolonaBrojeva.avg
p t.stringovi.map { |cell| cell.upcase }
p t.stringovi.select { |cell| cell.size < 4 }
p t.stringovi.three