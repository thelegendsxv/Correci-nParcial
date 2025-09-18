defmodule Punto2 do
  def main do
    salas = %{1 => 50, 2 => 20, 3 => 10, 4 => 30, 5 => 20}

    numero_sala = Util.ingresar("Ingrese el número de sala que desea reservar (1-5)", :entero)

    sillas_disponibles = Map.get(salas, numero_sala)

    cond do
      sillas_disponibles == nil ->
        Util.mostrar_mensaje("Sala inválida, intente nuevamente.\n")
        main()

      true ->
        cantidad_sillas = Util.ingresar("Ingrese el número de sillas que va a reservar", :entero)

        cond do
          cantidad_sillas <= 0 ->
            Util.mostrar_mensaje("El número de sillas debe ser mayor que cero.\n")
            main()

          cantidad_sillas > sillas_disponibles ->
            Util.mostrar_mensaje(
              "No puede reservar más de #{sillas_disponibles} sillas en la sala #{numero_sala}.\n"
            )

            main()

          true ->
            reservar_sillas(salas, numero_sala, cantidad_sillas)
            |> Util.mostrar_mensaje()
        end
    end
  end

  defp reservar_sillas(salas, numero_sala, cantidad_sillas) do
    sillas_disponibles = Map.get(salas, numero_sala)
    nuevas_sillas = sillas_disponibles - cantidad_sillas
    salas_actualizadas = %{salas | numero_sala => nuevas_sillas}

    "Reserva exitosa. En la sala #{numero_sala} ahora quedan #{nuevas_sillas} sillas.\nEstado actual: #{inspect(salas_actualizadas)}"
  end
end

Punto2.main()
