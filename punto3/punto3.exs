defmodule Punto3 do
  def main do
    "Ingrese la contraseña: "
    |> Util.ingresar(:texto)
    |> String.trim()
    |> validar_tamanio()
    |> validar_mayuscula()
    |> validar_numero()
    |> validar_espacios()
    |> generar_mensaje()
    |> IO.inspect()
  end

  # 1. Validar tamaño mínimo
  def validar_tamanio(contrasenia) do
    errores = []
    if String.length(contrasenia) < 8 do
      e1 = ["La contraseña debe tener al menos 8 caracteres" | errores]
      {e1, contrasenia}
    else
      {errores, contrasenia}
    end
  end

  # 2. Validar mayúscula usando String.downcase
  def validar_mayuscula({errores, contrasenia}) do
    if contrasenia == String.downcase(contrasenia) do
      e1 = ["La contraseña debe tener al menos 1 mayúscula" | errores]
      {e1, contrasenia}
    else
      {errores, contrasenia}
    end
  end


  def validar_numero({errores, contrasenia}) do
    caracteres = String.graphemes(contrasenia)
    tiene_numero = Enum.any?(caracteres, fn c -> c in ["0","1","2","3","4","5","6","7","8","9"] end)

    if tiene_numero do
      {errores, contrasenia}
    else
      e1 = ["La contraseña debe tener al menos 1 número" | errores]
      {e1, contrasenia}
    end
  end

  # 4. Validar que no tenga espacios usando String.contains?
  def validar_espacios({errores, contrasenia}) do
    if String.contains?(contrasenia, " ") do
      e1 = ["La contraseña no debe tener espacios" | errores]
      {e1, contrasenia}
    else
      {errores, contrasenia}
    end
  end

  # Generar el mensaje final SIN join
  def generar_mensaje({errores, _contrasenia}) do
    case errores do
      [] -> {:ok, "Contraseña segura"}
      _ -> {:error, errores}
    end
  end
end

Punto3.main()
