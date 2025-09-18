defmodule Punto1 do
  def main do
    peso =
      "Ingrese el peso del paquete en kg: "
      |> ingresar_peso()

    tipo =
      "Ingrese el tipo de cliente (1: corporativo, 2: estudiante, 3: regular): "
      |> ingresar_tipo()

    servicio =
      "Ingrese el servicio del paquete (1: express, 2: estandar): "
      |> ingresar_servicio()

    tarifa_base = determinar_tarifa(peso)
    descuento = determinar_descuento(tipo)
    recargo = determinar_recargo(servicio)

    {subtotal, total} = calcular_tarifa(tarifa_base, descuento, recargo)

    generar_mensaje(tarifa_base, descuento, subtotal, recargo, total)
    |> Util.mostrar_mensaje()
  end

  def ingresar_peso(mensaje) do
    Util.ingresar(mensaje, :real)
    |> validar_peso(mensaje)
  end

  def validar_peso(peso, _mensaje) when peso > 0, do: peso
  def validar_peso(_, mensaje) do
    Util.mostrar_error("El peso debe ser positivo")
    ingresar_peso(mensaje)
  end

  def ingresar_tipo(mensaje) do
    case Util.ingresar(mensaje, :entero) do
      1 -> :corporativo
      2 -> :estudiante
      3 -> :regular
      _ ->
        Util.mostrar_error("Tipo de cliente inválido")
        ingresar_tipo(mensaje)
    end
  end

  def ingresar_servicio(mensaje) do
    case Util.ingresar(mensaje, :entero) do
      1 -> :express
      2 -> :estandar
      _ ->
        Util.mostrar_error("Servicio del paquete inválido")
        ingresar_servicio(mensaje)
    end
  end


  def determinar_tarifa(peso) do
    cond do
      peso <= 1 -> 8000
      peso <= 5 -> 12000
      true -> 20000
    end
  end

  def determinar_descuento(:corporativo), do: 0.15
  def determinar_descuento(:estudiante), do: 0.10
  def determinar_descuento(:regular), do: 0.0

  def determinar_recargo(:express), do: 0.25
  def determinar_recargo(:estandar), do: 0.0

  def calcular_tarifa(base, desc, rec) do
    subtotal = base - base * desc
    total = subtotal * (1 + rec)
    {subtotal, total}
  end

  def generar_mensaje(base, desc, subtotal, rec, total) do
    """
    La tarifa base fue de $#{base}
    El descuento fue de #{desc * 100}%
    Subtotal después del descuento: $#{subtotal}
    El recargo fue de #{rec * 100}%
    Total a pagar: $#{total}
    """
  end
end
Punto1.main()
