Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B336C433FE
	for <linux-modules@archiver.kernel.org>; Mon, 10 Oct 2022 22:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJJW0Y (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJW0W (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Oct 2022 18:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCF74DDE
        for <linux-modules@vger.kernel.org>; Mon, 10 Oct 2022 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665440780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYDszS9Twkbl1aJjHnVtMr+zqtaXoXBzM/5HeDn8Wys=;
        b=f8py7j6zS0tC7jIARd3giCeuzFLcT7Otlf9rHmqmhBZDjmnuCDxhUh6TU2z44PsAIXnwry
        1fR1HoSX/U2NXiGosPD5sYCbceun3fPYBqpZV+Q/l4Rx9MzYCJ7uJ4kL8rxnSPkDM8Cr4M
        bmcXy7izHLnLLjtNs2WjHRegcIxgnz0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-9ITbHSjAOD2BBv3LHYzIhg-1; Mon, 10 Oct 2022 18:25:57 -0400
X-MC-Unique: 9ITbHSjAOD2BBv3LHYzIhg-1
Received: by mail-wm1-f72.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so3448320wma.0
        for <linux-modules@vger.kernel.org>; Mon, 10 Oct 2022 15:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYDszS9Twkbl1aJjHnVtMr+zqtaXoXBzM/5HeDn8Wys=;
        b=g3mCgpFPiVKdX7ig95G219DbcbIY3/9gPugx/bqG9kslFOyqFwPD6GRX3xO6Zvv9se
         0+cJBAq+arBbYY6TSAz7a9gbrT+S24zVGjMyGtnUmWgnuA+rVN6tm11NfD5VIjyNXfuK
         IBsTBcUULEn0k47AZSgSQ853pKqtc9NlkWulZ5wnB98hQX8VCvQ8YHl30AvN+ZQ33dNQ
         EkrxRUTt+hQfJxdExOvE3e+71m1zz1tbVLuiedM+pT/iw9xB/Zu9BSahN3I5Ie43MbE2
         StT6zMwBoKNAPQCUwy+mpqvBqan7PRsnGP6eu2d9aWv+S2GYuYnZvxjChKBqP0vrRVac
         duxA==
X-Gm-Message-State: ACrzQf1yn/1xMV5Ew7QJltNxq2UHEQ+mrFrYiIA8w84C9yQzpxiBm7Es
        3iSS/SMGpkKRTnq9d1t6l8c4I6K7OxQOEV8pI5KZKhyxzZ47cCggHJWtAhM9ptdsyOriSb4VtCR
        6uJ0EeNI52vTtjztE2OgoaGK9
X-Received: by 2002:a05:600c:1910:b0:3b4:bb80:c95e with SMTP id j16-20020a05600c191000b003b4bb80c95emr13376214wmq.54.1665440756035;
        Mon, 10 Oct 2022 15:25:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5EytGIstdUr/SmKOaCQyEfqdbYN89t4k/lTEhu5ubbuFhs+FwISjKmA8HLWYraVdUlMpgruA==
X-Received: by 2002:a05:600c:1910:b0:3b4:bb80:c95e with SMTP id j16-20020a05600c191000b003b4bb80c95emr13376208wmq.54.1665440755824;
        Mon, 10 Oct 2022 15:25:55 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d49cf000000b0022dc6e76bbdsm9913034wrs.46.2022.10.10.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:25:54 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:25:54 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unloaded tainted modules list with tcrypt
Message-ID: <20221010222554.4ydgxs2j22arwje3@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-10-10 15:12 +0000, Elliott, Robert (Servers) wrote:
> When repeatedly using the tcrypt module (which is designed to never
> load successfully), the "Unloaded tainted modules" list grows forever:
> 
> Unloaded tainted modules: tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 
> tcrypt():1 tcrypt():1 padlock_aes():1 padlock_aes():1 
> isst_if_mbox_msr():1 acpi_cpufreq():1 pcc_cpufreq():1 isst_if_mbox_msr():1 
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1 
> pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1 
> isst_if_mbox_msr():1 isst_if_mbox_msr():1 
> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 isst_if_mbox_msr():1
> 
> Some other modules like acpi_cpufreq() are repeated too.
> 
> Maybe this check after the name comparison:
> 	mod_taint->taints & mod->taints
> should be:
> 	mod_taint->taints == mod->taints
> 
> or shouldn't be there at all?
> 

Hi Elliot,

Sorry about that.

This is already addressed in linux-next:

commit a0830747f4e6810876e5f5329ce941e258e13a22
Author: Aaron Tomlin <atomlin@redhat.com>
Date:   Fri Oct 7 14:32:44 2022 +0100

    module: tracking: Keep a record of tainted unloaded modules only
    
    This patch ensures that no module record/or entry is added to the
    unloaded_tainted_modules list if it does not carry a taint.
    
    Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
    Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
    
    Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index a139e63b6f20..26d812e07615 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -22,6 +22,9 @@ int try_add_tainted_module(struct module *mod)
 
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

