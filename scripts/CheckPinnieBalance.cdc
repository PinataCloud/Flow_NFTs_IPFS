import PinnieToken from 0xf8d6e0586b0a20c7
pub fun main(): UFix64 {
    let acct1 = getAccount(0xf8d6e0586b0a20c7)

    let acct1ReceiverRef = acct1.getCapability<&PinnieToken.Vault{PinnieToken.Balance}>(/public/MainReceiver)
        .borrow()
        ?? panic("Could not borrow a reference to the acct1 receiver") 

    log("Account 1 Balance")
    log(acct1ReceiverRef.balance)
    return acct1ReceiverRef.balance
}