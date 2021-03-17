pub contract PinnieToken {
    pub var totalSupply: UFix64
    pub var tokenName: String

    pub resource interface Provider {
        pub fun withdraw(amount: UFix64): @Vault {
            post {
                result.balance == UFix64(amount):
                    "Withdrawal amount must be the same as the balance of the withdrawn Vault"
            }
        }
    }

	  pub resource interface Receiver {
        pub fun deposit(from: @Vault)
    }

    pub resource interface Balance {
        pub var balance: UFix64
    }

    pub resource Vault: Provider, Receiver, Balance {
        pub var balance: UFix64

        init(balance: UFix64) {
            self.balance = balance
        }

        pub fun withdraw(amount: UFix64): @Vault {
            self.balance = self.balance - amount
            return <-create Vault(balance: amount)
        }
        
        pub fun deposit(from: @Vault) {
            self.balance = self.balance + from.balance
            destroy from
        }
    }

    pub fun createEmptyVault(): @Vault {
        return <-create Vault(balance: 0.0)
    }

    pub resource VaultMinter {
        pub fun mintTokens(amount: UFix64, recipient: Capability<&AnyResource{Receiver}>) {
            let recipientRef = recipient.borrow()
                ?? panic("Could not borrow a receiver reference to the vault")

            PinnieToken.totalSupply = PinnieToken.totalSupply + UFix64(amount)
            recipientRef.deposit(from: <-create Vault(balance: amount))
        }
    }

    init() {
        self.totalSupply = 30.0
        self.tokenName = "Pinnie"

        let vault <- create Vault(balance: self.totalSupply)
        self.account.save(<-vault, to: /storage/MainVault)

        self.account.save(<-create VaultMinter(), to: /storage/MainMinter)

        self.account.link<&VaultMinter>(/private/Minter, target: /storage/MainMinter)
    }
}
 
