defmodule Punto1 do
  def main do
    # Se solicita al usuario el peso del paquete
    peso =
      "Ingrese el peso del paquete en kg: "
      |> ingresar_peso()

    # Se solicita el tipo de cliente
    tipo =
      "Ingrese el tipo de cliente (1: corporativo, 2: estudiante, 3: regular): "
      |> ingresar_tipo()

    # Se solicita el tipo de servicio
    servicio =
      "Ingrese el servicio del paquete (1: express, 2: estandar): "
      |> ingresar_servicio()

    # Cálculos principales
    tarifa_base = determinar_tarifa(peso)
    descuento = determinar_descuento(tipo)
    recargo = determinar_recargo(servicio)

    {subtotal, total} = calcular_tarifa(tarifa_base, descuento, recargo)

    # Generar y mostrar mensaje final
    generar_mensaje(tarifa_base, descuento, subtotal, recargo, total)
    |> Util.mostrar_mensaje()
  end

  # ----------------------------
  # Entrada y validaciones
  # ----------------------------

  # Pide el peso y lo valida
  def ingresar_peso(mensaje) do
    Util.ingresar(mensaje, :real)
    |> validar_peso(mensaje)
  end

  # Peso válido si es mayor que 0
  def validar_peso(peso, _mensaje) when peso > 0, do: peso
  # Si no es válido, vuelve a pedirlo
  def validar_peso(_, mensaje) do
    Util.mostrar_error("El peso debe ser positivo")
    ingresar_peso(mensaje)
  end

  # Pide el tipo de cliente y valida con pattern matching
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

  # Pide el tipo de servicio y valida con pattern matching
  def ingresar_servicio(mensaje) do
    case Util.ingresar(mensaje, :entero) do
      1 -> :express
      2 -> :estandar
      _ ->
        Util.mostrar_error("Servicio del paquete inválido")
        ingresar_servicio(mensaje)
    end
  end

  # ----------------------------
  # Lógica de negocio
  # ----------------------------

  # Determina la tarifa según el peso
  def determinar_tarifa(peso) do
    cond do
      peso <= 1 -> 8000
      peso <= 5 -> 12000
      true -> 20000
    end
  end

  # Descuentos según el tipo de cliente
  def determinar_descuento(:corporativo), do: 0.15
  def determinar_descuento(:estudiante), do: 0.10
  def determinar_descuento(:regular), do: 0.0

  # Recargo según el servicio
  def determinar_recargo(:express), do: 0.25
  def determinar_recargo(:estandar), do: 0.0

  # Calcula subtotal y total final
  def calcular_tarifa(base, desc, rec) do
    subtotal = base - base * desc
    total = subtotal * (1 + rec)
    {subtotal, total}
  end

  # ----------------------------
  # Salida
  # ----------------------------

  # Genera mensaje de resumen con desglose
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

# Ejecuta el programa
Punto1.main()

