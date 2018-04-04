# Classe dont on pourrait avoir besoin pour une commande supplémentaire
=begin
class AskCmd
  attr_reader :scenario

  def initialize(scenar)
    @scenario = scenar

  end

  def execute
    @scenario.execAsk(param);
  end
end
=end
