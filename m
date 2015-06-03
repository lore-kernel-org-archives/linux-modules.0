Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:51520 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529AbbFCSLV (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Jun 2015 14:11:21 -0400
Date: Wed, 3 Jun 2015 20:05:25 +0200
To: linux-modules@vger.kernel.org
Subject: Bug#787548: kmod: Small typo in rmmod(8)
Message-ID: <20150603180525.GB4306@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
From: md@Linux.IT (Marco d'Itri)
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--=20
ciao,
Marco

--3MwIy2ne0vdjdPXF
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <debbugs@buxtehude.debian.org>
X-Original-To: md@wonderland.linux.it
Delivered-To: md@wonderland.linux.it
Received: from attila.bofh.it (localhost [IPv6:::1])
	by bongo.bofh.it (Postfix) with ESMTP id 199F92C24B0
	for <md@wonderland.linux.it>; Tue,  2 Jun 2015 19:27:11 +0200 (CEST)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by attila.bofh.it (Postfix) with ESMTPS id F299F2E4B9
	for <md@wonderland.linux.it>; Tue,  2 Jun 2015 19:27:10 +0200 (CEST)
Received: from buxtehude.debian.org (buxtehude.debian.org [140.211.166.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by picard.linux.it (Postfix) with ESMTPS id 5C5BC3E7079
	for <md@linux.it>; Tue,  2 Jun 2015 19:27:10 +0200 (CEST)
Received: from debbugs by buxtehude.debian.org with local (Exim 4.84)
	(envelope-from <debbugs@buxtehude.debian.org>)
	id 1Yzpxx-0006lJ-HK; Tue, 02 Jun 2015 17:27:05 +0000
X-Loop: owner@bugs.debian.org
Subject: Bug#787548: kmod: Small typo in rmmod(8)
Reply-To: Santiago Vila <sanvila@unex.es>, 787548@bugs.debian.org
Resent-From: Santiago Vila <sanvila@unex.es>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sanvila@unex.es, Marco d'Itri <md@linux.it>
X-Loop: owner@bugs.debian.org
Resent-Date: Tue, 02 Jun 2015 17:27:01 +0000
Resent-Message-ID: <handler.787548.B.143326594625730@bugs.debian.org>
X-Debian-PR-Message: report 787548
X-Debian-PR-Package: kmod
X-Debian-PR-Keywords: patch upstream
X-Debian-PR-Source: kmod
Received: via spool by submit@bugs.debian.org id=B.143326594625730
          (code B); Tue, 02 Jun 2015 17:27:01 +0000
Received: (at submit) by bugs.debian.org; 2 Jun 2015 17:25:46 +0000
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on picard.linux.it
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=T_RP_MATCHES_RCVD
	autolearn=disabled version=3.3.2
X-Spam-Bayes: score:0.0000 Tokens: new, 26; hammy, 96; neutral, 25; spammy, 0.
	spammytokens: hammytokens:0.000-+--H*F:U*sanvila, 0.000-+--H*rp:U*sanvila,
	0.000-+--Severity, 0.000-+--H*RU:sanvila@unex.es, 0.000-+--H*c:MIXED
Received: from zmta02.unex.es ([158.49.17.56])
	by buxtehude.debian.org with esmtp (Exim 4.84)
	(envelope-from <sanvila@unex.es>)
	id 1Yzpwf-0006gg-R0
	for submit@bugs.debian.org; Tue, 02 Jun 2015 17:25:46 +0000
Received: from localhost (localhost [127.0.0.1])
	by zmta02.unex.es (Postfix) with ESMTP id 7248E6124D
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:41 +0200 (CEST)
Received: from zmta02.unex.es ([127.0.0.1])
	by localhost (zmta02.servicios.unex.es [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lAM3gmDBOLnV for <submit@bugs.debian.org>;
	Tue,  2 Jun 2015 19:25:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmta02.unex.es (Postfix) with ESMTP id 20B296124E
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zmta02.siue
Received: from zmta02.unex.es ([127.0.0.1])
	by localhost (zmta02.servicios.unex.es [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7YpzgCkLLN_Y for <submit@bugs.debian.org>;
	Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
Received: from zproxy02.unex.es (zproxy02.servicios.unex.es [10.254.208.62])
	by zmta02.unex.es (Postfix) with ESMTP id EB4E06124D
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zproxy02.unex.es (Postfix) with ESMTP id DCD856193F
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
Received: from zproxy02.unex.es ([127.0.0.1])
	by localhost (zproxy02.servicios.unex.es [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id sK4RVDIr6M1y for <submit@bugs.debian.org>;
	Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zproxy02.unex.es (Postfix) with ESMTP id 9411461975
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zproxy02.siue
Received: from zproxy02.unex.es ([127.0.0.1])
	by localhost (zproxy02.servicios.unex.es [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jKWqE-gXgMXI for <submit@bugs.debian.org>;
	Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
Received: from cantor.unex.es (cantor.unex.es [158.49.50.20])
	by zproxy02.unex.es (Postfix) with ESMTPSA id 3103661974
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:40 +0200 (CEST)
Received: by cantor.unex.es (Postfix, from userid 1000)
	id E7CF44240A; Tue,  2 Jun 2015 19:25:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by cantor.unex.es (Postfix) with ESMTP id D8AFA423C8
	for <submit@bugs.debian.org>; Tue,  2 Jun 2015 19:25:39 +0200 (CEST)
Date: Tue, 2 Jun 2015 19:25:34 +0200 (CEST)
From: Santiago Vila <sanvila@unex.es>
To: submit@bugs.debian.org
Message-ID: <alpine.DEB.2.11.1506021905340.24599@cantor.unex.es>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="832443442-922302608-1433265939=:24854"
Delivered-To: submit@bugs.debian.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832443442-922302608-1433265939=:24854
Content-Type: TEXT/PLAIN; charset=US-ASCII

Package: kmod
Version: 20-1
Severity: minor
Tags: upstream, patch

This is how rmmod(8) looks like:

SEE ALSO
       modprobe(8), insmod(8), lsmod(8)modinfo(8)

The attached trivial patch fixes it:

SEE ALSO
       modprobe(8), insmod(8), lsmod(8), modinfo(8)
       
Thanks.
--832443442-922302608-1433265939=:24854
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=rmmod_missing_comma
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.11.1506021925340.24854@cantor.unex.es>
Content-Description: 
Content-Disposition: attachment; filename=rmmod_missing_comma

LS0tIGEvbWFuL3JtbW9kLnhtbA0KKysrIGIvbWFuL3JtbW9kLnhtbA0KQEAg
LTEzNSw3ICsxMzUsNyBAQA0KICAgICAgIDwvY2l0ZXJlZmVudHJ5PiwNCiAg
ICAgICA8Y2l0ZXJlZmVudHJ5Pg0KICAgICAgICAgPHJlZmVudHJ5dGl0bGU+
bHNtb2Q8L3JlZmVudHJ5dGl0bGU+PG1hbnZvbG51bT44PC9tYW52b2xudW0+
DQotICAgICAgPC9jaXRlcmVmZW50cnk+DQorICAgICAgPC9jaXRlcmVmZW50
cnk+LA0KICAgICAgIDxjaXRlcmVmZW50cnk+DQogICAgICAgICA8cmVmZW50
cnl0aXRsZT5tb2RpbmZvPC9yZWZlbnRyeXRpdGxlPjxtYW52b2xudW0+ODwv
bWFudm9sbnVtPg0KICAgICAgIDwvY2l0ZXJlZmVudHJ5Pg0K

--832443442-922302608-1433265939=:24854--

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAABCAAGBQJVb0HkAAoJECv1pcEixPekV44L/18FYA0f983yrXxRW9jh9tH+
/OpvfgM4fngPvB2TkjA8Rb/T10JG6Kq53TiG/kP5wx4EEFGv9DtsZVpGcXln3yTC
YU9+9nMKRiiMTzduReD/Qi+jLDwJGzrAVADFEY2qKd89km8ipChHYnod//AgQOab
ebYkBtUplz8f/EoazVXvOTau2jlgU5gfJ9ZhGwhUXoE5XqSX14z6pk0wvGtmqzJG
U1FpwyffP5h1k+jKzcIesbFJRVQereJXA38oTNe7abNI6mFQSRHSJ03nSiGjpKU3
TfVNF6tEESOg9+CE5/LjFcO/3hEhe0OCle6LUAdpMoQ6VH/hxBtyg9vpA43HJZeu
2XWEG0U3Jz0BYWU6pSKM5kZY8Q1uPLlYjkUlyBTFZdPcFsHNjO4LUtMxdXQC3G9q
jaFv8gMj1ZuhcX7rB3Ih7TKgFAxy9UGjfiz7kJJFbFQ9hq6M39oHPen0MaqA9uSB
wPS8MAmB0ID/Zrb5gyrra4QemgT7rdjzfN0J6sZcUg==
=4MXu
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
