
require 'singleton'

class Universidad

  attr_accessor :lista_alumnos, :lista_docentes, :lista_talleres, :alumnos_taller, :docentes_taller

  def initialize
    @lista_alumnos = []
    @lista_docentes = []
    @lista_talleres = []
    @alumnos_taller = []
    @docentes_taller = []
  end
  
  include Singleton

  #Metodos de registro
  def RegistrarAlumno(alumno)

    if(!BuscarAlumno(alumno.codigo)) then
      lista_alumnos << alumno
      return "Alumno registrado"
    else
      return "Ya existe un alumno con el codigo #{alumno.codigo}"
    end
  end

  def RegistrarDocente(docente)

    if(!BuscarDocente(docente.codigo)) then
      lista_docentes << docente
      return "Docente registrado con exito"
    else
      return "Ya existe un docente con el codigo #{docente.codigo}"
    end
  end

  def RegistrarTaller(taller)
    if(!BuscarTaller(taller.codigo)) then
      lista_talleres << taller
      return "Taller creado con exito"
    else
      return "Ya existe el taller con el codigo #{taller.codigo}"
    end
  end

  #Metodos de busqueda segun codigo
  def BuscarTaller(codigo_taller)
    for taller in lista_talleres
      return taller if codigo_taller == taller.codigo
    end

    return nil
  end

  def BuscarDocente(codigo_docente)
    for docente in lista_docentes
      return docente if codigo_docente == docente.codigo
    end

    return nil
  end

  def BuscarAlumno(codigo_alumno)
    for alumno in lista_alumnos
      return alumno if codigo_alumno == alumno.codigo
    end

    return nil
  end

  #Metodos de listado para menu
  def ListarTalleres()
    resp = ""
    resp += "\nCódigo".ljust(10)
    resp += "Taller"
    resp += "\n----------------------"
    for taller in lista_talleres
      resp+= "\n[#{taller.codigo}] -".ljust(10)
      resp+= "#{taller.nombre}"
    end

    return resp + "\n\n"
  end

  def ListarAlumnos()
    
    resp = ""
    resp += "Código".ljust(20)
    resp += "Alumno".ljust(10)
    for alumno in lista_alumnos
      resp += "\n  [#{alumno.codigo}]".ljust(20)
      resp += "   #{alumno.apellidos}, #{alumno.nombres}"
    end

    return resp
  end

  def ListarDocentes()
    resp = ""
    resp += "  Código".ljust(20)
    resp += "Docente".ljust(10)
    for i in 0...lista_docentes.size
      resp += "\n  [#{lista_docentes[i].codigo}]".ljust(20)
      resp += " #{lista_docentes[i].apellidos}, #{lista_docentes[i].nombre}"
    end

    return resp
  end

  #Metodos de vincular alumnos y docentes con taller
  #think
  def AsignarTallerDocente(docente_taller)

    #Verificar si el docente ya está registrado (lista_global)
    if(BuscarDocenteTaller(docente_taller.codigo_taller, docente_taller.docente.codigo)) then
      return
    end

    docentes_taller << docente_taller if docente_taller
  end
  
  #think
  def BuscarDocenteTaller(codigo_taller, codigo_docente)

    for dt in docentes_taller
      return dt if dt.codigo_taller == codigo_taller && dt.docente.codigo == codigo_docente
    end

    return nil
  end

  #think
  def AgregarAlumnoTaller(alumno_taller)

    #Verificar si el alumno ya está registrado (lista_global)
    if(BuscarAlumnoTaller(alumno_taller.codigo_taller, alumno_taller.alumno.codigo))
      return
    end

    alumnos_taller << alumno_taller if alumno_taller
  end

  #think
  def BuscarAlumnoTaller(codigo_taller, codigo_alumno)
    for alum_taller in alumnos_taller
      return alum_taller if alum_taller.codigo_taller == codigo_taller && alum_taller.alumno.codigo == codigo_alumno
    end

    return nil
  end


  ##### Area de reportes o listado
  def ReporteAlumnosTaller(taller)

    resp = ""
    resp += "Alumno".ljust(25)
    resp += "Eva. 1".ljust(10)
    resp += "Eva. 2".ljust(10)
    resp += "Exá. final".ljust(13)
    resp += "Eva. Virtual".ljust(15) if taller.tipo == "B"
    resp += "Promedio Final".ljust(15)
    for ta in taller.alumnos_taller
      resp += "\n" + ta.alumno.nombres.ljust(25)
      resp += ta.eva1.to_s.ljust(10)
      resp += ta.eva2.to_s.ljust(10)
      resp += ta.examen_final.to_s.ljust(13)
      resp += ta.examen_virtual.to_s.ljust(15) if taller.tipo == "B"
      resp += ta.CalcularPromedioFinal().round(2).to_s.ljust(15)

      
    end

    return resp
  end

  def ListarTalleresDocentes()
    resp = "Listar todos los talleres de todos los docentes\n"
    
    resp += "Cód. Docente".ljust(17)
    resp += "Apellidos, Nombres".ljust(25)
    resp += "Cód. Taller".ljust(15)
    resp += "Taller".ljust(20)
    resp += "\n----------------------------------------------------------------------------"

    for taller in lista_talleres
      for dt in taller.docentes_taller
        resp += "\n" + taller.codigo.ljust(25)
        resp += taller.nombre.ljust(15)
        resp += dt.docente.codigo.ljust(15)
        resp += dt.docente.nombre.ljust(20)
      end
    end

    # for dt in docentes_taller
    #   resp += "\n" + dt.docente.codigo.ljust(17)
    #   resp += dt.docente.nombre.ljust(25)
    #   resp += dt.taller.codigo.ljust(15)
    #   resp += dt.taller.nombre.ljust(20)
    # end


    return resp
  end

  def ListarCursosMatriculados(codigo_alumno)
    resp = "Cursos matriculados del alumno\n"
    
    alumno = BuscarAlumno(codigo_alumno)

    # for talleres in alumnos_taller
    #   if talleres.alumno.codigo == codigo_alumno
    #     resp += talleres.taller.codigo.ljust(10)
    #     resp += talleres.alumno.nombres.ljust(20)
    #     resp += talleres.taller.nombre.ljust(25) + "\n"
    #   end
    # end

    for taller in lista_talleres
      for at in taller.alumnos_taller
        if at.alumno.codigo == codigo_alumno then
          resp += at.alumno.codigo.ljust(15)
          resp += taller.nombre.ljust(20)
          resp += at.alumno.nombres.ljust(25) + "\n"
          break
        end
      end
    end

    return resp
  end


  def BuscarTalleresDocente(codigo_docente)

    talleres_docente = []

    for taller in lista_talleres
      docente = taller.BuscarDocente(codigo_docente)

      if docente then
        talleres_docente << taller
      end
    end

    return talleres_docente
  end

  def BuscarTalleresAlumno(codigo_alumno)

    talleres_alumno = []

    for taller in lista_talleres
      alumno_taller = taller.BuscarAlumnoTaller(codigo_alumno)

      if alumno_taller then
        talleres_alumno << alumno_taller
      end
    end

    return talleres_alumno
  end


  ##### MENU PRINCIPAL
  def MostrarMenu
    puts "Sistema de talleres UPC"
    puts "=========================================="
    
    puts "\nTalleres"
    puts "-----------------------------------"
    puts "1.\tCrear taller"
    puts "2.\tListar talleres"
    puts "3.\tAsignar docente a taller"
    puts "4.\tMatricular alumno a taller"
    
    puts "\nDocentes"
    puts "-----------------------------------"
    puts "5.\tRegistrar Docente"
    puts "6.\tVer talleres del docente"
    #puts "\tReporte docentes en talleres"
    
    puts "\nAlumnos"
    puts "-----------------------------------"
    puts "7.\tRegistrar Alumno"
    puts "8.\tVer talleres del alumno"

    print "\nElija la opción a realizar: "
    opcion = gets.chomp

    puts ""
    case opcion
    when "1" then
      puts ">>>Crear Taller"
      MenuCrearTaller()
    when "2" then
      puts ">>>Listar Talleres"
      ReporteTalleres()
    when "3" then
      puts ">>>Asignar docente a taller"
      MenuAsignarDocenteTaller()
    when "4" then
      puts ">>>Matricular alumno a taller" 
      MenuMatricularAlumno()
    when "5" then
      puts ">>>Registrar docente"
      MenuRegistrarDocente()
    when "6" then
      puts ">>>Docentes registrados:"
      MenuTalleresDocente()
    when "7" then
      puts ">>>Registrar alumno"
      MenuRegistrarAlumno()
    when "8" then
      puts ">>>Listar alumnos"
      Reportealumnos()
    else
      puts "Opción incorrecta, seleccione nuevamente..."
    end

    print "\nPulse Enter para continuar..."
    gets
  end

  def MenuCrearTaller
    resp = "S"
    loop do

      print "Código del taller: "
      codigo_taller = gets.chomp

      print "Nombre del taller: "
      nombre_taller = gets.chomp

      puts "Ingrese el tipo de taller"
      puts "(T)eórico (defecto)"
      puts "(P)ráctico"
      puts "(B)lended"
      print "Tipo: "
      tipo = gets.chomp.upcase

      case tipo
      when "P" then
        tipo = "P"
      when "B" then
        tipo = "B"
      else
        tipo = "T"
      end

      taller = Taller.new(codigo_taller, nombre_taller, tipo)

      puts ""
      puts RegistrarTaller(taller)

      print "Desea registrar otro taller (S/N): "
      resp = gets.chomp.upcase
      break if(resp != "S")
    end
  end


  def ReporteTalleres()
    #puts "Seleccione el taller:"
    puts ListarTalleres()

    print "Ingrese código del taller: "
    codigo_taller = gets.chomp

    taller = BuscarTaller(codigo_taller)

    if taller
      puts ReporteAlumnosTaller(taller)
    else
      puts "Taller no encontrado..." if !taller
    end
    
  end

  def AgregarNotas(taller)

    loop do
      puts ListarAlumnos()

      print "Ingrese el codigo del alumno"
      codigo_alumno = gets.chomp

      alumno_taller = taller.BuscarAlumno(codigo_alumno)

      if alumno_taller
        print "Ingrese las nota de Evaluación 1: "
        eva1 = gets.to_f
        print "Ingrese las nota de Evaluación 2: "
        eva2 = gets.to_f
        print "Ingrese las nota del examen final: "
        examen_final = gets.to_f

        if taller.tipo == "B" then
          print "Ingrese las nota de la evaluación virtual: "
          eva_virtual = gets.to_f
          alumno_taller.AgregarNotas(eva1, eva2, examen_final, eva_virtual)
        else
          alumno_taller.AgregarNotas(eva1, eva2, examen_final)
        end

      else
        puts "Alumno no matriculado en este taller"
      end

      print "Desea agregar otra nota (S/N): "
      resp = gets
      break if resp != "S"
    end

  end

  def MenuAsignarDocenteTaller()
    puts "Seleccione el código del taller:"
    puts ListarTalleres()

    codigo_taller = gets.chomp
    
    taller = BuscarTaller(codigo_taller)

    if !taller then
      puts "Taller no encontrado."
      return
    end


    puts "Docente: #{taller.nombre}"

    resp = "S"
    loop do
      puts "lista de docentes:"
      puts ListarDocentes()
      
      print "Ingrese código del docente: "
      codigo_docente = gets.chomp

      docente = BuscarDocente(codigo_docente)

      if docente then

        docente_taller = taller.AgregarDocente(docente)

        if !docente_taller
          puts "El docente ya se encuentra registrado en el taller de #{taller.nombre}"
        else
          AsignarTallerDocente(docente_taller)
          puts "Docente #{docente.nombre} asignado al taller de #{taller.nombre}"
        end

      else
        puts "Docente no encontrado."
      end

      print "Desea agregar otro docente al taller (S/N): "
      resp = gets.chomp.upcase
      break if resp != "S"
    end
  end

  def MenuMatricularAlumno()
    puts "Seleccione el código del taller:"
    puts ListarTalleres()

    codigo_taller = gets.chomp
    
    taller = BuscarTaller(codigo_taller)

    if !taller then
      puts "Taller no encontrado."
      return
    end

    puts "Taller: #{taller.nombre}"
    resp = "S"
    
    loop do
      print "Ingrese codigo del alumno: "
      codigo_alumno = gets.chomp

      #puts MatricularAlumnoTaller(codigo_alumno, codigo_taller)
      alumno = BuscarAlumno(codigo_alumno)

      if alumno then

        alumno_taller = taller.MatricularAlumno(alumno)

        if !alumno_taller
          puts "El alumno ya se encuentra registrado en el taller de #{taller.nombre}"
        else
          AgregarAlumnoTaller(alumno_taller)
          puts "Alumno #{alumno.nombres} matriculado en el taller de #{taller.nombre}"
        end

      else
        puts "Alumno no encontrado."
      end

      print "Desea agregar otro alumno al taller (S/N): "
      resp = gets.chomp.upcase
      break if resp != "S"
    end
  end

  def MenuRegistrarDocente
    resp = "S"
    loop do
      print "Código del docente: "
      codigo = gets.chomp

      print "Nombres: "
      nombres = gets.chomp

      print "Apellidos: "
      apellidos = gets.chomp

      docente = Docente.new(codigo, nombres, apellidos)

      puts ""
      puts RegistrarDocente(docente)

      print "Desea registrar otro docente (S/N): "
      resp = gets.chomp.upcase
      break if(resp != "S")
    end
  end

  def MenuTalleresDocente()
    puts ListarDocentes()

    print "\nIngrese el código del docente: "
    codigo_docente = gets.chomp

    docente = BuscarDocente(codigo_docente)

    if !docente
      print "Docente no encontrado"
      return
    end
    talleres = BuscarTalleresDocente(codigo_docente)
    puts "\nCódigo\t:  #{docente.codigo}"
    puts "Docente\t:  #{docente.apellidos}, #{docente.nombre}"
    puts "Talleres:  #{talleres.size.to_s}"
    puts "\n======================================================="
    print "Código".ljust(15)
    print "Curso".ljust(20)
    print "N° de alumnos".ljust(20)
    puts "\n======================================================="

    for taller in talleres
      print "\n" + taller.codigo.ljust(15)
      print taller.nombre.ljust(20)
      print taller.alumnos_taller.size.to_s.ljust(20)
    end

  end

  def MenuRegistrarAlumno
    resp = "S"
    loop do
      print "Código del alumno: "
      codigo = gets.chomp

      print "Nombres: "
      nombres = gets.chomp

      print "Apellidos: "
      apellidos = gets.chomp

      alumno = Alumno.new(codigo, nombres, apellidos)

      puts ""
      puts RegistrarAlumno(alumno)
      
      print "Desea registrar otro alumno (S/N): "
      resp = gets.chomp.upcase
      break if(resp != "S")
    end
  end

  def Reportealumnos()
    puts ListarAlumnos()

    print "\nIngrese el código del alumno: "
    codigo_alumno = gets.chomp

    alumno = BuscarAlumno(codigo_alumno)

    if !alumno
      print "Alumno no encontrado"
      return
    end

    talleres_alumno = BuscarTalleresAlumno(codigo_alumno)
    puts "\nCódigo\t:  #{alumno.codigo}"
    puts "Docente\t:  #{alumno.apellidos}, #{alumno.nombres}"
    puts "Talleres:  #{talleres_alumno.size.to_s}"
    puts "\n======================================================="
    print "Código".ljust(10)
    print "Curso".ljust(20)
    print "Tipo taller".ljust(15)
    print "Eva. 1".ljust(8)
    print "Eva. 2".ljust(8)
    print "Final".ljust(8)
    print "Virtual".ljust(8)
    puts "\n======================================================="

    for ta in talleres_alumno
      taller = BuscarTaller(ta.codigo_taller)
      print "\n" + taller.codigo.ljust(10)
      print taller.nombre.ljust(20)
      print ta.class.to_s.ljust(15)
      print ta.eva1.to_s.ljust(8)
      print ta.eva2.to_s.ljust(8)
      print ta.examen_final.to_s.ljust(8)
      if taller.tipo == "B"
        print ta.examen_virtual.to_s.ljust(8)
      else
        print "-".ljust(8)
      end
      print ta.CalcularPromedioFinal.round(2).to_s.ljust(7)
      
    end
  end
  

