#!/usr/bin/env ruby

unless File.exist? 'a1.html'
  system('wget -O a1.html "https://www.gazzettaufficiale.it/atto/serie_generale/caricaArticolo?art.versione=1&art.idGruppo=0&art.flagTipoArticolo=1&art.codiceRedazionale=093G0451&art.idArticolo=1&art.idSottoArticolo=1&art.idSottoArticolo1=10&art.dataPubblicazioneGazzetta=1993-10-14&art.progressivo=1"')
end

unless File.exist? 'a2.html'
  system('wget -O a2.html "https://www.gazzettaufficiale.it/atto/serie_generale/caricaArticolo?art.versione=1&art.idGruppo=0&art.flagTipoArticolo=1&art.codiceRedazionale=093G0451&art.idArticolo=1&art.idSottoArticolo=1&art.idSottoArticolo1=10&art.dataPubblicazioneGazzetta=1993-10-14&art.progressivo=2"')
end

unless File.exist? 'a3.html'
  system('wget -O a3.html "https://www.gazzettaufficiale.it/atto/serie_generale/caricaArticolo?art.versione=1&art.idGruppo=0&art.flagTipoArticolo=1&art.codiceRedazionale=093G0451&art.idArticolo=1&art.idSottoArticolo=1&art.idSottoArticolo1=10&art.dataPubblicazioneGazzetta=1993-10-14&art.progressivo=3"')
end

tabella = File.readlines('a1.html').slice(53..3040).each(&:strip!)
tabella += File.readlines('a2.html').slice(42..3040).each(&:strip!)
tabella += File.readlines('a3.html').slice(41..2144).each(&:strip!)

tabella.reject! { |e| e.count(' ') < 4 }

tabella.map! { |e| e.split(' ', 5) }

File.open('dpr_413_1993.csv', 'w') do |csv|
  csv.puts('pr,z,gr-g,alt,comune')

  tabella.each do |e|
    csv.puts(e.join(','))
  end
end
