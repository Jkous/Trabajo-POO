class Docente

  attr_accessor :codigo, :nombre, :apellidos, :talleres

  def initialize (codigo, nombre, apellidos)
    @codigo = codigo
    @nombre = nombre
    @apellidos = apellidos
    @talleres = []
  end
  

end