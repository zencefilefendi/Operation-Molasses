#!/bin/bash
# ==============================================================================
# 🍯 Zencefil Efendi's Automated Reconnaissance Script (Operation Molasses)
# ==============================================================================
# Description: Advanced reconnaissance pipeline for Operation Molasses.
# Usage: ./zencefil-recon.sh -d <target-domain> [-o <output-dir>] [-s]
# ==============================================================================

# Default values
TARGET=""
OUTDIR=""
SILENT=0

# Helper Functions
print_info() { [ $SILENT -eq 0 ] && echo -e "\033[34m[*]\033[0m $1"; }
print_success() { [ $SILENT -eq 0 ] && echo -e "\033[32m[+]\033[0m $1"; }
print_error() { echo -e "\033[31m[!]\033[0m $1" >&2; }
print_warning() { echo -e "\033[33m[-]\033[0m $1" >&2; }

# Dependency Check
check_deps() {
    local deps=("whois" "subfinder" "nmap")
    local missing=0
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            print_error "Dependency missing: $dep"
            missing=1
        fi
    done
    if [ $missing -eq 1 ]; then
        print_warning "Some tools are missing. Partial results will be generated."
    fi
}

# Parse Arguments
while getopts "d:o:sh" opt; do
  case ${opt} in
    d ) TARGET=$OPTARG ;;
    o ) OUTDIR=$OPTARG ;;
    s ) SILENT=1 ;;
    h ) echo "Usage: ./zencefil-recon.sh -d <target-domain> [-o <output-dir>] [-s silent]"
        exit 0 ;;
    \? ) echo "Usage: ./zencefil-recon.sh -d <target-domain> [-o <output-dir>] [-s silent]"
         exit 1 ;;
  esac
done

if [ -z "$TARGET" ]; then
    print_error "No target specified."
    echo "Usage: ./zencefil-recon.sh -d <target-domain>"
    exit 1
fi

[ -z "$OUTDIR" ] && OUTDIR="recon_$TARGET"

print_info "=================================================="
print_info "🕵️  Starting Operation Molasses Recon on: $TARGET"
print_info "=================================================="

check_deps
mkdir -p "$OUTDIR"

# 1. WHOIS
print_info "1. Extracting WHOIS data..."
if command -v whois &> /dev/null; then
    whois "$TARGET" > "$OUTDIR/whois.txt" 2>/dev/null
    print_success "Saved to $OUTDIR/whois.txt"
else
    print_warning "Skipping WHOIS."
fi

# 2. Subdomains
print_info "2. Enumerating Subdomains (Subfinder)..."
if command -v subfinder &> /dev/null; then
    subfinder -d "$TARGET" -o "$OUTDIR/subdomains.txt" -silent > /dev/null 2>&1
    print_success "Saved to $OUTDIR/subdomains.txt"
else
    print_warning "Skipping Subfinder."
fi

# 3. NMAP
print_info "3. Running aggressive NMAP scan on target..."
if command -v nmap &> /dev/null; then
    nmap -T4 -A "$TARGET" -oN "$OUTDIR/nmap_scan.txt" > /dev/null 2>&1
    print_success "Saved to $OUTDIR/nmap_scan.txt"
else
    print_warning "Skipping NMAP."
fi

print_info "=================================================="
print_info "🍯 Recon completed. Zencefil Efendi is pleased."
print_info "Results saved in directory: $OUTDIR/"
print_info "=================================================="
