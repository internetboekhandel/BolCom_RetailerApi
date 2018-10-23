<?php

// this file is auto-generated by prolic/fpp
// don't edit this file manually

declare(strict_types=1);

namespace BolCom\RetailerApi\Model\Shipment;

final class FulfilmentMethod
{
    public const OPTIONS = [
        'ByRetailer' => 'FBR',
        'ByBolCom' => 'FFB',
    ];

    public const ByRetailer = 'FBR';
    public const ByBolCom = 'FFB';

    private $name;
    private $value;

    private function __construct(string $name)
    {
        $this->name = $name;
        $this->value = self::OPTIONS[$name];
    }

    public static function byRetailer(): self
    {
        return new self('ByRetailer');
    }

    public static function byBolCom(): self
    {
        return new self('ByBolCom');
    }

    public static function fromName(string $value): self
    {
        if (! isset(self::OPTIONS[$value])) {
            throw new \InvalidArgumentException('Unknown enum name given');
        }

        return self::{$value}();
    }

    public static function fromValue($value): self
    {
        foreach (self::OPTIONS as $name => $v) {
            if ($v === $value) {
                return self::{$name}();
            }
        }

        throw new \InvalidArgumentException('Unknown enum value given');
    }

    public function equals(FulfilmentMethod $other): bool
    {
        return \get_class($this) === \get_class($other) && $this->name === $other->name;
    }

    public function name(): string
    {
        return $this->name;
    }

    public function value()
    {
        return $this->value;
    }

    public function __toString(): string
    {
        return $this->name;
    }

    public function toString(): string
    {
        return $this->name;
    }
}