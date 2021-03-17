import {config} from "@onflow/fcl"
config()
  .put("accessNode.api", process.env.REACT_APP_ACCESS_NODE) // Configure FCLs Access Node
  .put("challenge.handshake", process.env.REACT_APP_WALLET_DISCOVERY) // Configure FCLs Wallet Discovery mechanism
  .put("0xProfile", process.env.REACT_APP_CONTRACT_PROFILE) // Will let us use `0xProfile` in our cadence