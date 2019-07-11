class DocenteTaller

  attr_accessor :codigo_taller, :docente

  def initialize(codigo_taller, docente)
    @codigo_taller = codigo_taller
    @docente = docente
  end
end