class TallerTeorico < TallerAlumno
  
  def initialize(codigo_taller, alumno)
    super(codigo_taller, alumno)
  end

  def CalcularPromedioFinal
    return (eva1 * 0.25) + (eva2 * 0.25) + (examen_final * 0.5)
  end
end