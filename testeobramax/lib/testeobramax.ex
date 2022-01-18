defmodule Testeobramax do
  @moduledoc """
  Validacao de CEP e preco baseado na viagem adicionada
  """

  alias Testeobramax.Core.HandleInputData
  alias Testeobramax.Core.OutputShippingItem
  alias Testeobramax.Validates.ValidateCep
  alias Testeobramax.Validates.ValidateInputFile

  @spec run_validate(opts :: Keyword.t()) :: {:ok, [OutputShippingItem.t()]} | {:error, any()}
  def run_validate(opts \\ []) do
    cep = Keyword.get(opts, :cep)
    price = Keyword.get(opts, :price)

    with {:ok, cep} <- ValidateCep.call(cep),
         {:ok, input_data} <- ValidateInputFile.call(opts),
         output_data <- HandleInputData.call(input_data, cep, price) do
      {:ok, output_data}
    else
      error -> error
    end
  end
end
