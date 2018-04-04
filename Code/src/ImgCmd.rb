# Commande concrète pour une image du scénario
class ImgCmd
  attr_reader :scenario

  def initialize(scenar)
    @scenario = scenar

  end

  def execute(param)
    @scenario.execImage(param);
  end
end
