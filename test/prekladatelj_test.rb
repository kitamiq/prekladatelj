require "test_helper"

class PrekladateljTest < Minitest::Test

  $text = "Меджусловјанскы јест орудје дља комуникације с Словјанами. Ученје не јест тежко и не троваје долго. Знајучи такы језык, чловєк имаје можност, да бы изражал се во всакој словјанској државє и разумєл скоро все, что људи к њему говорет и пишут. С помочју флаворизације можно јест приближати своје тексты јешче боље к регионалным или мєстным вариантам, да бы оне имєли вече возходных, сєверных, западных или јужных чрт."
  $latin_text = "Medžuslovjansky jest orudje dlja komunikacije s Slovjanami. Učenje ne jest težko i ne trovaje dolgo. Znajuči taky jezyk, člověk imaje možnost, da by izražal se vo vsakoj slovjanskoj državě i razuměl skoro vse, čto ljudi k njemu govoret i pišut. S pomočju flavorizacije možno jest približati svoje teksty ješče bolje k regionalnym ili městnym variantam, da by one iměli veče vozhodnyh, sěvernyh, zapadnyh ili južnyh črt."
  $eastern_text = "Меджусловяньски ест орудье для комуникацие с Словянами. Ученье не ест тяжко и не тровае долго. Знаючи такы язык, чловек имае можность, да бы изражал ся во всякой словяньской державе и розумел скоро все, что люди к ньему говорят и пишут. С помочю флаворизацие можно ест приближать свое тексты еще болье к региональным или местным вариантам, да бы оне имели вяче возходных, северных, западных или южных черт."

  def test_that_it_has_a_version_number
    refute_nil ::Prekladatelj::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

=begin
  def test_converts_from_latin_to_cyrillic
    assert
  end
=end
end
