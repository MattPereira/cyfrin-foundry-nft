// import { useEffect, useState } from "react";
import type { NextPage } from "next";
import { MetaHeader } from "~~/components/MetaHeader";

// import { useScaffoldContractRead, useScaffoldEventHistory } from "~~/hooks/scaffold-eth/";

const Home: NextPage = () => {
  // const [basicNftTokenIds, setBasicNftTokenIds] = useState<bigint[]>([]);
  // const [tokenUris, setTokenUris] = useState<string[]>([]);

  // const { data: events, isLoading: isLoadingEvents } = useScaffoldEventHistory({
  //   contractName: "BasicNft",
  //   eventName: "Transfer",
  //   fromBlock: 31231n,
  //   watch: true,
  //   // "from" the zero address is a mint of new nft!
  //   filters: { from: "0x0000000000000000000000000000000000000000" },
  // });

  // const fetchTokenUri = async (tokenId: bigint) => {
  //   const { data: tokenUri } = useScaffoldContractRead({
  //     contractName: "BasicNft",
  //     functionName: "tokenURI",
  //     args: [tokenId],
  //   });

  //   if (tokenUri) {
  //     setTokenUris(prevUris => [...prevUris, tokenUri]);
  //   }
  // };

  // useEffect(() => {
  //   if (!basicNftTokenIds.length && !!events?.length && !isLoadingEvents) {
  //     const ids: bigint[] = events.map(event => {
  //       return event.args.tokenId || 0n;
  //     });
  //     setBasicNftTokenIds(ids);
  //   }
  // }, [events, isLoadingEvents, basicNftTokenIds.length]);

  return (
    <>
      <MetaHeader />
    </>
  );
};

export default Home;
