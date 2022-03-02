Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C500BC433EF
	for <linux-modules@archiver.kernel.org>; Wed,  2 Mar 2022 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiCBRC4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbiCBRCx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Mar 2022 12:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D67B8C42BC
        for <linux-modules@vger.kernel.org>; Wed,  2 Mar 2022 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646240529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rd6aip8xWGW26J5sRuqwhGdbjTj2rP5btIv5QWD2Mkg=;
        b=ZsIpHATLwMK0kg/s2Noynry1aw+IUGvw4A0P2fS0PKS2t6XvvVaEWjOV+OScw2G5WyUaeA
        XMUcnbTUZxnViDUPl69Zq+QYCAozT/KDtQ1cAQ/UCr1cVrMFFSTKl2sL7/8GpK62hGvX1M
        tS0Vv1Cfaac3qc3Q0lGjaz/Lbypm2CM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-8mCg7y08MuWhxotGRF-VGA-1; Wed, 02 Mar 2022 12:02:05 -0500
X-MC-Unique: 8mCg7y08MuWhxotGRF-VGA-1
Received: by mail-wr1-f69.google.com with SMTP id q12-20020adfbb8c000000b001ea938f79e9so847802wrg.23
        for <linux-modules@vger.kernel.org>; Wed, 02 Mar 2022 09:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rd6aip8xWGW26J5sRuqwhGdbjTj2rP5btIv5QWD2Mkg=;
        b=YmdBPMNR58lvz9M9CYp7SCFMlzuX9+3T5SVaTu2D3+mGH14PsiSB4zBMszuiI0WkTo
         nmubGRX6Au8LxKs0AFjW7k+sJvWCBbxrDMorqPL4jWJJASxZc5n8tShyaigyCK9fNgek
         zzn6wwQdZmdlYrYofchU9g089D8R5n2dTZfIeEZCQrgNEvD4IagE1ZrLynNXnoqAvFXD
         eAh/k+gbvc8ZKczBzKzxdgUnaifD1iz9vvkNGkL3IG7voNyDAXITfREch05Si/KRLmbS
         J2lW8mazQChWjlBBiO+PatCX0AEMQYuTk9yKpm6acyxJk3iF0vZdRKM9DhpJmC9guwi4
         95WA==
X-Gm-Message-State: AOAM533oiiOxNNjjm55iRt6NlnD3GzU/x5e0gVt/A99GzWlt54wCclgY
        UGcl6iymBcuULvdeGgYaVBJmyXO1Yi3+Grwvt1fzJRFm/ZamwADsr7TD32B8G62iiH8kPt9m5FN
        t6GcfM59Usv0yBPzMvXtBQZrz
X-Received: by 2002:a5d:654e:0:b0:1f0:1a18:166c with SMTP id z14-20020a5d654e000000b001f01a18166cmr5974866wrv.28.1646240524763;
        Wed, 02 Mar 2022 09:02:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxMzcpyzOGWIlpDjbhmT42tQ9LNvh9Wvh8XJd5z++9TTyMj7rOAC+j4Bhyrzp6SUNSrhq6qw==
X-Received: by 2002:a5d:654e:0:b0:1f0:1a18:166c with SMTP id z14-20020a5d654e000000b001f01a18166cmr5974831wrv.28.1646240524459;
        Wed, 02 Mar 2022 09:02:04 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm6443457wmj.5.2022.03.02.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:02:03 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:02:02 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     pmladek@suse.com
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        atomlin@atomlin.com
Subject: Re: [PATCH v9 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220302170202.lsz2mqmll6gshuwr@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-11-atomlin@redhat.com>
 <20220301165229.5pwxyhxonbw5za3i@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301165229.5pwxyhxonbw5za3i@ava.usersys.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-03-01 16:52 +0000, Aaron Tomlin wrote:
> Petr,
> 
> Any concerns?
> 
> Unfortunately, I didn't make enough time to test.

Petr,

$ sudo ./test-livepatch.sh
[sudo] password for atomlin:
TEST: basic function patching ... ok
TEST: multiple livepatches ... ok
TEST: atomic replace livepatch ... ok

 - dmesg output excerpt

[  209.354909] ===== TEST: basic function patching =====
[  209.435376] % modprobe test_klp_livepatch
[  209.467226] test_klp_livepatch: tainting kernel with TAINT_LIVEPATCH
[  209.539749] livepatch: enabling patch 'test_klp_livepatch'
[  209.539785] livepatch: 'test_klp_livepatch': initializing patching transition
[  209.543671] livepatch: 'test_klp_livepatch': starting patching transition
[  210.716486] livepatch: 'test_klp_livepatch': completing patching transition
[  210.717405] livepatch: 'test_klp_livepatch': patching complete
[  210.766777] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  210.767446] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  210.767548] livepatch: 'test_klp_livepatch': starting unpatching transition
[  211.739802] livepatch: 'test_klp_livepatch': completing unpatching transition
[  211.778846] livepatch: 'test_klp_livepatch': unpatching complete
[  211.862102] % rmmod test_klp_livepatch


Kind regards,

-- 
Aaron Tomlin

