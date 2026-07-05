#Asistencia - Ficha ADSO 3413974

Planteamiento general: Se requiere un sistema que permita registrar la asistencia de los aprendices de la ficha ADSO 3413974 de manera más eficiente (sin depender del uso de Sofia Plus)

##Requisitos

###Requisitos Funcionales

RF-01:

	Permitir el registro de asistencia mediante el código QR del carnet personal de cada aprendiz de la ficha ADSO 3413974

	####PreRequisito

		- El sistema debe tener acceso a la cámara del dispositivo
		- El aprendiz debe tener su carnet vigente

RF-02:

	Al registrar la asistencia, el sistema debe solicitar una fotografía del ambiente de formación tomada de frente

RF-03:

	El sistema debe permitir cargar el listado de aprendices de la ficha ADSO 3413974 directamente desde Sofia Plus, separados por saltos de línea, para que el sistema pueda identificarlos

RF-04:

	El sistema debe permitir consultar el reporte de asistencia de la ficha ADSO 3413974 por fecha o por ambiente de formación

###Requisitos No Funcional

RNF-01:

	Al registrar cada fotografía se deben guardar los metadatos (fecha, hora) para poder comparar y verificar que las fotografías sean distintas entre sí

RNF-02:

	Transcurrido un mes, las fotografías anteriores deben eliminarse automáticamente para liberar espacio de almacenamiento

RNF-03:

	El registro de asistencia debe completarse en menos de 5 segundos por aprendiz para no generar filas ni demoras al inicio de la jornada

##¿Que resuelve el sistema?
