
class TallerFactory

  def self.CrearAlumnoTaller(tipo_taller, codigo_taller, alumno)
    case tipo_taller
    when 'T' then
      return TallerTeorico.new(codigo_taller, alumno)
    when 'P' then
      return TallerPractico.new(codigo_taller, alumno)
    when 'B' then
      return TallerBlended.new(codigo_taller, alumno)
    else
      return nil
    end
  end


end