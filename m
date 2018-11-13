Return-Path: <SRS0=A0aH=NY=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B0C43441
	for <linux-modules@archiver.kernel.org>; Tue, 13 Nov 2018 19:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B7521582
	for <linux-modules@archiver.kernel.org>; Tue, 13 Nov 2018 19:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B7521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKNFdt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:33:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34181 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeKNFdt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 14 Nov 2018 00:33:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F9C63D955;
        Tue, 13 Nov 2018 19:34:16 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C579D1019625;
        Tue, 13 Nov 2018 19:34:15 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] testsuite: add simple test for --show-exports
References: <20181113184640.3671-1-lucas.demarchi@intel.com>
Date:   Tue, 13 Nov 2018 21:34:14 +0200
In-Reply-To: <20181113184640.3671-1-lucas.demarchi@intel.com> (Lucas De
        Marchi's message of "Tue, 13 Nov 2018 10:46:40 -0800")
Message-ID: <xunysh04kc09.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 13 Nov 2018 19:34:16 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 13 Nov 2018 10:46:40 -0800, Lucas De Marchi  wrote:

 > ---
 >  testsuite/populate-modules.sh                 |  1 +
 >  .../test-modprobe/show-exports/correct.txt    |  1 +
 >  testsuite/test-modprobe.c                     | 22 +++++++++++++++++++
 >  3 files changed, 24 insertions(+)
 >  create mode 100644 testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt

 > diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
 > index b77e71e..ba68a69 100755
 > --- a/testsuite/populate-modules.sh
 > +++ b/testsuite/populate-modules.sh
 > @@ -39,6 +39,7 @@ map=(
 >      ["test-modprobe/show-depends/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
 >      ["test-modprobe/show-depends/lib/modules/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
 >      ["test-modprobe/show-depends/lib/modules/4.4.4/kernel/mod-simple.ko"]="mod-simple.ko"
 > +    ["test-modprobe/show-exports/mod-loop-a.ko"]="mod-loop-a.ko"
 >      ["test-modprobe/softdep-loop/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
 >      ["test-modprobe/softdep-loop/lib/modules/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
 >      ["test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
 > diff --git a/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt b/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
 > new file mode 100644
 > index 0000000..bc2d045
 > --- /dev/null
 > +++ b/testsuite/rootfs-pristine/test-modprobe/show-exports/correct.txt
 > @@ -0,0 +1 @@
 > +0x00000000	printA

I'm afraid, it won't work if your kernel is built with
MODVERSIONS enabled.

 > diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
 > index ee9d82d..52a6621 100644
 > --- a/testsuite/test-modprobe.c
 > +++ b/testsuite/test-modprobe.c
 > @@ -95,6 +95,28 @@ DEFINE_TEST(modprobe_show_alias_to_none,
 >  	);
 
 
 > +static noreturn int modprobe_show_exports(const struct test *t)
 > +{
 > +	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
 > +	const char *const args[] = {
 > +		progname,
 > +		"--show-exports", "--quiet", "/mod-loop-a.ko",
 > +		NULL,
 > +	};
 > +
 > +	test_spawn_prog(progname, args);
 > +	exit(EXIT_FAILURE);
 > +}
 > +DEFINE_TEST(modprobe_show_exports,
 > +	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
 > +	.config = {
 > +		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/show-exports",
 > +	},
 > +	.output = {
 > +		.out = TESTSUITE_ROOTFS "test-modprobe/show-exports/correct.txt",
 > +	});
 > +
 > +
 >  static noreturn int modprobe_builtin(const struct test *t)
 >  {
 >  	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
 > -- 
 > 2.19.1.1.g56c4683e68


-- 
WBR,
Yauheni Kaliuta
