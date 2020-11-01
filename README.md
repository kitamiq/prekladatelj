# Prekladatelj ![* Interslavic flag *](http://steen.free.fr/interslavic/slovianski.ico)

*(isv. "Translator")*

[Čitati v Medžuslovjanskom jezyku](README_isl_la.md) // [Читати в Меджусловjанском jезыку](README_isl_cy.md)

A Ruby gem (library) for transliterating [Interslavic](http://steen.free.fr/interslavic/index.html) texts from Latin to Cyrillic and vice versa.
Like this:

```ruby
"Меджусловјанскы јест језык, кторы Словјани разных народностиј користајут".to_latin
#=> "Medžuslovjansky jest jezyk, ktory Slovjani raznyh narodnostij koristajut"
"Jabloko sut jedlivy plod".to_cyrillic
#=> "Јаблоко сут једливы плод"
```
This is useful for Rails website or a Ruby program in Interslavic, allowing you to provide content in both official writing systems (including [Flavourisation](#Flavourisation)) without manual transliteration

## Installation
As for any Ruby gem.

Add this line to your application's Gemfile:

```ruby
gem 'prekladatelj'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install prekladatelj

(alternatively, if you're familiar with gems development, clone this repository and perform ``rake install``)
## Usage

**Prekladatelj** extends ``String``, so you will want to use it like this:

```ruby
require 'prekladatelj'
str = "Redok"
str.to_cyrillic #=> "Редок"
# or even like this:
"Богоjaвjeнje".to_latin #=> "Bogojavjenje"
```

However, a more complicated way is possible (in case you need it?..):
```ruby
require 'prekladatelj'
Prekladatelj::Cyrillic::to_latin "изjаснити" #=> "izjasniti"
Prekladatelj::Latin::to_cyrillic "Japonija"  #=> "Јапонија"
```
The algorithm may not be the fastest, so if you deal with large texts you may want to save 
the transliteration for further usage unless your content is dynamic.
Note that destructive methods (like ``to_latin!``) are not yet implemented, so you have to assign methods' output to a variable
in order to save the transliteration, like this:
```ruby
cyrillic = some_text.to_cyrillic
```

## Flavourisation

Besides two writing systems, Interslavic offers flavourisation. That means, if you want to address your message to Western Slavs,
 you can change Interslavic's standard letters so they are easier to read
 for a Polish person (such as Ł, W instead of L, V). More about [Flavourisation in Interslavic here](http://steen.free.fr/interslavic/flavorizacija.html) (English)
 
**Prekladatelj** supports predefined sets of flavour which you can pass to the ``to_xxx`` methods:

```ruby
"Bogojavjenje".to_cyrillic :eastern 
# => "Богоявьенье" 
# standard: "Богоjaвjeнje"
``` 

As of version 0.1.0, the only 'flavour' available for ``to_cyrillic`` is ``:eastern``, which looks much more familiar for *Russians, Ukrainians and Belarusians*.
(letters **я**, **ю**, **щ**; "ся" as a 'self' particle etc.)
```ruby
Prekladatelj::Latin::to_cyrillic "jaščer", :eastern
# => "ящер"
# standard: "jашчер"
```

## Restrictions
* As of 0.1.0, Prekladatelj requires the original text to be written in [current version](http://steen.free.fr/interslavic/orthography.html#standard_alphabet) 
of Interslavic orthography standard. For example, previously used ѣ as Є in Cyrillic would not be recognized (yet). This
also means that flavourised texts cannot be converted back (at least for now)
* ``:eastern`` flavour can only be applied to Latin string; for flavouring Cyrillic, first convert it in Latin (this will be fixed soon) 
* ``cz sz zs`` and another alternatives for diacritic ``č, š, ž`` are not yet supported
* Etymological alphabet is unlikely to be ever supported
* Glagolica is not yet supported

## Troubleshooting
This gem is still in its early days and haven't been properly tested on big texts, so bugs are likely
to occur, especially while using flavourisation features.

If something isn't right or you have an idea to offer, feel free to open an issue.

Better way, fix the problem yourself, see "Contributing" below

## Contributing

Prekladatelj has a huge room to improve in terms of accuracy and speed. If you know Ruby, feel free to fork this repo
and apply your improvements, pull requests are welcome.

If you know another language, you may implement you own version of Prekladatelj in that language
utilising this name. Please notify me if you do!