import PinataPartyContract from 0xf8d6e0586b0a20c7

transaction {
    prepare(acct: AuthAccount) {
        let collection <- PinataPartyContract.createEmptyCollection()

        acct.save<@PinataPartyContract.Collection>(<-collection, to: /storage/NFTCollection)

        log("Collection created for account")

        acct.link<&{PinataPartyContract.NFTReceiver}>(/public/NFTReceiver, target: /storage/NFTCollection)

        log("Capability created")
    }
}