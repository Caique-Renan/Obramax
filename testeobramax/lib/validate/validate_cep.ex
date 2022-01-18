defmodule Testeobramax.Validates.ValidateCep do
    
  @spec call(cep :: String.t()) :: {:ok, String.t()} | {:error, atom()}
  def call(cep) do
    with {:ok, cep} <- validate_cep_format(cep),
         {:ok, cep} <- validate_cep_size(cep) do
      {:ok, cep}
    else
      error -> handle_error(error)
    end
  end

  @spec validate_cep_format(cep :: String.t()) :: {:ok, String.t()} | {:error, atom()}
  defp validate_cep_format(cep) do
    case Regex.match?(~r/^\d+$/, cep) do
      true -> {:ok, cep}
      false -> {:error, :invalid_cep_format}
    end
  end

  @spec validate_cep_size(cep :: String.t()) :: {:ok, String.t()} | {:error, atom()}
  defp validate_cep_size(cep) do
    case String.length(cep) == 8 do
      true -> {:ok, cep}
      false -> {:error, :invalid_cep_size}
    end
  end

  @spec handle_error({:error, atom()}) :: {:error, atom()}
  defp handle_error(error), do: error
end