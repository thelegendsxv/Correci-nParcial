defmodule Punto3 do
  # Función principal: recibe la contraseña del usuario y encadena las validaciones
  def main do
    "Ingrese la contraseña: "
    |> Util.ingresar(:texto)   # Se pide la contraseña como texto
    |> String.trim()           # Se eliminan espacios al inicio y al final
    |> validar_tamanio()       # Validación 1: longitud mínima
    |> validar_mayuscula()     # Validación 2: al menos una mayúscula
    |> validar_numero()        # Validación 3: al menos un número
    |> validar_espacios()      # Validación 4: sin espacios internos
    |> generar_mensaje()       # Genera mensaje final según los errores
    |> IO.inspect()            # Muestra el resultado
  end

  # 1. Validar tamaño mínimo (al menos 8 caracteres)
  def validar_tamanio(contrasenia) do
    errores = []
    if String.length(contrasenia) < 8 do
      e1 = ["La contraseña debe tener al menos 8 caracteres" | errores]
      {e1, contrasenia}
    else
      {errores, contrasenia}
    end
  end

  # 2. Validar que tenga al menos una mayúscula
  # Se compara la contraseña original con su versión en minúsculas
  def validar_mayuscula({errores, contrasenia}) do
    if contrasenia == String.downcase(contrasenia) do
      e1 = ["La contraseña debe tener al menos 1 mayúscula" | errores]
      {e1, contrasenia}
    else
      {errores, contrasenia}
    end
  end

  # 3. Validar que contenga al menos un número
  # Se convierte la contraseña en lista de caracteres y se busca un dígito
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

  # 4. Validar que no tenga espacios en medio
  def validar_espacios({errores, contrasenia}) do
    if String.contains?(contrasenia, " ") do
      e1 = ["La contraseña no debe tener espacios" | errores]
      {e1, contrasenia}
    else
      {errores, contrasenia}
    end
  end

  # Generar mensaje final (sin usar join)
  # Si no hay errores, devuelve {:ok, "Contraseña segura"}
  # Si hay errores, devuelve {:error, lista_de_errores}
  def generar_mensaje({errores, _contrasenia}) do
    case errores do
      [] -> {:ok, "Contraseña segura"}
      _ -> {:error, errores}
    end
  end
end

# Inicia el programa
Punto3.main()
