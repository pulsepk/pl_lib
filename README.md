# pl_lib — PulseLib

A shared bridge library for FiveM that provides a single unified API across multiple frameworks and third-party systems. Drop it in once, and any script built on it works regardless of what the server is running.

---

## Requirements

- One supported framework: **QBox**, **QBCore**, or **ESX**

---

## Supported Frameworks

QBox (qbx_core) · QBCore (qb-core) · ESX (es_extended)

All systems are auto-detected at startup or can be forced in `config/config.lua`.

---

## Features & Supported Scripts

| Feature | Supported Scripts |
|---------|------------------|
| **Notifications** | ox_lib, esx_notify, okokNotify, lation_ui, wasabi_notify, brutal_notify, mythic_notify |
| **Text UI** | ox_lib, qb-core, jg-textui, esx_textui, cd_drawtextui, brutal_textui, lation_ui |
| **Context Menu** | ox_lib, lation_ui |
| **Input Dialog** | ox_lib, lation_ui |
| **Skill Check** | ox_lib, lation_ui |
| **Progress Bar** | ox_lib, ox_lib (circular), qb, lation_ui |
| **Target** | ox_target, qb-target |
| **Inventory** | ox_inventory, qb-inventory, qs-inventory, ps-inventory, codem-inventory, tgiann-inventory, origen_inventory, jaksam_inventory, core_inventory, one_inventory |
| **Vehicle Fuel** | LegacyFuel, cdn-fuel, okokGasStation, rcore_fuel, ox_fuel |
| **Vehicle Keys** | qb-vehiclekeys, wasabi_carlock, qs-vehiclekeys, vehicles_keys |
| **Clothing / Appearance** | esx_skin, illenium-appearance, fivem-appearance, qb-clothing, tgiann-clothing, rcore_clothing |
| **Society / Job Banking** | esx_addonaccount, Renewed-Banking, qb-management, qb-banking, okokBanking, snipe-banking, tgiann-bank, kartik-banking |
| **Dispatch** | ps-dispatch, aty_dispatch, rcore_dispatch, cd_dispatch, Opto_dispatch, tk_dispatch, qs-dispatch, codem-dispatch |
| **Logging** | fivemanage, fivemerr, discord webhook |
| **Animations** | Native (no dependency) |
| **Player Status** | Native (hunger & thirst) |
| **Phone** | lb-phone, gksphone |

---

## Installation

1. Place `pl_lib` in your resources folder (e.g. `[resources]`).
2. Add `ensure pl_lib` to `server.cfg` **before** any script that depends on it.
3. Ensure `ox_lib` starts before `pl_lib`.

---

## Phone API

Configure which phone system to use in `config/config.lua`:

```lua
PLLib.Phone = 'autodetect' -- 'autodetect' | 'lb-phone' | 'gksphone'
```

Detection priority: `lb-phone` → `gksphone`

---

### Client exports

#### `ShowPhoneNotification(title, message, icon?)`

Pops a notification on the local player's phone.

| Parameter | Type | Description |
|-----------|------|-------------|
| `title` | `string` | Notification title |
| `message` | `string` | Notification body |
| `icon` | `string?` | FontAwesome class (default: `'fas fa-bell'`) |

```lua
exports.pl_lib:ShowPhoneNotification('Dispatch', 'Unit 4 is en route.', 'fas fa-car')
```

---

### Server exports

#### `SendPhoneNotification(source, title, message, icon?)`

Pushes a notification to a specific player's phone.

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | `number` | Player server ID |
| `title` | `string` | Notification title |
| `message` | `string` | Notification body |
| `icon` | `string?` | FontAwesome class (default: `'fas fa-bell'`) |

```lua
exports.pl_lib:SendPhoneNotification(source, 'Boss', 'You have a new task.', 'fas fa-briefcase')
```

---

#### `GetPlayerPhoneNumber(source)`

Returns the player's phone number string, or `nil` if unavailable.

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | `number` | Player server ID |

```lua
local number = exports.pl_lib:GetPlayerPhoneNumber(source)
```

---

#### `SendPhoneMessage(fromNumber, toNumber, message)`

Sends an SMS from one phone number to another. Use `GetPlayerPhoneNumber` to resolve source IDs to numbers first.

| Parameter | Type | Description |
|-----------|------|-------------|
| `fromNumber` | `string` | Sender's phone number |
| `toNumber` | `string` | Recipient's phone number |
| `message` | `string` | Message content |

```lua
local fromNumber = exports.pl_lib:GetPlayerPhoneNumber(senderSrc)
local toNumber   = exports.pl_lib:GetPlayerPhoneNumber(targetSrc)

if fromNumber and toNumber then
    exports.pl_lib:SendPhoneMessage(fromNumber, toNumber, 'Hello!')
end
```

---

## Links

- Discord: https://discord.gg/c6gXmtEf3H
- Website: https://pulsescripts.com
- Download: https://github.com/pulsepk/pl_lib
