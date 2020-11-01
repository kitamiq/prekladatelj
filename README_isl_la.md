# Prekladatelj ![* Interslavic flag *](http://steen.free.fr/interslavic/slovianski.ico)
[Read in English](README.md) // [Читати в Меджусловjанском jезыку](README_isl_cy.md)

Gem Ruby (biblioteka) dlja transliteraciji tekstov v [Medžuslovjanskom](http://steen.free.fr/interslavic/index.html) jezyku s Latinice na Kirilicu i obratno.
Tak:

```ruby
"Меджусловјанскы јест језык, кторы Словјани разных народностиј користајут".to_latin
#=> "Medžuslovjansky jest jezyk, ktory Slovjani raznyh narodnostij koristajut"
"Jabloko sut jedlivy plod".to_cyrillic
#=> "Јаблоко сут једливы плод"
```
To jest dobro dlja veb-sajtov na Rails ili program na Ruby, koristajučim Medžuslovjansky jezyk.
Možno podavati teksty na obojih pismah (vključajuči [Flavorizaciju](#Flavorizacija)) bez ručnogo prekladu.

## Postavjenje
Kako dlja drugyh Ruby gemov.

Vpiši seju liniju v Gemfile tvojej aplikaciji (ako koristaješ onyj):

```ruby
gem 'prekladatelj'
```

Potom izpolni:

    $ bundle install

Ili postavj sam črez:

    $ gem install prekladatelj

(ako li ty znaješ, kako jest tvorimy gemy, kloniruj sej repozitorij i izpolni ``rake install``)
## Koristanje

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
```
Algoritm može byti ne bystry, tomu veliky teksty rekomendovano zapisyvati v premennoju dlja daljšego koristanija, jestli
kontent ne jest dinamičesky.

Obrati pozornost, že destruktivny metody (kako ``to_latin!``) ješče ne jest stvoreny, i potrebno pisati izhod metodov v novu premennoju,
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

K času versiji 0.1.0, jediny 'flavor' dostupny dlja ``to_cyrillic`` jest ``:eastern``,
ktory legše čitati *Russkym, Ukrajincam i Belorusam*.
(bukvy **я**, **ю**, **щ**; 'ся' zamesto 'се' i tako dalje)
```ruby
Prekladatelj::Latin::to_cyrillic "jaščer", :eastern
# => "ящер"
# standard: "jашчер"
```

## Ograničenja
* V versiji 0.1.0, Prekladatelju treba, že tekst jest pisany po [sejčasnomu standardu](http://steen.free.fr/interslavic/orthography.html#standard_alphabet) pravopisu.
Napriklad, raneje koristana v Kirilice ѣ (kako Ě) ne bude poznana (poka). Flavorizovany
teksty takože poka ne možut byti transliterovany
* ``:eastern`` može byti izkoristajuča toliko s Latinicej; dlja flavorizaciji Kirilicy izprva prekladi jej do Latinicy (se skoro bude popravjeno) 
* ``cz sz zs`` kako alternativy ``č, š, ž`` dopoka ne jest dostupny
* Etimologična abeceda jedva kogdakoli bude dostupna
* Glagolica dopoka ne jest dostupna

## Problemy
Tutoj gem jest mnogo mlady. Stvori issue, ako čtokoli nedobro!

## Vkladanje

Prekladatelj imaje mnogo možlivosti dlja ulepšenija. Ako ty znaješ Ruby, možeš stvoriti fork sego repozitorija i priložiti
izmeny. Pull requests jest privitany!

Ako znaješ drugy jezyk programovanija, možeš stvoriti inu versiju Prekladatelja v tom jezyke, koristajuči jego ime.
Prošu, uvedomi, ako tak!