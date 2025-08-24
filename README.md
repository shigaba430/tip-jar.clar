# STX Tip Jar Smart Contract

A decentralized tipping system built on the Stacks blockchain that allows users to send STX tokens as tips. The contract owner can withdraw the accumulated tips to any specified address.

## Features

- Send STX tips to contract owner
- Withdraw collected tips (owner only)
- View total tips collected
- View contract owner
- Built-in authorization checks

## Contract Functions

### Public Functions

#### `send-tip`
Send STX tokens as a tip to the contract owner.
```clarity
(define-public (send-tip (amount uint)))
```
- Parameters:
  - `amount`: Amount of STX to send as tip
- Returns: OK with sender and amount details or error on failure

#### `withdraw-tips`
Owner-only function to withdraw accumulated tips.
```clarity
(define-public (withdraw-tips (to principal)))
```
- Parameters:
  - `to`: Principal address to receive the withdrawn tips
- Returns: OK on successful transfer or error if unauthorized/no funds

### Read-Only Functions

#### `get-total-tips`
Get the current total of collected tips.
```clarity
(define-read-only (get-total-tips))
```
- Returns: OK with total tips amount

#### `get-owner`
Get the contract owner's principal.
```clarity
(define-read-only (get-owner))
```
- Returns: OK with owner's principal

## Error Codes

- `ERR-NOT-AUTHORIZED (u100)`: Unauthorized access attempt
- `ERR-NO-FUNDS (u101)`: No tips available to withdraw
- `u102`: STX transfer failed

## Development

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet)
- Node.js and npm (for testing)

### Testing

Run the test suite:
```bash
clarinet test
```
