Return-Path: <SRS0=C6ur=4O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C0C4BA0A
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 03:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD53222C2
	for <linux-modules@archiver.kernel.org>; Wed, 26 Feb 2020 03:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bspu.by header.i=@bspu.by header.b="eJC+R9sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgBZDKj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:10:39 -0500
Received: from mail.bspu.by ([82.209.244.151]:52260 "EHLO mail.bspu.by"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbgBZDKj (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 25 Feb 2020 22:10:39 -0500
X-Greylist: delayed 1005 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 22:10:38 EST
Received: from bspu.by (www.bspu.by [82.209.244.150])
        (authenticated bits=0)
        by mail.bspu.by (8.15.2/8.15.2) with ESMTPSA id 01Q2rjTF012107
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <linux-modules@vger.kernel.org>; Wed, 26 Feb 2020 05:53:50 +0300
Authentication-Results: mail.bspu.by; dmarc=fail (p=reject dis=none) header.from=bspu.by
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bspu.by; s=default;
        t=1582685630; bh=HceND1pa30ctSJOZbw+NjQjzhXg8s7/aP9SLRYltXrM=;
        h=Date:From:To:Subject:Reply-To;
        b=eJC+R9sKonLUqqTKCs4aQE/TmVXEMJMSfSqpkpcI+oUJxYGDW4ymvr39JtAszdkV5
         0bqzI6RQRbBLPNIzVyu7q1638s8pO2IUsZe9ydiu8sRlfMs4WIqUW9O+9Bk67HS5Yr
         4od2PzgUCK1uDK78f1/4thZ/8q3xZFVlKeelu1Ac=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Feb 2020 04:53:45 +0200
From:   Denis Kaganovich <mahatma@bspu.by>
To:     linux-modules@vger.kernel.org
Subject: modinfo must show real module info, not context if filename set
Reply-To: mahatma@eu.by
Mail-Reply-To: mahatma@eu.by
Message-ID: <dda23def071a8d087cca3538289de1e0@bspu.by>
X-Sender: mahatma@bspu.by
User-Agent: Roundcube Webmail/1.2.6
X-Remote-Browser: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0)
 Gecko/20100101 Firefox/52.0 SeaMonkey/2.49.5
X-Originating-IP: 46.216.160.19
X-RoundCube-Server: bspu.by
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

After commit e7e2cb61fa9f1db3429d91ef6accff549500d268, even if real 
filename
passed - modinfo show info from context (so, I got built-in info from 
running
kernel, but asking for new kernel's external module). This behaviour 
unobvious
and incompatible with pre-v27. Simple use fake context for filename - 
IMHO
much less ugly then current results.

Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>

--- a/tools/modinfo.c	2020-02-25 13:46:38.181693570 +0300
+++ b/tools/modinfo.c	2020-02-26 05:18:39.393790919 +0300
@@ -359,7 +359,7 @@ static bool is_module_filename(const cha

  static int do_modinfo(int argc, char *argv[])
  {
-	struct kmod_ctx *ctx;
+	struct kmod_ctx *ctx, *ctx0;
  	char dirname_buf[PATH_MAX];
  	const char *dirname = NULL;
  	const char *kversion = NULL;
@@ -437,7 +437,8 @@ static int do_modinfo(int argc, char *ar
  	}

  	ctx = kmod_new(dirname, &null_config);
-	if (!ctx) {
+	ctx0 = kmod_new("/dev/null", &null_config);
+	if (!ctx || !ctx0) {
  		ERR("kmod_new() failed!\n");
  		return EXIT_FAILURE;
  	}
@@ -448,7 +449,7 @@ static int do_modinfo(int argc, char *ar
  		int r;

  		if (is_module_filename(name))
-			r = modinfo_path_do(ctx, name);
+			r = modinfo_path_do(ctx0, name);
  		else
  			r = modinfo_alias_do(ctx, name);

@@ -456,6 +457,7 @@ static int do_modinfo(int argc, char *ar
  			err = r;
  	}

+	kmod_unref(ctx0);
  	kmod_unref(ctx);
  	return err >= 0 ? EXIT_SUCCESS : EXIT_FAILURE;
  }
