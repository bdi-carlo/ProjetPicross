# Commande concrète du scénario pour les picross
class PicCmd
  # Scenario : l'endroit ou est effectué toutes les commandes
  attr_reader :scenario

  def initialize(scenar)
    @scenario = scenar

  end

  def execute(param)
    @scenario.execPic(param)
  end
end
