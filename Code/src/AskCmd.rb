class AskCmd
  attr_reader :scenario

  def initialize(scenar)
    @scenario = scenar

  end

  def execute
    @scenario.execAsk(param);
  end
end
