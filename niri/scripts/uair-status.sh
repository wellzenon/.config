#!/usr/bin/env bash

percent=$(uairctl fetch '{percent}' 2>/dev/null || echo 100)

echo '0.'$(( 100 - "$percent" ))
