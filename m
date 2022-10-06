Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C3BC433FE
	for <linux-modules@archiver.kernel.org>; Thu,  6 Oct 2022 16:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJFQiQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJFQiP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Oct 2022 12:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F41CE9BD
        for <linux-modules@vger.kernel.org>; Thu,  6 Oct 2022 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665074293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEpKybDwIIb0k1AUZxnrl1NRW+TcgE4ZiwpoFiD+2/o=;
        b=T4Tf816AyUg78mhk+21LTH1pWyQQJZJ4U1Wr+tchD2d1Ny63dlve03FzoRYPVfVl2wbdAe
        iAZPr3LCDaEICOGxz+wnFM/8x5zcnsE3JJ0yyE/duW+PpLnnvaHwwETTSpuZ9d6akntxKt
        05JUsE1+qdG3GIXKl9Zm7Cjvpdmh4W8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-gYfSh0S0NgKF4lM26m8WQg-1; Thu, 06 Oct 2022 12:38:12 -0400
X-MC-Unique: gYfSh0S0NgKF4lM26m8WQg-1
Received: by mail-wr1-f69.google.com with SMTP id l6-20020adfa386000000b0022e6b57045bso717053wrb.20
        for <linux-modules@vger.kernel.org>; Thu, 06 Oct 2022 09:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEpKybDwIIb0k1AUZxnrl1NRW+TcgE4ZiwpoFiD+2/o=;
        b=XtrowfCd6moe1UGdJcQkVAsnyQqeog9ZpXHy2e4zcLmj4B6cYJlhBAmV1COGVoUi7e
         42xuRZYoZY9Qf2gLQPqJILm/07apogZmE2dNbNyz2zBkh4EidOYSqk5TypAVihl58tOq
         BTkViO+H1//TLKfSzY8Z4PUrcbOFB9bnLRfwp8QH0751GUQoRPj45418NfcE4qvWk4bN
         UrY3ceIZIyg9F9LfuZOr4OcJvCnQCoO8TygfjDwjbyaxg9OHJ0IHD0L3qOPXV0SCE635
         bPYMVhZSfxDrwJhEd/ihx0z7N6UbIQRflvh4t9XAbSLNqwAbjDch1AFAb0/+y4Etmm3O
         NHZQ==
X-Gm-Message-State: ACrzQf1jhwQgh0JN3hUM0NFCEIgKbgb1EcCPv6rGeUSEe/MC9tv2PyfE
        Pmvs9vfErNJ7Ychq6/VkBaNqIV7DzfQ2BNjeXt4s81bH05C42pBuLzEoBKHQm5QItm6zHi/syBq
        vj2Hkp/vKmDZrn4LuT7gPQ9sf
X-Received: by 2002:adf:db03:0:b0:22e:47a0:c455 with SMTP id s3-20020adfdb03000000b0022e47a0c455mr623729wri.54.1665074290937;
        Thu, 06 Oct 2022 09:38:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sJaSmZC7Zqmac4HCz2ut86SBFfniEHgzmCX6xcd+GIkW+bX3ysIGJ1QugXtqltQcFmMbNMw==
X-Received: by 2002:adf:db03:0:b0:22e:47a0:c455 with SMTP id s3-20020adfdb03000000b0022e47a0c455mr623716wri.54.1665074290758;
        Thu, 06 Oct 2022 09:38:10 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b00228a6ce17b4sm17974302wra.37.2022.10.06.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:38:10 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:38:09 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: "Unloaded tainted modules:" prints repeated wrong value
Message-ID: <20221006163809.6gzl23ylu36gerli@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YzwraXZ3J0p7lch2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzwraXZ3J0p7lch2@localhost.localdomain>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-10-04 15:47 +0300, Alexey Dobriyan wrote:
> I got obiously incorrect values of "pcc_cpufreq():1" on a clean kernel
> and clean oops (see below). Original oops is different bug.

Hi Alexey,

[Added Luis Chamberlain and linux-modules@vger.kernel.org on Cc]

Sorry about that!

Indeed, in the context of the module deletion code path, no module
record/or entry should be added to 'unloaded_tainted_modules' if
the module does not carry a taint. I will send a patch shortly.
The following solution should be sufficient:

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 7f8133044d09..af52cabfe632 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -21,6 +21,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&



Kind regards,

-- 
Aaron Tomlin

