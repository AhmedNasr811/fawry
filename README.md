# FAWRY DevOps Internship Tasks

## Task 1: Custom Command (mygrep.sh)

**Description:**
- A mini custom version of `grep` command created using Bash scripting.
- Supports:
  - Case-insensitive search
  - `-n` option to display matching line numbers
  - `-v` option to invert the match (show non-matching lines)
  - Combination of options like `-vn`, `-nv`
- Handles invalid input gracefully.
- Mimics `grep` style output.

**Files Included:**
- `mygrep.sh` → The script
- `testfile.txt` → Sample file for testing

**Example Commands Tested:**
```bash
./mygrep.sh hello testfile.txt
./mygrep.sh -n hello testfile.txt
./mygrep.sh -vn hello testfile.txt
./mygrep.sh -v testfile.txt  # Should warn about missing search string

Task 2: Troubleshooting Scenario

Scenario:
Internal dashboard (internal.example.com) was suddenly unreachable. Users received "host not found" errors.

Investigation Steps:

    Checked /etc/resolv.conf:

        DNS resolver is set to 127.0.0.53 (local systemd-resolved service).

    Used nslookup:

        nslookup internal.example.com (local resolver) → NXDOMAIN

        nslookup internal.example.com 8.8.8.8 (Google DNS) → NXDOMAIN

    Checked service ports:

        netstat -tulnp | grep ':80\|:443' → No service listening on 80/443, but found service listening on 8080.

Possible Causes:

    No DNS record for internal.example.com.

    Web server not listening on port 80/443.

    Local DNS misconfiguration.

    Firewall blocking HTTP/HTTPS ports.

    Wrong routing or network ACLs