end

uni = Universidad.instance



t1 = Taller.new('b0001','Mate discreta','B')
t2 = Taller.new('b0002','Diseño de procesos','B')
t3 = Taller.new('t0001','Fisica I','T')
t4 = Taller.new('t0002','Fisica II', 'T')
t5 = Taller.new('p0001','Calculo I', 'P')
t6 = Taller.new('p0002','Calculo II', 'P')
uni.RegistrarTaller(t1)
uni.RegistrarTaller(t2)
uni.RegistrarTaller(t3)
uni.RegistrarTaller(t4)
uni.RegistrarTaller(t5)
uni.RegistrarTaller(t6)

alumno01 = Alumno.new("u201814897","Jorge Martin","Muñoz Feliciano")
alumno02 = Alumno.new("u20181a111","Juan Francisco","Valencia Martinez")
alumno03 = Alumno.new("u201735633","Erika","Perez")
uni.RegistrarAlumno(alumno01)
uni.RegistrarAlumno(alumno02)
uni.RegistrarAlumno(alumno03)

docente01 = Docente.new("p67138388","Miguel Angel","Martinez Sosa")
docente02 = Docente.new("p67138323","Rosa","Melgarejo Sánzhez")
docente03 = Docente.new("p67136578","Nestor","Villanueva Caceres")
docente04 = Docente.new("p67135682","Piter","Rodriguez Rojas")
uni.RegistrarDocente(docente01)
uni.RegistrarDocente(docente02)
uni.RegistrarDocente(docente03)


