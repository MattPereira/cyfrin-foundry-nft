import { useEffect, useState } from "react";
import Image from "next/image";
import type { NextPage } from "next";
import { MetaHeader } from "~~/components/MetaHeader";

// import { useScaffoldContractRead, useScaffoldEventHistory } from "~~/hooks/scaffold-eth/";

const Home: NextPage = () => {
  const [nfts, setNfts] = useState<any[]>([]);
  const [isLoading, setLoading] = useState(true);

  useEffect(() => {
    fetch("api/querySubgraph")
      .then(res => res.json())
      .then(async data => {
        const minteds = data.data.minteds;
        const nftPromises = minteds.map((minted: any) => {
          const ipfsUrl = minted.tokenUri.replace("ipfs://", "https://ipfs.io/ipfs/");
          return fetch(ipfsUrl).then(res => res.json());
        });
        const nftsData = await Promise.all(nftPromises);
        console.log(nftsData);
        const nftsDataFormatted = nftsData.map((nft: any) => {
          if (nft.image.includes("ipfs://")) {
            nft.image = nft.image.replace("ipfs://", "https://ipfs.io/ipfs/");
          }
          return nft;
        });
        console.log(nftsDataFormatted);
        setNfts(nftsDataFormatted);
        setLoading(false);
      })
      .catch(error => {
        console.error("Error:", error);
        setLoading(false);
      });
  }, []);

  if (isLoading) return <p>Loading...</p>;
  if (!nfts) return <p>No profile data</p>;

  console.log(nfts);

  return (
    <>
      <MetaHeader />

      <h3 className="text-center mt-10 text-3xl">IPFS NFTs</h3>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 m-10 gap-8">
        {nfts.map(nft => (
          <div key={nft.name} className="bg-base-300 rounded-xl">
            <Image width={500} height={500} src={nft.image} alt={nft.name} className="rounded-xl" />
            <h5 className="text-xl">{nft.name}</h5>
          </div>
        ))}
      </div>
    </>
  );
};

export default Home;
