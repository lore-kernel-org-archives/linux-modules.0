Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED9C433EF
	for <linux-modules@archiver.kernel.org>; Mon,  9 May 2022 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiEIBxa (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 8 May 2022 21:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiEIBq0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 8 May 2022 21:46:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A129E3BF9D;
        Sun,  8 May 2022 18:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NuGSALwoLk4dQeQSKTaMdHjmaUOrXItUM4Q9Ls2i1Oc=; b=st/9uAHX4XrWNsxGP0umYxBgg/
        DrgyN0OrxK18w0lI8wKiK3F1D/ZSideEp6TClnHVf4bXj+DnLOprzL/kpcYX20rNnZtFUAETXnACI
        NrR4dBKGcooh3o9pbYIL1sabjC/6C2u0qFbVrjmqt84jvw/ZBz1QJTJFugwHJ0YbOagNKbrERb7Xj
        DC1/myYrbNRTE/3NKFrZPd6gi+AT5VS30OQ/+7+Vym0Hg84QwjQhsA/ZM0YwTHLW5nRPoBHW/aok7
        S9gIxHOFhwaM6UnAi2Y5imadRrfhgPHUxG598VPJ3svXo/ekU30ulT9nLgyxLha257KeazjdpJuMG
        YL/cNS4g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnsPs-00BzTe-Q1; Mon, 09 May 2022 01:42:28 +0000
Date:   Sun, 8 May 2022 18:42:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        "fnovak@us.ibm.com" <fnovak@us.ibm.com>
Subject: Re: request_module DoS
Message-ID: <YnhxhIsSTCwSPphy@bombadil.infradead.org>
References: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
 <77ecde32-e868-5804-d9a5-3bb22d314777@csgroup.eu>
 <YnYnjLXm6atlznPT@bombadil.infradead.org>
 <YnbFJ0fn5gLTRLX7@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnbFJ0fn5gLTRLX7@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, May 07, 2022 at 12:14:47PM -0700, Luis Chamberlain wrote:
> On Sat, May 07, 2022 at 01:02:20AM -0700, Luis Chamberlain wrote:
> > You can try to reproduce by using adding a new test type for crypto-aegis256
> > on lib/test_kmod.c. These tests however can try something similar but other
> > modules.
> > 
> > /tools/testing/selftests/kmod/kmod.sh -t 0008
> > /tools/testing/selftests/kmod/kmod.sh -t 0009
> > 
> > I can't decipher this yet.
> 
> Without testing it... but something like this might be an easier
> reproducer:
> 
> +	config_set_driver crypto-aegis256

If the module is not present though nothing really happens, and so
is it possible this is another issue?

Below a bogus module request.

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..a747ad549940 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -65,6 +66,7 @@ ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
 ALL_TESTS="$ALL_TESTS 0012:1:1"
 ALL_TESTS="$ALL_TESTS 0013:1:1"
+ALL_TESTS="$ALL_TESTS 0014:150:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -504,6 +506,17 @@ kmod_test_0013()
 		"cat /sys/module/${DEFAULT_KMOD_DRIVER}/sections/.*text | head -n1"
 }
 
+kmod_test_0014()
+{
+	kmod_defaults_driver
+	MODPROBE_LIMIT=$(config_get_modprobe_limit)
+	let EXTRA=$MODPROBE_LIMIT/6
+	config_set_driver bogus_module_does_not_exist
+	config_num_thread_limit_extra $EXTRA
+	config_trigger ${FUNCNAME[0]}
+	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -525,6 +538,7 @@ list_tests()
 	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
 	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
 	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
+	echo "0014 x $(get_test_count 0014) - multithreaded - push kmod_concurrent over max_modprobes for request_module() for a missing module"
 }
 
 usage()
