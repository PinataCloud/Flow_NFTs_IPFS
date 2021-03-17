import MarketplaceContract from 0xf8d6e0586b0a20c7

pub fun main(): UFix64? {
    let account1 = getAccount(0xf8d6e0586b0a20c7)

    let acct1saleRef = account1.getCapability<&AnyResource{MarketplaceContract.SalePublic}>(/public/NFTSale)
        .borrow()
        ?? panic("Could not borrow acct2 nft sale reference")

    log("Account 1 NFTs for sale")
    log(acct1saleRef)
    log("Price")
    log(acct1saleRef.idPrice(tokenID: 1))
    return acct1saleRef.idPrice(tokenID: 1)
}