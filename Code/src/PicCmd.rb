class PicCmd
  attr_reader :scenario

  def initialize(scenar)
    @scenario = scenar

  end

  def execute(param)
    @scenario.execPic(param)
  end
end
