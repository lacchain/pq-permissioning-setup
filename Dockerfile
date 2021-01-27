FROM node:lts-slim

WORKDIR /app/
RUN npm install truffle @truffle/hdwallet-provider

COPY contracts/ contracts/
COPY build/ build/
COPY migrations/ migrations/

RUN echo '#!/bin/sh\n\
set -x\n\
cat > /app/truffle-config.js <<_EOF_\n\
const HDWalletProvider = require("@truffle/hdwallet-provider");\n\
module.exports = {\n\
  networks: {\n\
    development: {\n\
      host: "${NODE_REMOTE_HOST}",\n\
      port: ${NODE_REMOTE_PORT},\n\
      network_id: "*",\n\
      gasPrice: 0,\n\
      provider: () => new HDWalletProvider("${ETHEREUM_SK}", "http://${NODE_REMOTE_HOST}:${NODE_REMOTE_PORT}")\n\
    }\n\
  },\n\
  compilers: {\n\
    solc: {\n\
      version: "0.6.5"\n\
    }\n\
  }\n\
};\n\
_EOF_\n\
\n\
cd /app/\n\
npx truffle migrate\n'\
>> /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
