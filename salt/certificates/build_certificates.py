#!/usr/bin/env python3

from os import chmod
import subprocess


def build_CA_key():
    "Build certificate authority secret key"
    cmd = "openssl genrsa -aes256 -out ca.key 4096"
    subprocess.call(cmd.split())
    chmod('ca.key', 0o400)


def build_CA_cert():
    "Build certificate authority public certificate"
    cmd = ("openssl", "req",
           "-key", "ca.key",
           "-new", "-x509", "-days", "7300", "-sha256", "-extensions", "v3_ca",
           "-subj", "/C=42/ST=Netocracy/O=Netocrat Brewery/OU=Import-Export/CN=Bar Master",
           "-out", "ca.cert.pem")
    print(cmd)
    subprocess.call(cmd)
    chmod('ca.key', 0o444)


def print_CA_cert():
    cmd = "openssl x509 -noout -text -in ca.cert.pem"
    subprocess.call(cmd.split())


def build_DEVICE_cert():
    "Build device secret key"
    cmd = "openssl genrsa -out device.key 4096"
    subprocess.call(cmd.split())


def build_DEVICE_csr():
    "Generate device certificate signing request"
    cmd = ("openssl", "req", "-new",
           "-config", "openssl.cnf",
           "-key", "device.key",
           "-subj", "/C=42/ST=Netocracy/O=Netocrat Brewery/OU=Import-Export/CN=mail.okso.be",
           "-out", "device.csr")
    print(' '.join(cmd))
    subprocess.call(cmd)


def sign_DEVICE_csr():
    "Sign the device certificate signing request"
    cmd = ("openssl x509 -req "
            "-in device.csr "
            "-CA ca.cert.pem "
            "-CAkey ca.key "
            "-CAcreateserial "
            "-out device.crt "
            "-days 500")
    subprocess.call(cmd.split())


def verify_DEVICE_certificate():
    "Verify the device certificate from CA certificate"
    cmd = "openssl verify -CAfile ca.cert.pem device.crt"
    subprocess.call(cmd.split())

def export_DEVICE_for_cadroid():
    "Export the device certificate in DER format"
    cmd = ("openssl x509 "
           "-in ca.cert.pem "
           "-outform DER "
           "-out ca.der.crt")
    subprocess.call(cmd.split())


def main():
    build_CA_key()
    build_CA_cert()
    print_CA_cert()

    build_DEVICE_cert()
    build_DEVICE_csr()
    sign_DEVICE_csr()
    verify_DEVICE_certificate()
    export_DEVICE_for_cadroid()

if __name__ == '__main__':
    main()
