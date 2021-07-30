# Prekladatelj ![* Interslavic flag *](http://steen.free.fr/interslavic/slovianski.ico)
[Read in English](README.md) // [Читати в Меджусловjанском jезыку](README_isl_cy.md)

CLI programa i gem Ruby (biblioteka) dlja transliteraciji tekstov v [Medžuslovjanskom](http://steen.free.fr/interslavic/index.html) jezyku s Latinice na Kirilicu i obratno.
Tak (kako programa):

```shell
prekladatelj -c --eastern file1.txt file2.html file3
```

ili tak (kako biblioteka):

```ruby
"Меджусловјанскы јест језык, кторы Словјани разных народностиј користајут".to_latin
#=> "Medžuslovjansky jest jezyk, ktory Slovjani raznyh narodnostij koristajut"
"Jabloko sut jedlivy plod".to_cyrillic
#=> "Јаблоко сут једливы плод"
```
To jest dobro dlja veb-sajtov na Rails ili program na Ruby, koristajučim Medžuslovjansky jezyk.
Možno podavati teksty na obojih pismah (vključajuči [Flavorizaciju](#Flavorizacija)) bez ručnogo prekladu.

## Postavjenje

    $ gem install prekladatelj
(potrěbno ``rubygems``)

Ako li jedino biblioteka potrěbna, piši seju liniju v Gemfile tvojej aplikaciji (ako koristaješ onyj):

```ruby
gem 'prekladatelj'
```

Potom izpolni:

    $ bundle install

(ako li ty znaješ, kako jest tvorimy gemy, kloniruj sej repozitorij i izpolni ``rake install``)
## Koristanje

### Kako programa
Od versiji 0.1.2 _Prekladatelj_ imaje interfejs redka nakaza (komandnoj liniji, CLI):
```shell
prekladatelj -c --eastern file1.txt file2.html file3
```
Sej interfejs bude dostupny poslě postavjenja s nakazom ``gem install``

Izpolni s opcijeju ``-c`` ili ``-l`` (to znači prěkladati do kirili``c``i ili ``l``atinici), takože jest možno davati flavorizaciju,
napriklad ``--eastern``, poslě piši nazvy fajlov, ktory jest potrěbno transliterovati do sego alfabeta.
Izbor fajlov kako v *nix jest dostupny, tomu ``*`` značit "vse fajly v sej papke/direktoriji", ``*_isv.html`` jest "vse fajly, ktory končajut se s _isv.html" i tako dalje.
Prekladatelj čitaje fajly ``.txt``, ``.html`` ili bez sufiksa/razširjenja, drugy fajly ignoruje, jednako jest možno nasilno transliteroavti jih s opcijeju ``--force``.

Izpolni ``prekladatelj`` bez opcij, da by viděti vsi dostupny opciji.

Prekladatelj može tvoriti razumno obrabotanje HTML fajlov, tomu on ne obračaje ``<title>`` v ``<титле>``.
Takože on ne transliteruje kontent v tegah CSS klasa ``notranslit``, tomu možno koristati sej klas dlja nepreklada něktorogo kontenta.

Kratko govoreči:
```shell
prekladatelj -c isv.html
```

_isv.html:_
```html
    <title class="notranslit">le website</title>
    <center>
    <h1>Medžuslovjansky v světe internetnoj komunikaciji</h1>
    <small>(myslji ob interslavike)</small>
    </center>
```
_isv_c.html:_
```html
    <title class="notranslit">le website</title>
    <center>
    <h1>Меджусловјанскы в свєте интернетној комуникацији</h1>
    <small>(мыслји об интерславике)</small>
    </center>
```

### Kako biblioteka

**Prekladatelj** razširjaje ``String``, tomu možno koristati tako:

```ruby
require 'prekladatelj'
str = "Redok"
str.to_cyrillic #=> "Редок"
# ale až tak:
"Богоjaвjeнje".to_latin #=> "Bogojavjenje"
```

Jednako bolje težkij sposob jest možlivy (jestli potrebno?..):
```ruby
require 'prekladatelj'
Prekladatelj::Cyrillic::to_latin "изjаснити" #=> "izjasniti"
Prekladatelj::Latin::to_cyrillic "Japonija"  #=> "Јапонија"
Prekladatelj::Latin::to_cyrillic "Japonija", :eastern  #=> "Япония"
```
_Prekladatelj_ jest bystry/brzy, ale veliky teksty rekomendovano zapisyvati v premennoju dlja daljšego koristanija, jestli
kontent ne jest dinamičesky.

Obrati pozornost, že originalny redok nikogdy ne jest izměnjajemy i potrebno pisati izhod metodov v novu premennoju,
da by shraniti transliteraciju. Vot tak:

```ruby
cyrillic = some_text.to_cyrillic
```

## Flavorizacija

Jestli potrebno obratiti se k ljudam jedinogo roda, možno koristati [flavorizaciju](http://steen.free.fr/interslavic/flavorizacija.html) (Anglijsky)
 
**Prekladatelj** davaje definiovanu kolekciju sih "zapahov", ktory možno predavati metodam ``to_xxx``:

```ruby
"Bogojavjenje".to_cyrillic :eastern 
# => "Богоявьенье" 
# standard: "Богоjaвjeнje"
``` 

K času versiji 0.1.2, jediny 'flavor' dostupny dlja ``to_cyrillic`` jest ``:eastern``,
ktory legše čitati *Russkym, Ukrajincam i Belorusam*.
(bukvy **я**, **ю**, **щ**; 'ся' zamesto 'се' i tako dalje)
```ruby
Prekladatelj::Latin::to_cyrillic "jaščer", :eastern
# => "ящер"
# standard: "jашчер"
```

## Ograničenja
* V versiji 0.1.2, Prekladatelju treba, že tekst jest pisany po [sejčasnomu standardu](http://steen.free.fr/interslavic/orthography.html#standard_alphabet) pravopisu.
Napriklad, raneje koristana v Kirilice ѣ (kako Ě) ne bude poznana (poka). Flavorizovany
teksty takože poka ne možut byti transliterovany
* ``:eastern`` može byti izkoristajuča toliko s Latinicej; dlja flavorizaciji Kirilicy izprva prekladi jej do Latinicy (se skoro bude popravjeno) 
* ``cz sz zs`` kako alternativy ``č, š, ž`` ne jest dostupny
* Etimologična abeceda jedva kogdakoli bude dostupna
* Glagolica dopoka ne jest dostupna

## Problemy
Tutoj gem jest mnogo mlady. Stvori issue, ako čtokoli nedobro!

## Vkladanje

Prekladatelj imaje mnogo možlivosti dlja ulepšenija. Ako ty znaješ Ruby, možeš stvoriti fork sego repozitorija i priložiti
izmeny. Pull requests jest privitany!

Ako znaješ drugy jezyk programovanija, možeš stvoriti inu versiju Prekladatelja v tom jezyke, koristajuči jego ime.
Prošu, uvedomi, ako tak!