[English version of this readme is available in the file readme.en.md](./readme.en.md)

# Ensimmäiset Robot Framework -testit 🤖

Tämän tehtävän tarkoituksena on opetella suorittamaan ja kirjoittamaan testejä [Robot Framework -työkalulla](https://robotframework.org/).

Tehtävä on jatkoa Playwright-tehtävälle, jossa harjoiteltiin kirjautumista ja rekisteröitymistä käyttäen samaa testattavaa sivustoa. Tässä Robot Framework -tehtävässä keskitytään samoihin toiminnallisuuksiin, mutta nyt tavoitteena on toteuttaa testit Robot Framework -työkalulla ja tutustua Robot Frameworkin toimintoihin ja syntaksiin.

Kuten aiemmin, tässä tehtävässä käytettävä sivusto on toteutettu testauksen harjoittelua varten, joten se ei noudata kaikkia tavanomaisia tuotantokäytössä olevien web-sivustojen oletuksia. Erityisesti sivuston kautta tehdyt rekisteröitymiset ja kirjautumiset **ovat voimassa vain saman selainistunnon sisällä**. Esimerkiksi rekisteröityminen ei siis säily eri testitapausten välillä, kun testiselain nollataan jokaisen testitapauksen alussa.

Suosittelemme alkuun pääsemiseksi katsomaan esimerkiksi [Robot Framework tutorial (youtube.com)](https://www.youtube.com/playlist?list=PLSK6YK5OGX1AuQy0tbvdKBV9mrKi46kKH) -soittolistan videot.


## Asennukset

Robot Framework on Python-pohjainen testiautomaatiokehys, joten sen käyttäminen edellyttää Pythonin ja pip-paketinhallintajärjestelmän asennusta. Robot Frameworkin lisäksi tarvitset Browser-kirjaston, joka mahdollistaa web-selainten ohjaamisen testeissäsi. Browser-kirjasto käyttää taustalla Playwright-työkalua, joka on toteutettu Node.js:llä, joten tarvitset myös Node.js:n asennettuna.

Tarkemmat asennusohjeet sekä tietoa valmiista devcontainers-ratkaisusta löytyvät erillisestä [installations.md](./installations.md)-tiedostosta.


## Testien suorittaminen

Kun olet saanut Robot Frameworkin ja Browser-kirjaston asennettua, voit kokeilla suorittaa ensimmäisiä testejä. Tässä repositoriossa on valmiiksi määritelty testitiedosto [`tests/example.robot`](./tests/example.robot), joka sisältää yksinkertaisen testin. Voit suorittaa kyseisen testitiedoston komennolla:

```sh
robot --outputdir=test-results/ tests/example.robot
```

Testin pitäisi mennä läpi onnistuneesti ja tulostaa testitulokset konsoliin. Lisäksi Robot Framework luo HTML-raportin, jonka voit avata selaimella.

Raportin tarkasteleminen on erityisen hyödyllistä, mikäli testit epäonnistuvat, sillä raportti sisältää yksityiskohtaisia tietoja testitapauksista ja testien epäonnistuessä myös kuvankaappauksia.


## Testattava sivusto

Testauksen kohteena toimii esimerkkisivusto https://authentication-6o1.pages.dev/, joka sisältää pienen määrän ominaisuuksia palveluun kirjautumiseksi ja käyttäjätunnusten luomiseksi. Sivusto on pyritty luomaan samalla yksinkertaiseksi, mutta myös laadukkaaksi, jotta se toimisi hyvänä ensimmäisenä testauskohteena. Laadun osalta esimerkiksi eri kenttien label-elementit ja virheilmoitukset on pyritty toteuttamaan niin, että niitä on helppo yksilöidä ja käsitellä ohjelmallisesti testeissä.

Sivustoa on tarkoitus testata "black box" -mallilla, eli testien kirjoittamiseksi ei ole tarkoitus perehtyä sivuston lähdekoodiin tai verkkoliikenteeseen. HTML-rakenteiden tutkiminen on kuitenkin tarpeen, jotta saat suoritettua testeissä tarvitsemasi operaatiot tekstikentille ja painikkeille.


### Rekisteröityminen

Sivustolle rekisteröityminen onnistuu osoitteessa https://authentication-6o1.pages.dev/signUp. Testisivustossa on painikkeet myös ulkoisten palveluiden hyödyntämiseen rekisteröitymisessä, mutta niihin ei ole toteutettu toiminnallisuutta.

Rekisteröityminen tällä lomakkeella luo uuden käyttäjätunnuksen, joka on voimassa vain yhden selaimen tai testitapauksen sisällä.


### Kirjautuminen

Kirjautuminen onnistuu osoitteessa https://authentication-6o1.pages.dev/. Kirjautumisen jälkeen käyttäjä ohjataan osoitteeseen https://authentication-6o1.pages.dev/dashboard, jossa näytetään tervetuloa-viesti. Kuten rekisteröityminen, myös kirjautuminen on voimassa vain saman istunnon sisällä.

Itse luotavien tunnusten lisäksi sivustolla on kaksi valmista tunnusta, jotka ovat aina voimassa:

| Name     | Username             | Password                           | Env variables in GitHub \*         |
|----------|----------------------|------------------------------------|------------------------------------|
| Jane Doe | jane.doe@example.com | `ItWorksOnMyMac1!`                 | `JANE_USERNAME`, `JANE_PASSWORD`   |
| John Doe | john.doe@example.com | `AllTestsPass1!`                   | `JOHN_USERNAME`, `JOHN_PASSWORD`   |
| Alice    | alice@example.com    | `}3jc\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj` | `ALICE_USERNAME`, `ALICE_PASSWORD` |
| Bob      | bob@example.com      | `nUL9zA3q=Nt7\N,0?CL&c74U,Ic)0)dN` | `BOB_USERNAME`, `BOB_PASSWORD`     |

Voit käyttää näitä tunnuksia niissä testitapauksissa, joissa tarvitset olemassa olevan käyttäjän kirjautumista tai rekisteröitymistä, tai haluat varmistaa, että samalla tunnuksella ei voi rekisteröityä uudelleen.

Tunnukset löytyvät myös [`tests/users.resource`-tiedostosta](./tests/users.resource), joka on tarkoitettu käytettäväksi testitiedostoissa resurssina.

\* *Lue lisää ympäristömuuttujien käytöstä tämän dokumentin loppuosasta.*


## Omien testien toteuttaminen

Kun olet kokeillut testauksen kohteena olevaa sivustoa manuaalisesti, voit aloittaa omien testien kirjoittamisen. Tässä tehtävässä tavoitteena on kirjoittaa testitapaukset sivuston rekisteröitymiseen ja kirjautumiseen. Voit kirjoittaa testit joko yhteen tiedostoon tai eri tiedostoihin, riippuen siitä, miten haluat järjestää testitapauksesi. Tiedostojesi tulee noudattaa Robot Frameworkin testitiedostojen nimeämiskäytäntöä, eli niiden tulee päättyä `.robot`-päätteeseen. Lisäksi niiden tulee sijaita `tests`-kansiossa.


## Testitapaukset

Johda seuraavista vaatimuksista testitapaukset ja kirjoita niille testit. Kussakin testitapauksessa tulee tehdä tarkoituksenmukaiset toimet (actions) ja tehdä vaadittavat tarkastukset (asserts), jotta voidaan varmistaa, että testattava toiminnallisuus toimii odotetusti. Testitapauksissa tulee huomioida myös tyypilliset virhetilanteet, joita on listattuna alla.

Jotta pääset alkuun, suosittelemme tutustumaan [Browser-kirjaston](https://marketsquare.github.io/robotframework-browser/Browser.html) dokumentaatioon sekä Robot Frameworkin [guides-osioon](https://docs.robotframework.org/docs) ja [käyttöohjeeseen](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html).


### Kirjautuminen

### Kirjautuminen

1. Palvelun etusivulla tulee olla kirjautumislomake, jossa on kentät sähköpostille ja salasanalle sekä kirjautumispainike
2. Rekisteröity käyttäjä voi kirjautua sisään sähköpostilla ja salasanalla
    * Kirjautuminen tulee olla kirjainkoosta riippumaton sähköpostikentälle, mutta salasanan kirjainkoon tulee olla täsmälleen oikein
3. Onnistuneen kirjautumisen jälkeen käyttäjä ohjataan osoitteeseen `/dashboard`, jossa näytetään tervetuloa-viesti
4. Kirjautumisen tulee estää luvaton pääsy
    * Sekä sähköposti että salasana ovat pakollisia
    * Puuttuvat tai virheelliset arvot tulee näyttää virheilmoituksina (virheellinen sähköposti tai salasanan pituus)
    * Epäonnistunut kirjautuminen pitää käyttäjän kirjautumissivulla ja näyttää virheilmoituksen
5. Käyttäjät eivät voi päästä suoraan osoitteeseen `/dashboard` ilman onnistunutta kirjautumista
    * käyttäjä tulee ohjata takaisin kirjautumissivulle
    * käyttäjälle tulee näyttää virheilmoitus
6. Kun kirjautunut käyttäjä kirjautuu ulos, hänet ohjataan takaisin kirjautumissivulle


### Rekisteröityminen

1. Rekisteröityminen tulee olla mahdollista sekä suoraan osoitteessa `/signUp` että etusivun linkin kautta
2. Nimi, sähköposti ja salasana ovat pakollisia rekisteröitymisessä
    * Puuttuvat tai virheelliset tiedot tulee näyttää virheilmoituksina
3. Rekisteröitymistä yritettäessä jo rekisteröidyllä sähköpostilla tulee näyttää virheilmoitus
    * Rekisteröityminen on kirjainkoosta riippumaton sähköpostikentälle, joten vain kirjainkoosta poikkeavan sähköpostin käyttö ei voi johtaa onnistuneeseen rekisteröitymiseen
4. Rekisteröityminen vaadituilla tiedoilla luo uuden käyttäjätilin
    * Rekisteröitymisen jälkeen tulee näyttää onnistumisviesti
    * Rekisteröitymisen jälkeen käyttäjä ohjataan kirjautumissivulle
5. Rekisteröitymisessä luotu tili tulee olla käytettävissä kirjautumiseen heti sen jälkeen (saman selainistunnon sisällä)


### Käyttäjätunnukset ja salasanat ympäristömuuttujissa

Käyttäjätunnusten, salasanojen ja API-avainten kirjoittaminen selkokielisinä testitapauksiin ei ole yleisesti suositeltavaa, sillä ne voivat olla alttiita vahingossa julkaisemiselle. Tässä tapauksessa testijärjestelmän salasanat ovat julkisia, joten ongelma ei ole merkittävä, mutta on hyvä harjoitella myös salasanojen käsittelyä turvallisesti.

Parempi tapa käsitellä salasanoja voisi olla salaisuuksien tallentaminen ympäristömuuttujiin tai CI-ympäristön salaisuuksiksi. Robot Frameworkissa voit käyttää ympäristömuuttujia [omalla syntaksilla](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#environment-variables).

Voit halutessasi tutustua ympäristömuuttujien käyttöön Robot Frameworkissa ja määrittää omat paikalliset ympäristömuuttujasi saman nimisiksi kuin GitHub actions -ympäristössä.

> [!NOTE]
> Jotta muuttujat toimivat oikein sekä omassa kehitysympäristössäsi että GitHub actions -arvioinnissa, vain seuraavat muuttujat on tuettuja:
>
> * `JANE_USERNAME` & `JANE_PASSWORD`
> * `JOHN_USERNAME` & `JOHN_PASSWORD`
> * `ALICE_USERNAME` & `ALICE_PASSWORD`
> * `BOB_USERNAME` & `BOB_PASSWORD`


## Tehtävän automaattinen arviointi

Kun olet kirjoittanut testitapaukset ja varmistanut, että ne toimivat odotetusti, voit palauttaa tehtävän automaattista tarkastusta varten. Lisää luomasi testitiedostot versionhallintaan ja lähetä muutokset GitHubiin `git status`, `git add`, `git commit` ja `git push` -komennoilla. `push`-komennon jälkeen käynnistyy GitHub action -automaattitarkastus, joka suorittaa testit ja antaa niistä palautteen. Näet palautteen GitHub-repositoriosi actions-välilehdeltä.

Automaattisessa tarkastuksessa käytetään Chrome-selainta ja testit suoritetaan yksi kerrallaan headless-tilassa. Suosittelemme varmistamaan, että testit toimivat paikallisesti seuraavalla komennolla ennen palautusta:

```bash
robot --outputdir=test-results/ tests/
```

Palautettuasi tehtävän testisi pisteytetään sen mukaan, kuinka hyvin ne todentavat edellä listattuja vaatimuksia. On siis oleellista, että testeissäsi syötät sekä oikeita että virheellisiä tietoja ja tarkistat, että sivuston tila sekä siinä näkyvät viestit toimivat oikein. Tarvittaessa tutki actions-välilehden raporttia ja testituloksia, jotta voit täydentää testejäsi kattamaan lisää testitapauksia. Voit palauttaa tehtävän uudelleen useita kertoa tehtävän määräaikaan asti.


### Tracing

**Automaattisen arvioinnin** vuoksi testitapausten tulee tallentaa selaimen tapahtumat ns. "trace"-tiedostoon, jonka avulla tehtävän automaattinen arviointi varmistaa, että vaaditut tapaukset on käyty läpi.

Jotta trace-tiedostot tallentuvat oikein, jokaisen testitapauksen alussa tulee suorittaa komento `New Context    tracing=True`. Komento avaa uuden "kontekstin", joiden avulla eri testit ovat toisistaan eristyksissä. Tärkeimpänä `tracing=True` asettaa mahdollistaa testien vaiheiden tarkastelun jälkikäteen. Voit lukea aiheesta lisää [Browser-kirjaston dokumentaatiosta](https://marketsquare.github.io/robotframework-browser/Browser.html#Browser%2C%20Context%20and%20Page).

Helpoiten saat uuden kontekstin luotua jokaisen testin alussa ja suljettua jokaisen testin lopussa lisäämällä seuraavat rivit jokaisen robot-tiedoston alkuun `*** Settings ***`-lohkoon:

```robot
# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context
```

Trace-tiedostot tallentuvat `test-results/browser/traces`-kansioon zip-tiedostoina, joita voit tarkastella [Playwrightin Trace viewer -työkalulla](https://playwright.dev/docs/trace-viewer). Työkalua voidaan käyttää paikallisesti asennettuna tai vaihtoehtoisesti osoitteessa https://trace.playwright.dev/. Katso tästä Playwrightin oma esimerkki [trace-tiedostosta](https://trace.playwright.dev/?trace=https://demo.playwright.dev/reports/todomvc/data/fa874b0d59cdedec675521c21124e93161d66533.zip) sekä [esimerkkiin liittyvä video](https://youtu.be/yP6AnTxC34s).


## Lisenssit

Robot Framework on lisensoitu [Apache 2.0 -lisenssillä](https://github.com/robotframework/robotframework/blob/master/LICENSE.txt).

Browser-kirjasto on lisensoitu [Apache 2.0 -lisenssillä](https://github.com/MarketSquare/robotframework-browser/blob/main/LICENSE).

RobotCode-laajennos on lisensoitu [Apache 2.0 -lisenssillä](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode#license).


## Materiaalista

Tämän tehtävän on kehittänyt Teemu Havulinna ja se on lisensoitu [Creative Commons BY-NC-SA -lisenssillä](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Tehtävän luonnissa on hyödynnetty kielimalleja ja tekoälytyökaluja, kuten GitHub Copilot ja ChatGPT.
