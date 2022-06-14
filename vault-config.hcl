storage "raft" {
    path = "/Users/adam.barcan/.dotfiles/data/vault"
    node_id = "raft_node_1"

    retry_join {
        leader_api_addr = "http://127.0.0.2:8100"
  }
}

listener "tcp" {
    address     = "0.0.0.0:8200"
    tls_disable = true
}

cluster_addr = "http://127.0.0.1:8201"
api_addr = "http://127.0.0.1:8200"

disable_mlock = true
