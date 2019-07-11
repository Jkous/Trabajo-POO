class TallerBlended < TallerAlumno

  attr_accessor :examen_virtual

  def initialize(codigo_taller, alumno)
    super(codigo_taller, alumno)
    @examen_virtual = 0.0
  end

  def CalcularPromedioFinal
    return (eva1 * 0.15) + (eva2 * 0.15) + (examen_virtual * 0.2) + (examen_final * 0.5)
  end

  def AgregarNotas(eva1, eva2, examen_final, examen_virtual)
    super(eva1, eva2, examen_final)
    @examen_virtual = examen_virtual.to_f
  end
end