#En este ejercicio hice el ejercicio normal, pero quería que tuviera una mejor implementación
#se le añade recursividad para que el código se vea mas completo
defmodule Punto2 do
  # Función principal: controla todo el flujo de la reserva de salas
  def main do
    # Se define un mapa con las salas y sus sillas disponibles
    salas = %{1 => 50, 2 => 20, 3 => 10, 4 => 30, 5 => 20}

    # Se pide al usuario la sala que desea reservar
    numero_sala = Util.ingresar("Ingrese el número de sala que desea reservar (1-5)", :entero)

    # Se obtiene la cantidad de sillas disponibles en la sala seleccionada
    sillas_disponibles = Map.get(salas, numero_sala)

    cond do
      # Caso: sala inexistente
      sillas_disponibles == nil ->
        Util.mostrar_mensaje("Sala inválida, intente nuevamente.\n")
        main()#recursividad

      true ->
        # Se pide al usuario la cantidad de sillas a reservar
        cantidad_sillas = Util.ingresar("Ingrese el número de sillas que va a reservar", :entero)

        cond do
          # Caso: número de sillas no válido
          cantidad_sillas <= 0 ->
            Util.mostrar_mensaje("El número de sillas debe ser mayor que cero.\n")
            main()#recursividad

          # Caso: reserva mayor al número de sillas disponibles
          cantidad_sillas > sillas_disponibles ->
            Util.mostrar_mensaje(
              "No puede reservar más de #{sillas_disponibles} sillas en la sala #{numero_sala}.\n"
            )
            main()#recursividad

          # Caso: reserva válida
          true ->
            reservar_sillas(salas, numero_sala, cantidad_sillas)
            |> Util.mostrar_mensaje()
        end
    end
  end

  # Función privada: actualiza la cantidad de sillas disponibles en la sala
  defp reservar_sillas(salas, numero_sala, cantidad_sillas) do
    sillas_disponibles = Map.get(salas, numero_sala)
    nuevas_sillas = sillas_disponibles - cantidad_sillas

    # Se crea un nuevo mapa con las sillas actualizadas
    salas_actualizadas = %{salas | numero_sala => nuevas_sillas}

    # Mensaje de confirmación
    "Reserva exitosa. En la sala #{numero_sala} ahora quedan #{nuevas_sillas} sillas.\n" <>
    "Estado actual: #{inspect(salas_actualizadas)}"
  end
end

# Inicia el programa
Punto2.main()
