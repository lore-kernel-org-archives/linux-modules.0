Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17561 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933376Ab3EGNy4 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 7 May 2013 09:54:56 -0400
Date: Tue, 7 May 2013 21:54:54 +0800
From: Yang Chengwei <chengwei.yang@intel.com>
To: kmod <linux-modules@vger.kernel.org>
Cc: "Yang, Chengwei" <chengwei.yang@intel.com>
Subject: [RFC] Fix the kmod internal list behavior?
Message-ID: <20130507135453.GA25275@chengwei-workstation.bj.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi List,

I just found that there are some minor issues in kmod iternal list
implementation implemented by libkmod-list.c.

Say
	1. list_node_append() is identical with list_node_insert_before(),
	so somehow the list_node_append() in fact does "prepend" operation.

	2. just the same as list_node_append(), kmod_list_append() which
	invokes the former just do "prepend" operation rather than "append".

I'd like to fix these internal APIs to do the operation suggested by its
name like
	1. drop list_node_append()
	2. call list_node_insert_after() to do "append" operation
	3. call list_mode_insert_before() to do "prepend" operation

Since the list here is circular linked, so I think these changes should
not break things except the test cases.

Any comments are appreciated.

--
Thanks,
Chengwei

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJRiQetAAoJEG8F0Pe1SMenNm0H/3DJvrI5xjsfm0KkzjDVQ7hA
+2ifXn6KxzJkfGHXvIlx4Srtb354wrT57HaUpf54Y5rCszqldsNA2WYxq1qr0GKP
UeTp2Qr3G0QlPj25YZFhJIhAQ/IkN1+MhQMGXp1dgnsvWsmuKjzZap5pEDmDKj8/
F+rKY6poH1Lw2hklGlMpeD5JKYxz/Obo+tOyzvQM4e2pqDPSwGig31vsZPY+m0ql
mMNSaAlKHp3vTtx3r9a4CiWHgf5al4zeNIqvy4aO+9vjYkIbAgEB3TBs1NE/ijuZ
6fckedYqCdZ2rEQFmkCDT0MMdyg9H2Zpe9y6sBoUtAhxO+C4dSTgbvUtJj8MvBQ=
=245U
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
