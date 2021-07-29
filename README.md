![github workflow](https://github.com/thiagoesteves/usd2real/workflows/Elixir%20CI/badge.svg)
[![Erlang/OTP Release](https://img.shields.io/badge/Erlang-OTP--22.0-green.svg)](https://github.com/erlang/otp/releases/tag/OTP-22.0)

# Parse The Cambio UOL webpage

## How to generate the script

```
mix escript.build
```

## How it works

This script is going to parse an html page from the UOL webpage and print the current rate USD to REAL

```
./bin/usd2real
[Estados Unidos] 1,000 USD => 5,045 BRL [Brasil]
```


