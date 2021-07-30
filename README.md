# Prekladatelj ![* Interslavic flag *](http://steen.free.fr/interslavic/slovianski.ico)

*(isv. "Translator")*

[Čitati v Medžuslovjanskom jezyku](README_isl_la.md) // [Читати в Меджусловjанском jезыку](README_isl_cy.md)

A CLI program and a Ruby gem (library) for transliterating [Interslavic](http://steen.free.fr/interslavic/index.html) texts from Latin to Cyrillic and vice versa.
Like this (as a program):

```shell
prekladatelj -c --eastern file1.txt file2.html file3
```

or like this (as a library):
```ruby
"Меджусловјанскы јест језык, кторы Словјани разных народностиј користајут".to_latin
#=> "Medžuslovjansky jest jezyk, ktory Slovjani raznyh narodnostij koristajut"
"Jabloko sut jedlivy plod".to_cyrillic
#=> "Јаблоко сут једливы плод"
```
This is useful for a Rails website or a Ruby program in Interslavic, allowing you to provide content in both official writing systems (including [Flavourisation](#Flavourisation)) without manual transliteration

## Installation

    $ gem install prekladatelj
(requires ``rubygems`` to be installed)

If you only need the library, add this line to your application's Gemfile:

```ruby
gem 'prekladatelj'
```

And then execute:

    $ bundle install

_(alternatively, if you're familiar with gems development, clone this repository and perform ``rake install``)_
## Usage

### As a CLI tool
Since version 0.1.2, _Prekladatelj_ has a command-line interface:
```shell
prekladatelj -c --eastern file1.txt file2.html file3
```
You will have it available in your shell as soon as you install it with the ``gem`` command.

Execute it with ``-c`` or ``-l`` flag (letters mean _"to ``c``yrillic or ``l``atin"_), optionally passing 
flavourisation flag, like ``--eastern``, then list the paths to the files you would like to transliterate to the specified alhpabet.
*nix-style files selection is supported, hence ``*`` means "all files in this directory", ``*_isv.html`` is "all files ending with _isv.html here" and so on.
Prekladatelj supports files with ``.txt``, ``.html`` or no suffix/extension and ignores other files, but you may force it to transliterate those with other extensions
using the ``--force`` flag.

Run ``prekladatelj`` without arguments to see all options/flags available.

Prekladatelj is capable of **intelligent HTML files processing**, so it **doesn't** turn ``<title>`` into ``<титле>``.
Also, it doesn't transliterate content of tags of ``notranslit`` CSS class, so you may use it to avoid unnecessary translit.

Long story short, it looks like this:
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

### As a library

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
Prekladatelj::Latin::to_cyrillic "Japonija", :eastern  #=> "Япония"
```
_Prekladatelj_ is quite fast but if you deal with large texts you may want to save 
the transliteration for further usage (unless your content is dynamic).
Note that the original string is never changed, so you have to assign methods' output to a variable
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

As of version 0.1.2, the only 'flavour' available for ``to_cyrillic`` is ``:eastern``, which looks much more familiar for *Russians, Ukrainians and Belarusians*.
(letters **я**, **ю**, **щ**; "ся" as a 'self' particle etc.)
```ruby
Prekladatelj::Latin::to_cyrillic "jaščer", :eastern
# => "ящер"
# standard: "jашчер"
```

## Restrictions
* As of 0.1.2, Prekladatelj requires the original text to be written in [current version](http://steen.free.fr/interslavic/orthography.html#standard_alphabet) 
of Interslavic orthography standard. For example, previously used ѣ as Є in Cyrillic would not be recognized (yet). This
also means that flavourised texts cannot be converted back (at least for now)
* ``:eastern`` flavour can only be applied to Latin string; for flavouring Cyrillic, first convert it in Latin
* ``cz sz zs`` and another alternatives for diacritic ``č, š, ž`` are not supported
* Etymological alphabet is unlikely to be ever supported
* Glagolica is not yet supported

## Troubleshooting
This gem is still in its early days and haven't been properly tested on big texts, so bugs are likely
to occur, especially while using flavourisation features.

If something isn't right or you have an idea to offer, feel free to open an issue.

Better way, fix the problem yourself, see "Contributing" below

## Contributing

Prekladatelj has a huge room to improve in terms of accuracy, alphabets and flavors support. If you know Ruby, feel free to fork this repo
and apply your improvements, pull requests are welcome.

If you know another language, you may implement you own version of Prekladatelj in that language
utilising this name. Please notify me if you do!