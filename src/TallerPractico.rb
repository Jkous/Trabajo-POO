class TallerPractico < TallerAlumno

  def initialize(codigo_taller, alumno)
    super(codigo_taller, alumno)
  end

  def CalcularPromedioFinal
    return (eva1 * 0.2) + (eva2 * 0.2) + (examen_final * 0.6)
  end

end