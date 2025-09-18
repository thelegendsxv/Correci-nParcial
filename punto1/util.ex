defmodule Util do
  @moduledoc """
  Módulo de utilidades para entrada y salida de datos en consola.
  """

  @doc """
  Muestra un mensaje en la consola estándar.
  """
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  @doc """
  Muestra un mensaje de error en la consola de errores.
  """
  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  @doc """
  Solicita al usuario que ingrese un texto.
  """
  def ingresar(mensaje, :texto) do
    IO.gets(mensaje <> ": ")
    |> String.trim()
  end

  @doc """
  Solicita al usuario que ingrese un número entero.
  """
  def ingresar(mensaje, :entero), do: ingresar(mensaje, &String.to_integer/1, :entero)

  @doc """
  Solicita al usuario que ingrese un número real (flotante).
  """
  def ingresar(mensaje, :real), do: ingresar(mensaje, &String.to_float/1, :real)

  @doc false
  defp ingresar(mensaje, parser, tipo_dato) do
    try do
      mensaje
      |> ingresar(:texto)
      |> parser.()
    rescue
      ArgumentError ->
        IO.puts(:standard_error, "Error, se espera que ingrese un número #{tipo_dato}\n")
        mensaje
        |> ingresar(parser, tipo_dato)
    end
  end
end
