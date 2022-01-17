defmodule Testeobramax do
  @moduledoc """
  Validacao de CEP e preco baseado na viagem adicionada
  """

  def Validations do    
    @Validations
  end

  def validate_methods(cep, price, methods) do
    methods
    |> Enum.map(&validate_method(cep, price, &1))
  end

  def validate_method(cep, price, %{"name" => name} = method) do
    incompatibilities = find_incompatibilities(cep, price, method)
    valid = Enum.empty?(imcompatibilities)

    %{
    name: name,
    valid: valid,
    incompatibilities: incompatibilities
    }
  end

  def find_incompatibilities(cep, price, method) do
  @Validations
  |> Map.keys()
  |> Enum.map(&validate_incompatibilitity(&1, cep, method))
  |> Enum.reject(&(&1 == true))
  end

  defp validate_incompatibilitity(validation_name, cep, price, method) do
    if apply(__MODULE__, validation_name, [cep, price, method]) do
    true
    else
      @validations[validation_name]
    end
  end

  def validate_active(_cep, _price, %{"active" => active}) do
    active
  end

  def validate_min_price(_cep, price, %{"min_price_in_cents" => min_price_in_cents}) do
    price >= min_price_in_cents
  end

  def validate_range_postcode(cep, _price, %{
    "range_postcode_valid" => [min_postcode, max_postcode | _]
    }) do
    cep >= String.to_integer(min_postcode) and cep <= String.to_integer(max_postcode)
  end
 
end
