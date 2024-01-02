import {
  Approval as ApprovalEvent,
  ApprovalForAll as ApprovalForAllEvent,
  Minted as MintedEvent,
  Transfer as TransferEvent,
} from "../generated/BasicNft/BasicNft";
import { Minted, Transfer } from "../generated/schema";

export function handleMinted(event: MintedEvent): void {
  let entity = new Minted(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  );
  entity.mintee = event.params.mintee;
  entity.tokenId = event.params.tokenId;
  entity.tokenUri = event.params.tokenUri;

  entity.blockNumber = event.block.number;
  entity.blockTimestamp = event.block.timestamp;
  entity.transactionHash = event.transaction.hash;

  entity.save();
}

export function handleTransfer(event: TransferEvent): void {
  let entity = new Transfer(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  );
  entity.from = event.params.from;
  entity.to = event.params.to;
  entity.tokenId = event.params.tokenId;

  entity.blockNumber = event.block.number;
  entity.blockTimestamp = event.block.timestamp;
  entity.transactionHash = event.transaction.hash;

  entity.save();
}
