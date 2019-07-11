
class TallerAlumno

  attr_accessor :codigo_taller, :alumno, :eva1, :eva2, :examen_final

  def initialize(codigo_taller, alumno)
    @codigo_taller = codigo_taller
    @alumno = alumno
    #@taller = taller
    @eva1 = 0.0
    @eva2 = 0.0
    @examen_final = 0.0
  end

  def CalcularPromedioFinal
    raise "Metodo no definido"
  end

  def AgregarNotas(eva1, eva2, examen_final)
    @eva1 = eva1.to_f
    @eva2 = eva2.to_f
    @examen_final = examen_final.to_f
  end
end
