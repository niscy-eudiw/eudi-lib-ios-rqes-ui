SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"

# Run Cuckoo Script
"${SCRIPT_PATH}/run" --configuration "${SCRIPT_PATH}/CuckooConfig.toml"