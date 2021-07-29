defmodule Usd2real do
  @moduledoc """
  synopsis:
    This script is going to parse an html page from UOL cambio on-line and print the
    current USD => BRL rate.

  usage:
    ./bin/usd2real --url "https://economia.uol.com.br/cotacoes/cambio/" --filename "test.txt"
  options:
    --filename File with the html contents [optional]
    --url      Url to capture the data [optional]
  """

  # ----------------------------------------------------------------------------
  # Module require/uses/imports
  # ----------------------------------------------------------------------------
  require Logger

  # ----------------------------------------------------------------------------
  # Local defines
  # ----------------------------------------------------------------------------
  @uol_cambio_url "https://economia.uol.com.br/cotacoes/cambio/"

  # ----------------------------------------------------------------------------
  # Public test API's
  # ----------------------------------------------------------------------------

  def main([help_opt]) when help_opt == "-h" or help_opt == "--help" do
    IO.puts(@moduledoc)
  end

  @spec main([binary]) :: :ok
  def main(args) do
    args
    |> parse_args
    |> execute
  end

  defp parse_args(args) do
    {opts, _value, _} =
      args
      |> OptionParser.parse(switches: [url: :string, filename: :string])

    opts
  end

  def execute(opts) do
    url = opts[:url] || nil
    filename = opts[:filename] || nil

    run(filename, url)
  end

  defp run(nil, nil) do
    {:ok, resp} = Tesla.get(@uol_cambio_url)
    run(resp.body)
  end

  defp run(nil, url) do
    {:ok, resp} = Tesla.get(url)
    run(resp.body)
  end

  defp run(filename, _) do
    file = File.read!(filename)
    run(file)
  end

  defp run(file) do
    parsed_doc = file |> Floki.parse_document!()

    country1 = parsed_doc |> Floki.find(".currency-field1") |> capture_country_info

    country2 = parsed_doc |> Floki.find(".currency-field2") |> capture_country_info

    IO.puts(
      "[#{country1.name}] #{country1.value} #{country1.code} => #{country2.value} #{country2.code} [#{
        country2.name
      }]"
    )
  end

  defp capture_country_info(document) do
    [{"input", [{"class", "field normal"}, _, {"value", value}, _], _}] =
      document |> Floki.find("input.field*")

    [
      {"span", [{"class", "final-term"}, _],
       [
         _,
         {"strong", [{"class", "country-name"}], [name]},
         _,
         {"span", _, [code]}
       ]}
    ] = document |> Floki.find(".final-term")

    %{name: name, value: value, code: code}
  end
end
