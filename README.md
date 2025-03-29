# LTE-Redirection Attack
*A tool designed to force target victims to connect to an unsafe network by implementing a fake base station and LTE redirection attack.*

[Build Video Tutorial](https://youtu.be/0aruLybY__w)

## Table of Contents

1.  [Overview](#overview)
2.  [Prerequisites](#prerequisites)
3.  [Installation](#installation)
4.  [Configuration](#configuration)
5.  [Usage](#usage)
6.  [Troubleshooting](#troubleshooting)
7.  [Contributing](#contributing)
8.  [References](#references)
9.  [Legal Notice](#legal-notice)


**DISCLAIMER:** This project is shared for educational purposes only. The developer makes no guarantees about its current functionality as testing results have been inconsistent. Use responsibly and at your own risk.

## Overview

This tool creates a fake 2G EGPRS base station and redirects LTE devices to connect to it, allowing for potential man-in-the-middle attacks. The implementation uses a combination of software-defined radio techniques with Osmocom and srsRAN components.

## Prerequisites

- Ubuntu 22.04 (tested platform)
- Software-defined radio hardware (compatible with UHD)
- Basic understanding of cellular networks
- Root privileges

## Installation

Clone the repository and build the necessary components:

```bash
git clone https://github.com/yourusername/LTE-Redirection_Attack.git
cd LTE-Redirection_Attack
sudo ./build.sh
```

## Configuration

Before running the attack, you need to configure several files:

### 1. Modify `osmo-bsc.cfg`

Open `osmo-bsc.cfg` and change:

- The remote IP address from `192.168.1.23` to your internet interface IP (192.168.X.X)

### 2. Set Appropriate MCC/MNC Values

The Mobile Country Code (MCC) and Mobile Network Code (MNC) uniquely identify a mobile network operator. Setting these values correctly in the `osmo-bsc.cfg` and LTE redirector is crucial for a successful redirection attack.  Incorrect values will prevent devices from associating with your fake base station.

**A. Understanding MCC and MNC:**

*   **MCC (Mobile Country Code):** A three-digit code that identifies the country in which the mobile network is registered. (e.g., 310 for the United States, 262 for Germany, 208 for France).
*   **MNC (Mobile Network Code):** A two or three-digit code that, in combination with the MCC, uniquely identifies a mobile network operator within that country.

**B. Finding the Correct MCC/MNC for Your Target Network:**

There are several ways to find the MCC/MNC of a target network:

*   **Online Databases:** Several websites maintain databases of MCC and MNC values.  A good starting point is Wikipedia:
    *   [List of mobile country codes](https://en.wikipedia.org/wiki/Mobile_country_code) - provides an overview of MCC values
    *   Search online for "MNC list" or "MCC MNC database" to find more specific resources.
*   **Network Scanning Apps:** Smartphone apps designed to display cellular network information can reveal the MCC and MNC of the network to which the phone is currently connected. Examples of such apps include:
    *   **Android:** Network Cell Info Lite, Cellmapper
    *   **iOS:**  Field Test Mode (dial \*3001#12345#\* and tap call - this provides very detailed technical information) - While iOS doesn't offer dedicated apps with the same level of detail as Android, Field Test Mode can provide some network information if you know how to interpret it.  Use with caution and research how to use it effectively.
*   **3GPP Specifications:** The 3rd Generation Partnership Project (3GPP) defines cellular standards.  While these specifications won't directly list MCC/MNC pairs, they provide the framework within which these codes are assigned.
*   **Government Regulatory Websites:** In some countries, government agencies responsible for telecommunications regulation publish lists of assigned MCC and MNC values.

**C.  General Guidelines for Finding MCC/MNC:**

*   **Identify the Country:** Determine the country where the target network operates. This will give you the MCC.
*   **Identify the Operator:** Determine the specific mobile network operator (e.g., Verizon, AT&T, T-Mobile in the US; Vodafone, O2, Deutsche Telekom in Germany).
*   **Search Online:** Use the country and operator name to search online for the corresponding MNC.  For example, "MNC Verizon USA".
*   **Verify with Multiple Sources:** Cross-reference the information you find from different sources to ensure accuracy.  MCC/MNC values can change over time.

**D. Example MCC/MNC Combinations (Illustrative Only - Verify Current Values):**

| Country        | Operator           | MCC   | MNC   | Notes                                                                  |
|----------------|--------------------|-------|-------|------------------------------------------------------------------------|
| United States  | Verizon            | 311   | 480   | Large US carrier                                                      |
| United States  | AT&T               | 310   | 410   | Another major US carrier                                               |
| United States  | T-Mobile           | 310   | 260   |                                                                        |
| Germany        | Vodafone           | 262   | 02    |                                                                        |
| Germany        | Deutsche Telekom   | 262   | 01    |                                                                        |
| France         | Orange             | 208   | 01    |                                                                        |
| United Kingdom | Vodafone           | 234   | 15    |                                                                        |
| Japan          | NTT DoCoMo         | 440   | 10    |                                                                        |
| China          | China Mobile       | 460   | 00, 02 | Note: China Mobile uses multiple MNCs.                               |

**E.  Important Considerations:**

*   **Network Changes:** MCC/MNC values can be reassigned or changed when networks merge or are acquired. Always verify the most up-to-date information.
*   **Virtual Network Operators (MVNOs):** MVNOs (e.g., Mint Mobile in the US) may use the MCC/MNC of the host network on which they operate, or they may have their own assigned values.  Research the specific MVNO.
*   **Testing:** After configuring the MCC/MNC, test your setup to confirm that devices are able to associate with your fake base station. If devices fail to connect, double-check the MCC/MNC and other network parameters.


## 2. Modify `osmo-sgsn.cfg`

Open `osmo-sgsn.cfg` and change:

The bind UDP local and listen IP from 192.168.1.23 to your interface IP

## Usage

### Step 1: Run the main script

```bash
sudo ./run.sh
```

### Step 2: Set up the 2G EGPRS Fake Base Station

In the Osmocom terminal that appears:

```bash
./tun.sh
./osmo-all.sh start
osmo-trx-uhd
```

### Step 3: Configure IP forwarding on the host

In a separate terminal, set up IP forwarding:

```bash
bash reset_iptables.sh
./srsepc_if_masq.sh your_interface
```
Replace your_interface with your network interface name (e.g., eth0, wlan0).

### Step 4: Configure and start the LTE Node redirector

In the LTE redirector terminal, enter the following commands one by one. **It is crucial to use values relevant to your target network and regulatory domain. Conduct thorough research to ensure accuracy.**

```bash
write mcc 310          # Replace with target network MCC. Examples: 310 (USA), 262 (Germany), 208 (France).  Find a complete list at https://en.wikipedia.org/wiki/Mobile_country_code

write mnc 260          # Replace with target network MNC. Examples (USA): 260 (T-Mobile), 410 (AT&T), 120 (Sprint - may be decommissioned).  Check https://en.wikipedia.org/wiki/Mobile_Network_Code for listings.

write tracking_area_code 12345 # Choose a suitable TAC (1-65535). Common values are often network-specific and regionally diverse, requiring local research.

write mcc 310          # Confirm MCC again

write mnc 260          # Confirm MNC again

write band 2           # Set appropriate LTE band.

# Options for 'band' (Examples - consult local spectrum allocations):
#   2: 1900 MHz (PCS) - Commonly used in the Americas
#   4: 1700/2100 MHz (AWS) - Common in the Americas
#   7: 2600 MHz - Used in Europe and Asia
#   12: 700 MHz - Used in the USA
#   13: 700 MHz - Verizon (USA)
#   20: 800 MHz - Europe
#   28: 700 MHz - Asia-Pacific
#  Check local spectrum regulations for permitted bands.

write dl_earfcn 775     # Calculate and set the correct EARFCN for the chosen band and downlink frequency.
#   EARFCN Calculation:  The EARFCN depends on the downlink frequency and LTE band.  Use an online calculator like https://www.cellmapper.net/arfcn or consult 3GPP specifications.
#   Example: For Band 2 (1900 MHz), a common EARFCN might be around 775, but this *must* be verified against the specific frequency used by the target network in your area.

write tx_gain 80      # Adjust transmit gain (0-100). Higher values increase signal strength, but can cause interference or violate regulations.
write rx_gain 30      # Adjust receive gain (0-50). Optimize for signal reception.
start                  # Starts the LTE redirector
```

## Troubleshooting

- If the attack doesn't work, try adjusting the tx_gain and rx_gain values.
- Ensure your SDR hardware is properly connected and recognized.
- Verify that the MCC/MNC values match your target network.
- Check system logs for any errors in the Osmocom or srsRAN components.

## Contributing

Pull requests and issues that help improve this project are welcome. Please be constructive with feedback as this is a solo project.

## References

- [Build video tutorial](https://youtu.be/0aruLybY__w)
- [Osmocom Project](https://osmocom.org/)
- [srsRAN](https://www.srslte.com/)
- [EARFCN Calculator](https://www.cellmapper.net/arfcn) (Example - Use a trusted online EARFCN calculator)
- [LTE Frequency Bands](https://en.wikipedia.org/wiki/LTE_frequency_bands) (Wikipedia)
- [List of mobile country codes](https://en.wikipedia.org/wiki/Mobile_country_code) (Wikipedia)
- [Mobile Network Code](https://en.wikipedia.org/wiki/Mobile_Network_Code) (Wikipedia)

**Additional Resources:**

*   [3GPP Specifications](https://www.3gpp.org/specifications) - Official documentation for cellular standards. Requires significant technical knowledge.


## Legal Notice

This tool is intended for security research, testing on your own networks, or in controlled environments with proper authorization. Unauthorized use against third-party networks may violate local laws.
