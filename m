Return-Path: <SRS0=bBDI=QL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31432C282C4
	for <linux-modules@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA3020821
	for <linux-modules@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBDWlR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfBDWlR (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 4 Feb 2019 17:41:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4F3D217B;
        Mon,  4 Feb 2019 22:41:16 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59D6117537;
        Mon,  4 Feb 2019 22:41:15 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/2] testsuite: fix modinfo test without openssl
References: <20190204223249.27531-1-lucas.demarchi@intel.com>
Date:   Tue, 05 Feb 2019 00:41:17 +0200
In-Reply-To: <20190204223249.27531-1-lucas.demarchi@intel.com> (Lucas De
        Marchi's message of "Mon, 4 Feb 2019 14:32:48 -0800")
Message-ID: <xunymunb6usy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 04 Feb 2019 22:41:16 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

Oops :)

Thanks for fixing that!

>>>>> On Mon,  4 Feb 2019 14:32:48 -0800, Lucas De Marchi  wrote:

 > ---
 >  .../correct-sig_hashalgo-openssl.txt             |  3 +++
 >  .../test-modinfo/correct-sig_hashalgo.txt        |  3 ++-
 >  .../test-modinfo/correct-sig_key-openssl.txt     |  3 +++
 >  .../test-modinfo/correct-sig_key.txt             |  2 +-
 >  .../test-modinfo/correct-signer-openssl.txt      |  3 +++
 >  .../test-modinfo/correct-signer.txt              |  2 +-
 >  testsuite/test-modinfo.c                         | 16 ++++++++++++----
 >  7 files changed, 25 insertions(+), 7 deletions(-)
 >  create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt
 >  create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt
 >  create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt

 > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt
 > new file mode 100644
 > index 0000000..f97c4fa
 > --- /dev/null
 > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt
 > @@ -0,0 +1,3 @@
 > +sha1
 > +sha256
 > +sha256
 > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt
 > index f97c4fa..23cb933 100644
 > --- a/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt
 > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt
 > @@ -1,3 +1,4 @@
 >  sha1
 >  sha256
 > -sha256
 > +unknown
 > +
 > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt
 > new file mode 100644
 > index 0000000..25a75a8
 > --- /dev/null
 > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt
 > @@ -0,0 +1,3 @@
 > +E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
 > +E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
 > +26:DA:C3:EB:0F:0D:1A:56:A2:D8:B2:13:F0:D7:53:47:1D:0D:48:68
 > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt
 > index 25a75a8..7dc4c6a 100644
 > --- a/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt
 > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt
 > @@ -1,3 +1,3 @@
 >  E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
 >  E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
 > -26:DA:C3:EB:0F:0D:1A:56:A2:D8:B2:13:F0:D7:53:47:1D:0D:48:68
 > +
 > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt b/testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt
 > new file mode 100644
 > index 0000000..2b979f9
 > --- /dev/null
 > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt
 > @@ -0,0 +1,3 @@
 > +Magrathea: Glacier signing key
 > +Magrathea: Glacier signing key
 > +Build time autogenerated kernel key
 > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt b/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt
 > index 2b979f9..afe83df 100644
 > --- a/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt
 > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt
 > @@ -1,3 +1,3 @@
 >  Magrathea: Glacier signing key
 >  Magrathea: Glacier signing key
 > -Build time autogenerated kernel key
 > +
 > diff --git a/testsuite/test-modinfo.c b/testsuite/test-modinfo.c
 > index 504d9dd..373dc95 100644
 > --- a/testsuite/test-modinfo.c
 > +++ b/testsuite/test-modinfo.c
 > @@ -27,7 +27,7 @@
 
 >  static const char *progname = ABS_TOP_BUILDDIR "/tools/modinfo";
 
 > -#define DEFINE_MODINFO_TEST(_field, ...) \
 > +#define DEFINE_MODINFO_TEST(_field, _flavor, ...) \
 >  static noreturn int test_modinfo_##_field(const struct test *t) \
 >  { \
 >  	const char *const args[] = { \
 > @@ -44,20 +44,28 @@ DEFINE_TEST(test_modinfo_##_field, \
 >  		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modinfo/", \
 >  	}, \
 >  	.output = { \
 > -		.out = TESTSUITE_ROOTFS "test-modinfo/correct-" #_field ".txt", \
 > +		.out = TESTSUITE_ROOTFS "test-modinfo/correct-" #_field #_flavor ".txt", \
 >  	})
 
 >  #define DEFINE_MODINFO_GENERIC_TEST(_field) \
 > -	DEFINE_MODINFO_TEST(_field, \
 > +	DEFINE_MODINFO_TEST(_field, , \
 >  			    "/mod-simple-i386.ko", \
 >  			    "/mod-simple-x86_64.ko", \
 >  			    "/mod-simple-sparc64.ko")
 
 > +#ifdef ENABLE_OPENSSL
 >  #define DEFINE_MODINFO_SIGN_TEST(_field) \
 > -	DEFINE_MODINFO_TEST(_field, \
 > +	DEFINE_MODINFO_TEST(_field, -openssl, \
 >  			    "/mod-simple-sha1.ko", \
 >  			    "/mod-simple-sha256.ko",	\
 >  			    "/mod-simple-pkcs7.ko")
 > +#else
 > +#define DEFINE_MODINFO_SIGN_TEST(_field) \
 > +	DEFINE_MODINFO_TEST(_field, , \
 > +			    "/mod-simple-sha1.ko", \
 > +			    "/mod-simple-sha256.ko",	\
 > +			    "/mod-simple-pkcs7.ko")
 > +#endif
 
 >  DEFINE_MODINFO_GENERIC_TEST(filename);
 >  DEFINE_MODINFO_GENERIC_TEST(author);
 > -- 
 > 2.20.0


-- 
WBR,
Yauheni Kaliuta
