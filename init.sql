DROP TABLE IF EXISTS "crypto_tsd";
CREATE TABLE "public"."crypto_tsd" (
    "crypto_id" smallint NOT NULL,
    "last_updated" timestamp NOT NULL,
    "price" double precision NOT NULL,
    "volume_24h" real NOT NULL,
    "market_cap_dominance" real NOT NULL,
    "circulating_supply" double precision NOT NULL
) WITH (oids = false);


DROP TABLE IF EXISTS "cryptocurrency";
CREATE TABLE "public"."cryptocurrency" (
    "name" character varying(40) NOT NULL,
    "symbol" character varying(5) NOT NULL,
    "date_added" date NOT NULL,
    "tags" json NOT NULL,
    "max_supply" bigint,
    "crypto_id" smallint NOT NULL,
    CONSTRAINT "Cryptocurrency_pkey" PRIMARY KEY ("crypto_id")
) WITH (oids = false);

INSERT INTO "cryptocurrency" ("name", "symbol", "date_added", "tags", "max_supply", "crypto_id") VALUES
('Bitcoin',	'BTC',	'2013-04-28',	'["mineable", "pow", "sha-256", "store-of-value", "state-channel", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "binance-labs-portfolio", "blockchain-capital-portfolio", "boostvc-portfolio", "cms-holdings-portfolio", "dcg-portfolio", "dragonfly-capital-portfolio", "electric-capital-portfolio", "fabric-ventures-portfolio", "framework-ventures-portfolio", "galaxy-digital-portfolio", "huobi-capital-portfolio", "alameda-research-portfolio", "a16z-portfolio", "1confirmation-portfolio", "winklevoss-capital-portfolio", "usv-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "multicoin-capital-portfolio", "paradigm-portfolio"]',	21000000,	69),
('Ethereum',	'ETH',	'2015-08-07',	'["mineable", "pow", "smart-contracts", "ethereum-ecosystem", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "binance-labs-portfolio", "blockchain-capital-portfolio", "boostvc-portfolio", "cms-holdings-portfolio", "dcg-portfolio", "dragonfly-capital-portfolio", "electric-capital-portfolio", "fabric-ventures-portfolio", "framework-ventures-portfolio", "hashkey-capital-portfolio", "kenetic-capital-portfolio", "huobi-capital-portfolio", "alameda-research-portfolio", "a16z-portfolio", "1confirmation-portfolio", "winklevoss-capital-portfolio", "usv-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "multicoin-capital-portfolio", "paradigm-portfolio", "injective-ecosystem", "bnb-chain"]',	NULL,	70),
('Tether',	'USDT',	'2015-02-25',	'["payments", "stablecoin", "asset-backed-stablecoin", "avalanche-ecosystem", "solana-ecosystem", "arbitrum-ecosytem", "moonriver-ecosystem", "injective-ecosystem", "bnb-chain", "usd-stablecoin"]',	NULL,	71),
('USD Coin',	'USDC',	'2018-10-08',	'["medium-of-exchange", "stablecoin", "asset-backed-stablecoin", "fantom-ecosystem", "arbitrum-ecosytem", "moonriver-ecosystem", "bnb-chain", "usd-stablecoin"]',	NULL,	72),
('BNB',	'BNB',	'2017-07-25',	'["marketplace", "centralized-exchange", "payments", "smart-contracts", "alameda-research-portfolio", "multicoin-capital-portfolio", "moonriver-ecosystem", "bnb-chain"]',	165116760,	73),
('Binance USD',	'BUSD',	'2019-09-20',	'["stablecoin", "asset-backed-stablecoin", "binance-chain", "harmony-ecosystem", "moonriver-ecosystem", "bnb-chain", "usd-stablecoin"]',	NULL,	74),
('XRP',	'XRP',	'2013-08-04',	'["medium-of-exchange", "enterprise-solutions", "binance-chain", "arrington-xrp-capital-portfolio", "galaxy-digital-portfolio", "a16z-portfolio", "pantera-capital-portfolio"]',	100000000000,	75),
('Cardano',	'ADA',	'2017-10-01',	'["mineable", "dpos", "pos", "platform", "research", "smart-contracts", "staking", "cardano-ecosystem", "cardano", "bnb-chain"]',	45000000000,	76),
('Solana',	'SOL',	'2020-04-10',	'["pos", "platform", "solana-ecosystem", "cms-holdings-portfolio", "kenetic-capital-portfolio", "alameda-research-portfolio", "multicoin-capital-portfolio", "okex-blockdream-ventures-portfolio"]',	NULL,	77),
('Dogecoin',	'DOGE',	'2013-12-15',	'["mineable", "pow", "scrypt", "medium-of-exchange", "memes", "payments", "doggone-doggerel", "bnb-chain"]',	NULL,	78),
('Polkadot',	'DOT',	'2020-08-19',	'["substrate", "polkadot", "binance-chain", "polkadot-ecosystem", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "arrington-xrp-capital-portfolio", "blockchain-capital-portfolio", "boostvc-portfolio", "cms-holdings-portfolio", "coinfund-portfolio", "fabric-ventures-portfolio", "fenbushi-capital-portfolio", "hashkey-capital-portfolio", "kenetic-capital-portfolio", "1confirmation-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "exnetwork-capital-portfolio", "web3", "spartan-group", "injective-ecosystem", "bnb-chain"]',	NULL,	79),
('Dai',	'DAI',	'2019-11-22',	'["defi", "stablecoin", "ethereum-ecosystem", "avalanche-ecosystem", "polygon-ecosystem", "fantom-ecosystem", "arbitrum-ecosytem", "harmony-ecosystem", "moonriver-ecosystem", "bnb-chain", "usd-stablecoin"]',	NULL,	80),
('TRON',	'TRX',	'2017-09-13',	'["media", "payments", "tron-ecosystem", "bnb-chain"]',	NULL,	81),
('Shiba Inu',	'SHIB',	'2020-08-01',	'["memes", "ethereum-ecosystem", "doggone-doggerel"]',	NULL,	82),
('Avalanche',	'AVAX',	'2020-07-13',	'["defi", "smart-contracts", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "avalanche-ecosystem", "cms-holdings-portfolio", "dragonfly-capital-portfolio", "moonriver-ecosystem", "injective-ecosystem", "bnb-chain"]',	720000000,	83),
('UNUS SED LEO',	'LEO',	'2019-05-21',	'["marketplace", "centralized-exchange", "discount-token", "payments", "kenetic-capital-portfolio", "alameda-research-portfolio"]',	NULL,	84),
('Wrapped Bitcoin',	'WBTC',	'2019-01-30',	'["medium-of-exchange", "defi", "wrapped-tokens", "fantom-ecosystem", "arbitrum-ecosytem", "moonriver-ecosystem"]',	NULL,	85),
('Polygon',	'MATIC',	'2019-04-28',	'["platform", "enterprise-solutions", "scaling", "state-channel", "coinbase-ventures-portfolio", "binance-launchpad", "binance-labs-portfolio", "polygon-ecosystem", "moonriver-ecosystem", "injective-ecosystem", "bnb-chain"]',	10000000000,	86),
('Uniswap',	'UNI',	'2020-09-17',	'["decentralized-exchange", "defi", "dao", "yield-farming", "amm", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "governance", "blockchain-capital-portfolio", "defiance-capital-portfolio", "alameda-research-portfolio", "a16z-portfolio", "pantera-capital-portfolio", "parafi-capital", "paradigm-portfolio", "arbitrum-ecosytem", "injective-ecosystem", "bnb-chain"]',	1000000000,	87),
('Litecoin',	'LTC',	'2013-04-28',	'["mineable", "pow", "scrypt", "medium-of-exchange", "binance-chain", "bnb-chain"]',	84000000,	88),
('FTX Token',	'FTT',	'2019-07-31',	'["marketplace", "centralized-exchange", "derivatives", "cms-holdings-portfolio", "kenetic-capital-portfolio", "alameda-research-portfolio", "pantera-capital-portfolio", "exnetwork-capital-portfolio"]',	352170015,	89),
('Cronos',	'CRO',	'2018-12-14',	'["medium-of-exchange", "cosmos-ecosystem", "centralized-exchange", "mobile", "payments"]',	30263013692,	90),
('Chainlink',	'LINK',	'2017-09-20',	'["platform", "defi", "oracles", "smart-contracts", "substrate", "polkadot", "polkadot-ecosystem", "avalanche-ecosystem", "solana-ecosystem", "framework-ventures-portfolio", "polygon-ecosystem", "fantom-ecosystem", "cardano-ecosystem", "web3", "near-protocol-ecosystem", "arbitrum-ecosytem", "cardano", "injective-ecosystem", "bnb-chain"]',	1000000000,	91),
('Stellar',	'XLM',	'2014-08-05',	'["medium-of-exchange", "enterprise-solutions", "decentralized-exchange", "smart-contracts", "hashkey-capital-portfolio"]',	50001806812,	92),
('NEAR Protocol',	'NEAR',	'2020-08-11',	'["platform", "staking", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "arrington-xrp-capital-portfolio", "coinfund-portfolio", "electric-capital-portfolio", "fabric-ventures-portfolio", "kenetic-capital-portfolio", "near-protocol-ecosystem", "injective-ecosystem", "bnb-chain"]',	1000000000,	93),
('Cosmos',	'ATOM',	'2019-03-14',	'["platform", "cosmos-ecosystem", "content-creation", "interoperability", "binance-chain", "polychain-capital-portfolio", "dragonfly-capital-portfolio", "hashkey-capital-portfolio", "1confirmation-portfolio", "paradigm-portfolio", "exnetwork-capital-portfolio", "injective-ecosystem", "bnb-chain"]',	NULL,	94),
('Monero',	'XMR',	'2014-05-21',	'["mineable", "pow", "medium-of-exchange", "privacy", "ringct", "boostvc-portfolio", "electric-capital-portfolio", "galaxy-digital-portfolio"]',	NULL,	95),
('Algorand',	'ALGO',	'2019-06-20',	'["pos", "platform", "research", "smart-contracts", "arrington-xrp-capital-portfolio", "kenetic-capital-portfolio", "usv-portfolio", "multicoin-capital-portfolio", "exnetwork-capital-portfolio"]',	10000000000,	96),
('Ethereum Classic',	'ETC',	'2016-07-24',	'["mineable", "pow", "ethash", "platform", "smart-contracts", "dcg-portfolio", "bnb-chain"]',	210700000,	97),
('Bitcoin Cash',	'BCH',	'2017-07-23',	'["mineable", "pow", "sha-256", "marketplace", "medium-of-exchange", "store-of-value", "enterprise-solutions", "payments", "binance-chain", "bnb-chain"]',	21000000,	98),
('VeChain',	'VET',	'2017-08-22',	'["logistics", "data-provenance", "iot", "smart-contracts", "fenbushi-capital-portfolio"]',	86712634466,	99),
('Decentraland',	'MANA',	'2017-09-17',	'["platform", "collectibles-nfts", "gaming", "payments", "metaverse", "boostvc-portfolio", "dcg-portfolio", "fabric-ventures-portfolio", "kenetic-capital-portfolio", "polygon-ecosystem", "play-to-earn"]',	NULL,	100),
('Flow',	'FLOW',	'2021-01-27',	'["collectibles-nfts", "coinbase-ventures-portfolio", "coinfund-portfolio", "dcg-portfolio", "ledgerprime-portfolio", "a16z-portfolio", "animoca-brands-portfolio"]',	NULL,	101),
('The Sandbox',	'SAND',	'2020-08-05',	'["collectibles-nfts", "content-creation", "gaming", "ethereum-ecosystem", "binance-launchpad", "metaverse", "play-to-earn", "animoca-brands-portfolio"]',	3000000000,	102),
('Hedera',	'HBAR',	'2019-09-17',	'["dag", "marketplace", "enterprise-solutions", "payments", "dcg-portfolio"]',	50000000000,	103),
('ApeCoin',	'APE',	'2022-03-17',	'["collectibles-nfts", "content-creation", "gaming", "entertainment", "dao", "governance", "metaverse", "animoca-brands-portfolio"]',	1000000000,	104),
('Internet Computer',	'ICP',	'2021-03-23',	'["platform", "distributed-computing", "polychain-capital-portfolio", "exnetwork-capital-portfolio"]',	NULL,	105),
('Tezos',	'XTZ',	'2017-10-06',	'["pos", "platform", "enterprise-solutions", "collectibles-nfts", "defi", "smart-contracts", "polychain-capital-portfolio", "boostvc-portfolio", "winklevoss-capital-portfolio"]',	NULL,	106),
('Theta Network',	'THETA',	'2018-01-17',	'["media", "collectibles-nfts", "content-creation", "defi", "video", "metaverse", "huobi-capital-portfolio", "web3"]',	1000000000,	107),
('Filecoin',	'FIL',	'2017-12-13',	'["mineable", "distributed-computing", "filesharing", "storage", "polychain-capital-portfolio", "blockchain-capital-portfolio", "boostvc-portfolio", "dcg-portfolio", "hashkey-capital-portfolio", "a16z-portfolio", "winklevoss-capital-portfolio", "pantera-capital-portfolio", "web3", "bnb-chain"]',	NULL,	108),
('Axie Infinity',	'AXS',	'2020-08-31',	'["collectibles-nfts", "gaming", "binance-launchpad", "metaverse", "defiance-capital-portfolio", "play-to-earn", "animoca-brands-portfolio"]',	270000000,	109),
('Helium',	'HNT',	'2020-06-05',	'["mineable", "enterprise-solutions", "distributed-computing", "iot", "usv-portfolio", "multicoin-capital-portfolio", "web3"]',	223000000,	110),
('Elrond',	'EGLD',	'2020-09-04',	'["binance-launchpad", "binance-labs-portfolio", "electric-capital-portfolio", "exnetwork-capital-portfolio", "elrond-ecosystem", "injective-ecosystem", "bnb-chain"]',	31415926,	111),
('TrueUSD',	'TUSD',	'2018-03-06',	'["store-of-value", "stablecoin", "asset-backed-stablecoin", "avalanche-ecosystem", "arbitrum-ecosytem", "bnb-chain", "usd-stablecoin"]',	NULL,	112),
('Bitcoin SV',	'BSV',	'2018-11-09',	'["mineable", "pow", "sha-256", "medium-of-exchange", "store-of-value", "state-channel"]',	21000000,	113),
('KuCoin Token',	'KCS',	'2017-10-24',	'["marketplace", "centralized-exchange", "discount-token", "algorand-ecosystem"]',	170118638,	114),
('Maker',	'MKR',	'2017-01-29',	'["store-of-value", "defi", "dao", "polychain-capital-portfolio", "governance", "lending-borowing", "dragonfly-capital-portfolio", "electric-capital-portfolio", "a16z-portfolio", "1confirmation-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "paradigm-portfolio", "near-protocol-ecosystem", "spartan-group", "bnb-chain"]',	1005577,	115),
('EOS',	'EOS',	'2017-07-01',	'["medium-of-exchange", "enterprise-solutions", "smart-contracts", "binance-chain", "fenbushi-capital-portfolio", "galaxy-digital-portfolio", "bnb-chain"]',	NULL,	116),
('Zcash',	'ZEC',	'2016-10-29',	'["mineable", "pow", "equihash", "medium-of-exchange", "privacy", "zero-knowledge-proofs", "binance-chain", "boostvc-portfolio", "dcg-portfolio", "electric-capital-portfolio", "fenbushi-capital-portfolio", "hashkey-capital-portfolio", "winklevoss-capital-portfolio", "placeholder-ventures-portfolio", "pantera-capital-portfolio", "bnb-chain"]',	21000000,	117),
('Pax Dollar',	'USDP',	'2018-09-27',	'["store-of-value", "stablecoin", "asset-backed-stablecoin", "bnb-chain", "usd-stablecoin"]',	NULL,	118),
('Aave',	'AAVE',	'2020-10-02',	'["defi", "dao", "yield-farming", "three-arrows-capital-portfolio", "governance", "lending-borowing", "blockchain-capital-portfolio", "defiance-capital-portfolio", "framework-ventures-portfolio", "alameda-research-portfolio", "pantera-capital-portfolio", "parafi-capital", "polygon-ecosystem", "fantom-ecosystem", "bnb-chain"]',	16000000,	119),
('Huobi Token',	'HT',	'2018-02-03',	'["marketplace", "centralized-exchange", "discount-token", "payments", "algorand-ecosystem", "kenetic-capital-portfolio", "alameda-research-portfolio", "multicoin-capital-portfolio"]',	500000000,	120),
('IOTA',	'MIOTA',	'2017-06-13',	'["dag", "medium-of-exchange", "iot", "sharing-economy", "bnb-chain"]',	2779530283,	121),
('BitTorrent-New',	'BTT',	'2019-01-31',	'["platform", "distributed-computing", "filesharing", "interoperability", "staking", "tron-ecosystem", "storage", "binance-launchpad", "binance-labs-portfolio", "web3", "bnb-chain"]',	NULL,	122),
('Neutrino USD',	'USDN',	'2020-01-30',	'["defi", "stablecoin", "algorithmic-stablecoin", "bnb-chain", "usd-stablecoin"]',	NULL,	123),
('eCash',	'XEC',	'2021-07-08',	'[]',	21000000000000,	124),
('The Graph',	'GRT',	'2020-12-17',	'["ai-big-data", "enterprise-solutions", "defi", "coinbase-ventures-portfolio", "solana-ecosystem", "analytics", "coinfund-portfolio", "dcg-portfolio", "fabric-ventures-portfolio", "framework-ventures-portfolio", "ledgerprime-portfolio", "multicoin-capital-portfolio", "parafi-capital", "polygon-ecosystem", "fantom-ecosystem", "web3", "near-protocol-ecosystem", "arbitrum-ecosytem", "spartan-group", "injective-ecosystem", "bnb-chain"]',	10057044431,	125),
('OKB',	'OKB',	'2019-04-30',	'["marketplace", "centralized-exchange", "discount-token", "alameda-research-portfolio"]',	NULL,	126),
('Quant',	'QNT',	'2018-08-10',	'["platform", "interoperability"]',	14612493,	127),
('USDD',	'USDD',	'2022-05-02',	'["stablecoin", "algorithmic-stablecoin", "usd-stablecoin"]',	NULL,	128),
('Klaytn',	'KLAY',	'2020-03-30',	'["platform", "enterprise-solutions", "injective-ecosystem"]',	NULL,	129),
('Fantom',	'FTM',	'2018-10-29',	'["platform", "enterprise-solutions", "defi", "research", "scaling", "smart-contracts", "fantom-ecosystem", "injective-ecosystem", "bnb-chain"]',	3175000000,	130),
('THORChain',	'RUNE',	'2019-07-23',	'["cosmos-ecosystem", "decentralized-exchange", "defi", "multicoin-capital-portfolio", "exnetwork-capital-portfolio"]',	500000000,	131),
('Neo',	'NEO',	'2016-09-08',	'["platform", "enterprise-solutions", "smart-contracts"]',	100000000,	132),
('Waves',	'WAVES',	'2016-06-02',	'["lpos", "platform", "smart-contracts"]',	NULL,	133),
('Chiliz',	'CHZ',	'2019-07-01',	'["sports", "collectibles-nfts", "content-creation", "payments"]',	8888888888,	134),
('Stacks',	'STX',	'2019-10-28',	'["mineable", "platform", "collectibles-nfts", "defi", "smart-contracts", "metaverse", "arrington-xrp-capital-portfolio", "blockchain-capital-portfolio", "dcg-portfolio", "fabric-ventures-portfolio", "hashkey-capital-portfolio", "huobi-capital-portfolio", "usv-portfolio", "web3", "injective-ecosystem"]',	1818000000,	135),
('PAX Gold',	'PAXG',	'2019-09-26',	'["bnb-chain", "tokenized-gold"]',	NULL,	136),
('Basic Attention Token',	'BAT',	'2017-06-01',	'["marketing", "content-creation", "defi", "payments", "dcg-portfolio", "1confirmation-portfolio", "pantera-capital-portfolio", "web3", "bnb-chain"]',	1500000000,	137),
('Zilliqa',	'ZIL',	'2018-01-25',	'["mineable", "platform", "payments", "smart-contracts", "polychain-capital-portfolio", "kenetic-capital-portfolio", "zilliqa-ecosystem", "bnb-chain"]',	21000000000,	138),
('STEPN',	'GMT',	'2022-03-09',	'["collectibles-nfts", "gaming", "binance-launchpad", "solana-ecosystem", "move-to-earn"]',	6000000000,	139),
('Loopring',	'LRC',	'2017-08-30',	'["marketplace", "decentralized-exchange", "defi", "scaling", "rollups"]',	1374513896,	140),
('Dash',	'DASH',	'2014-02-14',	'["mineable", "hybrid-pow-pos", "x11", "medium-of-exchange", "masternodes", "dao", "governance"]',	18900000,	141),
('Enjin Coin',	'ENJ',	'2017-11-01',	'["media", "collectibles-nfts", "gaming", "ethereum-ecosystem", "metaverse", "arrington-xrp-capital-portfolio"]',	1000000000,	142),
('PancakeSwap',	'CAKE',	'2020-09-25',	'["collectibles-nfts", "decentralized-exchange", "defi", "smart-contracts", "yield-farming", "binance-chain", "amm", "dex", "governance", "bnb-chain"]',	750000000,	143),
('Kusama',	'KSM',	'2019-12-12',	'["substrate", "polkadot-ecosystem", "cms-holdings-portfolio", "kenetic-capital-portfolio", "1confirmation-portfolio", "vbc-ventures-portfolio"]',	NULL,	144),
('Fei USD',	'FEI',	'2021-03-02',	'["defi", "stablecoin", "algorithmic-stablecoin"]',	NULL,	145),
('Gala',	'GALA',	'2020-09-16',	'["collectibles-nfts", "gaming", "binance-smart-chain", "polygon-ecosystem", "play-to-earn"]',	NULL,	146),
('TerraClassicUSD',	'USTC',	'2020-09-21',	'["cosmos-ecosystem", "stablecoin", "algorithmic-stablecoin", "terra-ecosystem", "injective-ecosystem", "bnb-chain", "usd-stablecoin"]',	NULL,	147),
('Celo',	'CELO',	'2020-05-22',	'["pos", "zero-knowledge-proofs", "mobile", "payments", "smart-contracts", "coinbase-ventures-portfolio", "polychain-capital-portfolio", "dragonfly-capital-portfolio", "electric-capital-portfolio", "a16z-portfolio", "celo-ecosystem"]',	1000000000,	148),
('Kava',	'KAVA',	'2019-10-25',	'["cosmos-ecosystem", "defi", "binance-launchpad", "binance-labs-portfolio", "lending-borowing", "arrington-xrp-capital-portfolio", "framework-ventures-portfolio", "hashkey-capital-portfolio", "injective-ecosystem"]',	NULL,	149),
('Curve DAO Token',	'CRV',	'2020-08-14',	'["decentralized-exchange", "defi", "dao", "yield-farming", "amm", "governance", "framework-ventures-portfolio", "alameda-research-portfolio", "polygon-ecosystem", "fantom-ecosystem", "arbitrum-ecosytem"]',	3303030299,	150),
('Holo',	'HOT',	'2018-04-29',	'["platform", "distributed-computing", "filesharing", "storage"]',	NULL,	151),
('Amp',	'AMP',	'2020-09-08',	'[]',	92547638199,	152),
('Mina',	'MINA',	'2021-03-02',	'["pos", "zero-knowledge-proofs", "staking", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "polychain-capital-portfolio"]',	NULL,	153),
('Nexo',	'NEXO',	'2018-05-01',	'["services", "payments", "cardano-ecosystem"]',	1000000000,	154),
('NEM',	'XEM',	'2015-04-01',	'["poi", "medium-of-exchange", "payments", "smart-contracts", "fantom-ecosystem"]',	8999999999,	155),
('1inch Network',	'1INCH',	'2020-12-25',	'["decentralized-exchange", "defi", "amm", "binance-labs-portfolio", "blockchain-capital-portfolio", "dragonfly-capital-portfolio", "fabric-ventures-portfolio", "alameda-research-portfolio", "parafi-capital", "spartan-group", "bnb-chain"]',	NULL,	156),
('Decred',	'DCR',	'2016-02-10',	'["mineable", "hybrid-pow-pos", "blake256", "medium-of-exchange", "store-of-value", "privacy", "dao", "placeholder-ventures-portfolio"]',	21000000,	157),
('Compound',	'COMP',	'2020-06-16',	'["defi", "dao", "yield-farming", "polkadot-ecosystem", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "polychain-capital-portfolio", "lending-borowing", "dragonfly-capital-portfolio", "alameda-research-portfolio", "a16z-portfolio", "pantera-capital-portfolio", "paradigm-portfolio", "bnb-chain"]',	10000000,	158),
('XDC Network',	'XDC',	'2018-04-12',	'["xdc-ecosystem"]',	NULL,	159),
('GateToken',	'GT',	'2019-08-20',	'["marketplace", "centralized-exchange", "discount-token", "algorand-ecosystem"]',	NULL,	160),
('Arweave',	'AR',	'2020-05-27',	'["distributed-computing", "filesharing", "storage", "coinbase-ventures-portfolio", "solana-ecosystem", "arrington-xrp-capital-portfolio", "blockchain-capital-portfolio", "a16z-portfolio", "multicoin-capital-portfolio", "web3"]',	66000000,	161),
('Symbol',	'XYM',	'2021-03-03',	'[]',	8999999999,	162),
('Gnosis',	'GNO',	'2017-05-01',	'["services", "decentralized-exchange", "defi", "prediction-markets", "kenetic-capital-portfolio", "arbitrum-ecosytem"]',	10000000,	163),
('Qtum',	'QTUM',	'2017-05-24',	'["platform", "smart-contracts", "kenetic-capital-portfolio"]',	107822406,	164),
('Storj',	'STORJ',	'2017-07-02',	'["platform", "distributed-computing", "filesharing", "storage", "web3"]',	NULL,	165),
('Synthetix',	'SNX',	'2018-03-14',	'["services", "decentralized-exchange", "defi", "derivatives", "dao", "yield-farming", "coinbase-ventures-portfolio", "three-arrows-capital-portfolio", "governance", "synthetics", "defiance-capital-portfolio", "framework-ventures-portfolio", "alameda-research-portfolio", "parafi-capital", "paradigm-portfolio", "fantom-ecosystem", "spartan-group", "bnb-chain"]',	212424133,	166),
('Kadena',	'KDA',	'2020-05-31',	'["mineable", "pow", "blake2s", "platform", "cosmos-ecosystem", "smart-contracts", "coinfund-portfolio", "multicoin-capital-portfolio"]',	1000000000,	167),
('BORA',	'BORA',	'2019-03-18',	'["marketplace", "gaming", "wallet"]',	NULL,	168);