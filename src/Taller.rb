
class Taller
  attr_accessor :codigo, :nombre, :tipo, :alumnos_taller, :docentes_taller

  def initialize(codigo, nombre, tipo)
    @codigo = codigo
    @nombre = nombre
    @tipo = tipo
    @docentes_taller = []
    @alumnos_taller = []
  end

  def BuscarAlumno(codigo_alumno)
    for alumno_taller in @alumnos_taller
      return alumno_taller.alumno if alumno_taller.alumno.codigo == codigo_alumno
    end

    return nil
  end

  def BuscarAlumnoTaller(codigo_alumno)
    for alumno_taller in @alumnos_taller
      return alumno_taller if alumno_taller.alumno.codigo == codigo_alumno
    end

    return nil
  end

  def MatricularAlumno(alumno)
    
    return if !alumno

    if(BuscarAlumno(alumno.codigo)) then
      return nil
    end

    alumno_taller = TallerFactory.CrearAlumnoTaller(tipo, codigo, alumno)
    @alumnos_taller << alumno_taller

    return alumno_taller
  end

  def BuscarDocente(codigo_docente)
    for docente_taller in @docentes_taller
      return docente_taller.docente if docente_taller.docente.codigo == codigo_docente
    end

    return nil
  end

  def AgregarDocente(docente)
    return if !docente

    if(BuscarDocente(docente.codigo)) then
      return nil
    end

    docente_taller = DocenteTaller.new(codigo, docente)
    @docentes_taller << docente_taller

    return docente_taller
  end


end