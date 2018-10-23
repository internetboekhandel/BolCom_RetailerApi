namespace BolCom\RetailerApi\Model\Offer {
    data Ean = String deriving(FromString, ToString);

    data QuantityInStock = Int deriving(FromScalar, ToScalar) where
        _: | !\Assert\Assertion::betweenLength($value, 0, 999) => '';

    data UnreservedStock = Int deriving(FromScalar, ToScalar) where
        _: | !\Assert\Assertion::betweenLength($value, 0, 999) => '';

    data ReferenceCode = String deriving(FromString, ToString) where
        _: | !\Assert\Assertion::betweenLength($value, 0, 20) => '';

    data Description = String deriving(FromString, ToString) where
        _: | !\Assert\Assertion::betweenLength($value, 0, 2000) => '';

    data Title = String deriving(FromString, ToString) where
        _: | !\Assert\Assertion::betweenLength($value, 0, 500) => '';

    data PublishStatus = Published | NotPublished deriving(Enum) with (Published:'published', NotPublished:'not-published');

    data OfferCsv = OfferCsv {
        string $url
    } deriving (FromArray);

    data RetailerOfferStatus = RetailerOfferStatus {
        bool $valid,
        string $errorCode,
        string $errorMessage
    } deriving (FromArray);

    data Price = Float deriving(FromScalar, ToScalar);

    //We choose IsNew, because New is a protected key word
    data Condition = IsNew | AsNew | Good | Reasonable | Moderate deriving(Enum) with (IsNew:'NEW', AsNew:'AS_NEW', Good:'GOOD', Reasonable:'REASONABLE', Moderate:'MODERATE');

    data DeliveryCode = DC24uurs23 | DC24uurs22 | DC24uurs21 | DC24uurs20 | DC24uurs19 | DC24uurs18 | DC24uurs17 |
        DC24uurs16 | DC24uurs15 | DC24uurs14 | DC24uurs13 | DC24uurs12 | DC12d | DC23d | DC34d | DC35d | DC48d | DC18d |
        DCMijnLeverbelofte deriving (Enum) with(
            DC24uurs23: "24uurs-23",
            DC24uurs22: "24uurs-22",
            DC24uurs21: "24uurs-21",
            DC24uurs20: "24uurs-20",
            DC24uurs19: "24uurs-19",
            DC24uurs18: "24uurs-18",
            DC24uurs17: "24uurs-17",
            DC24uurs16: "24uurs-16",
            DC24uurs15: "24uurs-15",
            DC24uurs14: "24uurs-14",
            DC24uurs13: "24uurs-13",
            DC24uurs12: "24uurs-12",
            DC12d: "1-2d",
            DC23d: "2-3d",
            DC34d: "3-4d",
            DC35d: "3-5d",
            DC48d: "4-8d",
            DC18d: "1-8d",
            DCMijnLeverbelofte: "MijnLeverbelofte"
        );

    data RetailerOfferIdentifier = RetailerOfferIdentifier {
        Ean $ean,
        Condition $condition,
    } deriving (ToArray);

    data RetailerOffer = RetailerOffer {
        Ean $ean,
        Condition $condition,
        Price $price,
        DeliveryCode $deliveryCode,
        QuantityInStock $quantityInStock,
        UnreservedStock $unreservedStock,
        bool $publish,
        ReferenceCode $referenceCode,
        Description $description,
        Title $title,
        \BolCom\RetailerApi\Model\Shipment\FulfilmentMethod $fulfilmentMethod,
        RetailerOfferStatus $status
    } deriving (FromArray);

    data RetailerOfferUpsert = RetailerOfferUpsert {
        Ean $ean,
        Condition $condition,
        Price $price,
        DeliveryCode $deliveryCode,
        QuantityInStock $quantityInStock,
        bool $publish,
        ReferenceCode $referenceCode,
        Description $description,
        Title $title,
        \BolCom\RetailerApi\Model\Shipment\FulfilmentMethod $fulfilmentMethod
    } deriving (ToArray);
}

namespace BolCom\RetailerApi\Model\Offer\Query {
    data GetOfferCsv = GetOfferCsv {
        string $filename
    };

    data GetOffer = GetOffer {
        \BolCom\RetailerApi\Model\Offer\RetailerOfferIdentifier $retailerOfferIdentifier
    };
}

namespace BolCom\RetailerApi\Model\Offer\Command {
    data CreateOrUpdateOffer = CreateOrUpdateOffer {
        \BolCom\RetailerApi\Model\Offer\RetailerOfferUpsert[] $retailOffer
    };

    data DeleteOffersInBulk = DeleteOffersInBulk {
        \BolCom\RetailerApi\Model\Offer\RetailerOfferIdentifier[] $retailerOfferIdentifier
    } where
        _: | count($retailerOfferIdentifier) === 0 => 'You should at least provide a single Offer to delete';

    data GenerateOfferCvs = GenerateOfferCvs {
        ?\BolCom\RetailerApi\Model\Offer\PublishStatus $filter
    };
}