Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Ferry van Steen <Ferry.van.Steen@citrus.nl>,
	David Howells <dhowells@redhat.com>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC PKCS7 kernel vm 0/1] kernel version of PKCS#7 parser
Date: Mon, 12 Mar 2018 22:46:32 +0200
Message-Id: <20180312204633.16826-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

This is how the version, based on the kernel ASN.1 compiler may look like.

Yauheni Kaliuta (1):
  libkmod-signature: implement pkcs7 parsing with kernel asn1 compiler

 Makefile.am                                     |   33 +-
 libkmod/libkmod-internal.h                      |    3 +
 libkmod/libkmod-module.c                        |    5 +-
 libkmod/libkmod-signature.c                     |  105 +-
 libkmod/pkcs7/asn1_compiler.c                   | 1615 +++++++++++++++++++++++
 libkmod/pkcs7/asn1_decoder.c                    |  514 ++++++++
 libkmod/pkcs7/include/linux/asn1.h              |   69 +
 libkmod/pkcs7/include/linux/asn1_ber_bytecode.h |   94 ++
 libkmod/pkcs7/include/linux/asn1_decoder.h      |   25 +
 libkmod/pkcs7/include/linux/oid_registry.h      |  103 ++
 libkmod/pkcs7/oid_registry.c                    |  168 +++
 libkmod/pkcs7/oid_registry_data.c               |  190 +++
 libkmod/pkcs7/pkcs7.asn1                        |  135 ++
 libkmod/pkcs7/pkcs7_parser.c                    |  382 ++++++
 libkmod/pkcs7/pkcs7_parser.h                    |   19 +
 15 files changed, 3441 insertions(+), 19 deletions(-)
 create mode 100644 libkmod/pkcs7/asn1_compiler.c
 create mode 100644 libkmod/pkcs7/asn1_decoder.c
 create mode 100644 libkmod/pkcs7/include/linux/asn1.h
 create mode 100644 libkmod/pkcs7/include/linux/asn1_ber_bytecode.h
 create mode 100644 libkmod/pkcs7/include/linux/asn1_decoder.h
 create mode 100644 libkmod/pkcs7/include/linux/oid_registry.h
 create mode 100644 libkmod/pkcs7/oid_registry.c
 create mode 100644 libkmod/pkcs7/oid_registry_data.c
 create mode 100644 libkmod/pkcs7/pkcs7.asn1
 create mode 100644 libkmod/pkcs7/pkcs7_parser.c
 create mode 100644 libkmod/pkcs7/pkcs7_parser.h

-- 
2.16.2
