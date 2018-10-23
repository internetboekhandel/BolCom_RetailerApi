<?php

// this file is auto-generated by prolic/fpp
// don't edit this file manually

declare(strict_types=1);

namespace BolCom\RetailerApi\Model\Commission;

final class CommissionList
{
    private $commissions;

    public function __construct(Commission ...$commissions)
    {
        $this->commissions = $commissions;
    }

    public function commissions(): array
    {
        return $this->commissions;
    }

    public function withCommissions(array $commissions): CommissionList
    {
        return new self(...$commissions);
    }

    public static function fromArray(array $data): CommissionList
    {
        if (! isset($data['commissions']) || ! \is_array($data['commissions'])) {
            throw new \InvalidArgumentException("Key 'commissions' is missing in data array or is not an array");
        }

        $commissions = [];

        foreach ($data['commissions'] as $__value) {
            if (! \is_array($data['commissions'])) {
                throw new \InvalidArgumentException("Key 'commissions' in data array or is not an array of arrays");
            }

            $commissions[] = Commission::fromArray($__value);
        }

        return new self($commissions);
    }
}