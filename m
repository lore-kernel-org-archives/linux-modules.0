Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Mark van Dijk <linux-modules@z.dvxs.net>
Subject: [PATCH 0/4] modinfo: fix sig_id key and add signature output
Date: Tue, 11 Apr 2017 15:14:59 +0300
Message-Id: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Fix a small mistake in modinfo output, signat instead of sig_id.
Implement signature hex ouput as people asked for it.

Yauheni Kaliuta (4):
  libkmod: modinfo: fix sig_id output
  libkmod: modinfo: use own function for sig_key hex output
  libkmod: modinfo: implement line splitting in hex_to_str
  libkmod: modinfo: implement signature output

 libkmod/libkmod-internal.h  |   2 +
 libkmod/libkmod-module.c    | 100 ++++++++++++++++++++++++++++++++------------
 libkmod/libkmod-signature.c |   6 ++-
 3 files changed, 81 insertions(+), 27 deletions(-)

-- 
2.9.2.368.g08bb350
