Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from ra.se.axis.com ([195.60.68.13]:33320 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757346Ab3KIWHA (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sat, 9 Nov 2013 17:07:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 4AF2725AEF
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2013 22:57:47 +0100 (CET)
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3jQCEUlidzLE for <linux-modules@vger.kernel.org>;
	Sat,  9 Nov 2013 22:57:45 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id C812225B1B
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2013 22:57:45 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 7C70A4E2
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2013 22:57:45 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 6BA86B41
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2013 22:57:45 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id 68C1D3404E
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2013 22:57:45 +0100 (CET)
From: Anders Olofsson <anders.olofsson@axis.com>
To: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Date: Sat, 9 Nov 2013 22:57:43 +0100
Subject: Patch to allow disabling maintainer mode
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1@xmail3.se.axis.com>
Content-Type: multipart/mixed;
	boundary="_002_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1xmail3seaxisc_"
MIME-Version: 1.0
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

--_002_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1xmail3seaxisc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attached patch will allow make rules for generated build files (i.e. co=
nfigure, Makefile.in, ... ) to be skipped.
This is useful when the source is stored without timestamps (for example in=
 CVS or GIT).

When the build rules trigger to regenerate the build files, it tries to use=
 the same autotools version (currently 1.14) as was originally used for the=
 release. Since many of our build machines run Debian Squeeze, they only ha=
ve autotools 1.11 available and the build fails.

Currently, we have to work around this by touching all the generated files =
before building to avoid triggering the make rule. With this patch, we woul=
d be able to just run configure with --disable-maintainer-mode instead.
The patch sets the default to enable to not change the default behavior.

/Anders Olofsson
Axis Communications

--_002_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1xmail3seaxisc_
Content-Type: application/octet-stream; name="kmod_maintainer_mode.patch"
Content-Description: kmod_maintainer_mode.patch
Content-Disposition: attachment; filename="kmod_maintainer_mode.patch";
	size=419; creation-date="Sat, 09 Nov 2013 22:37:49 GMT";
	modification-date="Sat, 09 Nov 2013 22:37:13 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCAzODE4N2ExLi41
YjQ4NGQ2IDEwMDY0NAotLS0gYS9jb25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC0x
Nyw2ICsxNyw3IEBAIG00X2lmbmRlZihbQU1fU0lMRU5UX1JVTEVTXSwgW200X2RlZmluZShbQU1f
U0lMRU5UX1JVTEVTXSxbXSldKQogQU1fU0lMRU5UX1JVTEVTKFt5ZXNdKQogTFRfSU5JVChbZGlz
YWJsZS1zdGF0aWMgcGljLW9ubHldKQogQUNfUFJFRklYX0RFRkFVTFQoWy91c3JdKQorQU1fTUFJ
TlRBSU5FUl9NT0RFKFtlbmFibGVdKQogCiBBU19JRihbdGVzdCAieCRlbmFibGVfc3RhdGljIiA9
ICJ4eWVzIl0sCiAgICAgICBbQUNfTVNHX0VSUk9SKFstLWVuYWJsZS1zdGF0aWMgaXMgbm90IHN1
cHBvcnRlZCBieSBrbW9kXSldKQo=

--_002_A612847CFE53224C91B23E3A5B48BAC7A40ECEF7D1xmail3seaxisc_--