docente_taller = t1.AgregarDocente(docente01)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t1.AgregarDocente(docente02)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t2.AgregarDocente(docente03)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t4.AgregarDocente(docente01)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t4.AgregarDocente(docente02)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t5.AgregarDocente(docente02)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t5.AgregarDocente(docente01)
uni.AsignarTallerDocente(docente_taller)
docente_taller = t6.AgregarDocente(docente03)
uni.AsignarTallerDocente(docente_taller)


alumno_taller = t1.MatricularAlumno(alumno01)
alumno_taller.AgregarNotas(20, 17, 18, 15)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t2.MatricularAlumno(alumno01)
alumno_taller.AgregarNotas(16.3, 17, 18, 13)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t3.MatricularAlumno(alumno01)
alumno_taller.AgregarNotas(15, 17, 18)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t4.MatricularAlumno(alumno02)
alumno_taller.AgregarNotas(17, 17, 18)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t5.MatricularAlumno(alumno02)
alumno_taller.AgregarNotas(18, 17, 18)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t5.MatricularAlumno(alumno03)
alumno_taller.AgregarNotas(19, 17, 18)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t3.MatricularAlumno(alumno03)
alumno_taller.AgregarNotas(16.4, 17, 18)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t1.MatricularAlumno(alumno03)
alumno_taller.AgregarNotas(20, 17, 18, 18)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t2.MatricularAlumno(alumno03)
alumno_taller.AgregarNotas(20, 17, 18, 14)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t1.MatricularAlumno(alumno02)
alumno_taller.AgregarNotas(20, 17, 18, 14)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t2.MatricularAlumno(alumno02)
alumno_taller.AgregarNotas(20, 17, 18, 16)
uni.AgregarAlumnoTaller(alumno_taller)
alumno_taller = t5.MatricularAlumno(alumno01)
alumno_taller.AgregarNotas(20, 17, 18)
uni.AgregarAlumnoTaller(alumno_taller)



#uni.Reportealumnos()
puts "\n"

while true
  uni.MostrarMenu
end
