defmodule Usd2realTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO
  import Usd2real, only: [main: 1]

  test "--help call for help" do
    fun = fn -> main(["--help"]) end

    expected =
      "synopsis:\n  This script is going to parse an html page from UOL cambio on-line and print the\n  current USD => BRL rate.\n\nusage:\n  ./bin/usd2real --url \"https://economia.uol.com.br/cotacoes/cambio/\" --filename \"test.txt\"\noptions:\n  --filename File with the html contents [optional]\n  --url      Url to capture the data [optional]\n\n"

    actual = capture_io(:stdio, fun)
    assert actual == expected
  end

  test "request USD REAL convertion" do
    fun = fn -> main(["--filename", "test/test.txt"]) end

    expected = " ¯\\_(ツ)_/¯ [Estados Unidos] 1,000 USD => 5,056 BRL [Brasil]\n"

    actual = capture_io(:stdio, fun)
    assert actual == expected
  end
end
